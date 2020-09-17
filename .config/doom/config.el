;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      doom-scratch-initial-major-mode 'lisp-interaction-mode
      auth-sources '("~/.authinfo.gpg")
      ispell-dictionary "en"
      display-line-numbers-type 'relative
      browse-url-browser-function 'browse-url-firefox)

(global-auto-revert-mode t)

(setq evil-split-window-below  t
      evil-vsplit-window-right t)

(setq fancy-splash-image (concat doom-private-dir "icons/emacs-icon.png"))

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")

(use-package! discord-emacs ;; for face value discord intergration
  :config
  ;; (discord-emacs-run "747913611426529440") ;;mine
  (discord-emacs-run "384815451978334208") ;;default
  )

(use-package! keycast
  :commands keycast-mode
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (progn
          (add-hook 'pre-command-hook 'keycast-mode-line-update t)
          (add-to-list 'global-mode-string '("" mode-line-keycast " ")))
      (remove-hook 'pre-command-hook 'keycast-mode-line-update)
      (setq global-mode-string (remove '("" mode-line-keycast " ") global-mode-string))))
  (custom-set-faces!
    '(keycast-command :inherit doom-modeline-debug
                      :height 0.9)
    '(keycast-key :inherit custom-modified
                  :height 1.1
                  :weight bold)))
;; (map! :leader
;;       :desc "t k" #'keycast-mode)

(after! company
  (setq company-idle-delay 0.3 ; I like my autocomplete like my tea fast and always
        company-minimum-prefix-length 2)
  (setq company-show-numbers t))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(after! ivy
  (setq ivy-height 20
        ivy-wrap nil
        ivy-magic-slash-non-match-action t))

(after! ivy-postframe
  (setq ivy-posframe-border-width 20
        ivy-posframe-parameters '((left-fringe . 8)(right-fringe . 8))
        ivy-posframe-height-alist '((swiper . 20)(t . 40)))
(ivy-posframe-display-at-frame-top-center))

(setq org-directory "~/org-notes/")
(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5b6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :background nil
                      :height 1.75
                      :weight 'bold)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
        org-superstar-headline-bullets-list '("⁕" "܅" "⁖" "⁘" "⁙" "⁜")))

(after! org-capture
    (setq org-capture-templates
      '(("x" "Note" entry  (file+olp+datetree "journal.org") "**** %T %?" :prepend t :kill-buffer t)
        ("t" "Task" entry (file+headline "tasks.org" "Inbox") "**** TODO %U %?\n%i" :prepend t :kill-buffer t))))

(after! go-mode
  (set-ligatures! 'go-mode
    :def "func"
    :true "true" :false "false"
    :int "int" :str "string"
    :float "float" :bool "bool"
    :for "for"
    :return "return" :yeild "yeild"))

(setq! +python-ipython-command '("ipython3" "-i" "--simple-prompt" "--no-color-info"))

(setq doom-font (font-spec
       :family "Inconsolata NF"
       :size 15)
      doom-big-font (font-spec
       :family "Inconsolata NF"
       :size 25)
      doom-variable-pitch-font (font-spec
       :family "Inconsolata NF"
       :size 15))

(setq doom-theme 'doom-horizon)
;; (setq doom-theme 'doom-horizon-light-theme)

(setq +doom-dashboard-name "«doom»")

(after! doom-modeline
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-height 3
      doom-modeline-icon 't
      doom-modeline-modal-icon 'nil
      doom-modeline-env-version t
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-enable-word-count t
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
      doom-modeline-icon(display-graphic-p)
      doom-modeline-persp-name t
      doom-modeline-persp-icon t))

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(after! centaur-tabs
   (setq centaur-tabs-style "box"
     centaur-tabs-height 32
     centaur-tabs-set-bar 'under
     x-underline-at-descent-line t
     centaur-tabs-close-button "×"
     centaur-tabs-modified-marker "Ø"))
;; (use-package! centaur-tabs
;;  :config
;;  (centaur-tabs-headline-match)
;;  (setq centaur-tabs-style "box"
;;        centaur-tabs-height 32
;;        centaur-tabs-set-bar 'under
;;        x-underline-at-descent-line t
;;        centaur-tabs-close-button "×"
;;        centaur-tabs-modified-marker "Ø")
;;  )

(setq +treemacs-git-mode 'extended
      treemacs-width 30)

(after! mu4e
  (setq +mu4e-backend 'offlineimap
        mail-user-agent 'mu4e-user-agent
        mu4e-view-use-gnus t))

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

(set-email-account! "gmail.com"
                    '((mu4e-sent-folder       . "/gmail.com/Sent Mail")
                      (mu4e-drafts-folder     . "/gmail.com/Drafts")
                      (mu4e-trash-folder      . "/gmail.com/Trash")
                      (mu4e-refile-folder     . "/gmail.com/All Mail")
                      (smtpmail-smtp-user     . "jeetelongname@gmail.com")
                      (user-mail-address      . "jeetelongname@gmail.com")
                      )t)

(map! :localleader ; HACK ; works but is now in all org buffers
      :map org-mode-map :prefix "m"
      :desc "send and exit" "s" #'message-send-and-exit
      :desc "kill buffer"   "d" #'message-kill-buffer
      :desc "save draft"    "S" #'message-dont-send
      :desc "attach"        "a" #'mail-add-attachment)

(use-package! org-msg
  :config
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t"
        org-msg-startup "hidestars indent inlineimages"
        org-msg-greeting-fmt "\nHi *%s*,\n\n"
        org-msg-greeting-name-limit 3
        org-msg-text-plain-alternative t
        org-msg-signature "
 Regards,

 #+begin_signature
 -- *Jeetaditya Chatterjee* \\\\
 /Sent using my text editor/
 #+end_signature")
 (org-msg-mode))

(after! elfeed
  (setq elfeed-search-filter "@1-week-ago")
  (setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org"))) ;; +org
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update))

;; (use-package! elfeed-goodies
;;   :config
;;   (elfeed-goodies/setup))

(map!
 :n "z C-w" 'save-buffer ; = :w ZZ = :wq handy
 :leader
  :desc "Enable Coloured Values""t c" #'rainbow-mode
  :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode
  :desc "Open Elfeed""o l" #'elfeed

  (:after dired (:map dired-mode-map
        :n "j" #'peep-dired-next-file
        :n "k" #'peep-dired-prev-file
        :localleader
        "p" #'peep-dired))

  (:after spell-fu (:map override ;; HACK spell-fu does not define a modemap
        :n [return]
        (cmds! (memq 'spell-fu-incorrect-face (face-at-point nil t))
             #'+spell/correct))))

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(defvar yeet/paint-insert-prefix-dir (concat org-directory "pictures")
  "where to put the picture")
(defvar yeet/paint-ask t
  "Ask if you want to name the file if no it will be named you current buffer + picture")
(defvar yeet/paint-cmd "gnome-paint"
  "the program you want to use as your paint program")

(defun yeet/paint-insert()
  ""
  (interactive)
  (shell-command yeet/paint-cmd)
  )
