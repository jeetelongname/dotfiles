;;; ../../.dotfiles/doom/.config/doom/+mu4e.el -*- lexical-binding: t; -*-

(after! mu4e
  (defun my-string-width (str)
    "Return the width in pixels of a string in the current
window's default font. If the font is mono-spaced, this
will also be the width of all other printable characters."
    (let ((window (selected-window))
          (remapping face-remapping-alist))
      (with-temp-buffer
        (make-local-variable 'face-remapping-alist)
        (setq face-remapping-alist remapping)
        (set-window-buffer window (current-buffer))
        (insert str)
        (car (window-text-pixel-size)))))


  (cl-defun mu4e~normalised-icon (name &key set colour height v-adjust)
    "Convert :icon declaration to icon"
    (let* ((icon-set (intern (concat "all-the-icons-" (or set "faicon"))))
           (v-adjust (or v-adjust 0.02))
           (height (or height 0.8))
           (icon (if colour
                     (apply icon-set `(,name :face ,(intern (concat "all-the-icons-" colour)) :height ,height :v-adjust ,v-adjust))
                   (apply icon-set `(,name  :height ,height :v-adjust ,v-adjust))))
           (icon-width (my-string-width icon))
           (space-width (my-string-width " "))
           (space-factor (- 2 (/ (float icon-width) space-width))))
      (concat (propertize " " 'display `(space . (:width ,space-factor))) icon)
      ))

  (defun mu4e~initialise-icons ()
    (setq mu4e-use-fancy-chars t
          mu4e-headers-draft-mark      (cons "D" (mu4e~normalised-icon "pencil"))
          mu4e-headers-flagged-mark    (cons "F" (mu4e~normalised-icon "flag"))
          mu4e-headers-new-mark        (cons "N" (mu4e~normalised-icon "sync" :set "material" :height 0.8 :v-adjust -0.10))
          mu4e-headers-passed-mark     (cons "P" (mu4e~normalised-icon "arrow-right"))
          mu4e-headers-replied-mark    (cons "R" (mu4e~normalised-icon "arrow-right"))
          mu4e-headers-seen-mark       (cons "S" (mu4e~normalised-icon "eye" :height 0.6 :v-adjust 0.07 :colour "dsilver"))
          mu4e-headers-trashed-mark    (cons "T" (mu4e~normalised-icon "trash"))
          mu4e-headers-attach-mark     (cons "a" (mu4e~normalised-icon "file-text-o" :colour "silver"))
          mu4e-headers-encrypted-mark  (cons "x" (mu4e~normalised-icon "lock"))
          mu4e-headers-signed-mark     (cons "s" (mu4e~normalised-icon "certificate" :height 0.7 :colour "dpurple"))
          mu4e-headers-unread-mark     (cons "u" (mu4e~normalised-icon "eye-slash" :v-adjust 0.05))))

  (if (display-graphic-p)
      (mu4e~initialise-icons)
    ;; When it's the server, wait till the first graphical frame
    (add-hook! 'server-after-make-frame-hook
      (defun mu4e~initialise-icons-hook ()
        (when (display-graphic-p)
          (mu4e~initialise-icons)
          (remove-hook #'mu4e~initialise-icons-hook))))))


(after! mu4e

  (defun mu4e-header-colourise (str)
    (let* ((str-sum (apply #'+ (mapcar (lambda (c) (% c 3)) str)))
           (colour (nth (% str-sum (length mu4e-header-colourised-faces))
                        mu4e-header-colourised-faces)))
      (put-text-property 0 (length str) 'face colour str)
      str))

  (defvar mu4e-header-colourised-faces
    '(all-the-icons-lblue
      all-the-icons-purple
      all-the-icons-blue-alt
      all-the-icons-green
      all-the-icons-maroon
      all-the-icons-yellow
      all-the-icons-orange))

  (setq mu4e-headers-fields
        '((:account . 8)
          (:human-date . 8)
          (:flags . 6)
          (:from . 25)
          (:folder . 10)
          (:recipnum . 2)
          (:subject))
        mu4e-headers-date-format "%d/%m/%y"
        mu4e-headers-time-format "%T")

  (plist-put (cdr (assoc :flags mu4e-header-info)) :shortname " Flags") ; default=Flgs
  (setq mu4e-header-info-custom
        '((:account .
           (:name "Account" :shortname "Account" :help "Which account this email belongs to" :function
            (lambda (msg)
              (let ((maildir
                     (mu4e-message-field msg :maildir)))
                (mu4e-header-colourise (replace-regexp-in-string "^gmail" (propertize "g" 'face 'bold-italic)
                                                                 (format "%s"
                                                                         (substring maildir 1
                                                                                    (string-match-p "/" maildir 1)))))))))
          (:human-date .
           (:name "Human Date" :shortname "Date" :help "The date that the email was recived" :function
            (lambda (msg)
              (let ((maildir
                     (mu4e-message-field msg :maildir)))
                (mu4e-header-colourise)))))

          (:folder .
           (:name "Folder" :shortname "Folder" :help "Lowest level folder" :function
            (lambda (msg)
              (let ((maildir
                     (mu4e-message-field msg :maildir)))
                (mu4e-header-colourise (replace-regexp-in-string "\\`.*/" "" maildir))))))
          (:recipnum .
           (:name "Number of recipients"
            :shortname "#"
            :help "Number of recipients for this message"
            :function
            (lambda (msg)
              (propertize (format "%2d"
                                  (+ (length (mu4e-message-field msg :to))
                                     (length (mu4e-message-field msg :cc))))
                          'face 'mu4e-footer-face)))))))



(after! mu4e
  (defvar mu4e-min-header-frame-width 120
    "Minimum reasonable with for the header view.")
  (defun mu4e-widen-frame-maybe ()
    "Expand the frame with if it's less than `mu4e-min-header-frame-width'."
    (when (< (frame-width) mu4e-min-header-frame-width)
      (set-frame-width (selected-frame) mu4e-min-header-frame-width)))
  (add-hook 'mu4e-headers-mode-hook #'mu4e-widen-frame-maybe))

(map! :map mu4e-headers-mode-map
      :after mu4e
      :v "*" #'mu4e-headers-mark-for-something
      :v "!" #'mu4e-headers-mark-for-read
      :v "?" #'mu4e-headers-mark-for-unread
      :v "u" #'mu4e-headers-mark-for-unmark)
(defadvice! mu4e~main-action-prettier-str (str &optional func-or-shortcut)
  "Highlight the first occurrence of [.] in STR.
If FUNC-OR-SHORTCUT is non-nil and if it is a function, call it
when STR is clicked (using RET or mouse-2); if FUNC-OR-SHORTCUT is
a string, execute the corresponding keyboard action when it is
clicked."
  :override #'mu4e~main-action-str
  (let ((newstr
         (replace-regexp-in-string
          "\\[\\(..?\\)\\]"
          (lambda(m)
            (format "%s"
                    (propertize (match-string 1 m) 'face '(mode-line-emphasis bold))))
          (replace-regexp-in-string "\t\\*" "\t⚫" str)))
        (map (make-sparse-keymap))
        (func (if (functionp func-or-shortcut)
                  func-or-shortcut
                (if (stringp func-or-shortcut)
                    (lambda()(interactive)
                      (execute-kbd-macro func-or-shortcut))))))
    (define-key map [mouse-2] func)
    (define-key map (kbd "RET") func)
    (put-text-property 0 (length newstr) 'keymap map newstr)
    (put-text-property (string-match "[A-Za-z].+$" newstr)
                       (- (length newstr) 1) 'mouse-face 'highlight newstr)
    newstr))

(setq evil-collection-mu4e-end-region-misc "quit")
