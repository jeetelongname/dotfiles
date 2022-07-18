;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Don't edit this file directly unless you like your changes being wiped

(message "in config")
(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com" ;; god I can't wait to get away from gmail
      doom-scratch-initial-major-mode 'lisp-interaction-mode
      auth-sources '("~/.authinfo.gpg")
      ispell-dictionary "en"
      display-line-numbers-type 'relative ;; this is a reminder that I should try and use relative actions more
      browse-url-browser-function 'browse-url-firefox)

(when (boundp 'native-comp-async-jobs-number)
  (setq native-comp-async-jobs-number 9))

(when (boundp 'pgtk-wait-for-event-timeout)
  (setq pgtk-wait-for-event-timeout 0.001))

(setq doom-leader-alt-key "C-,")

;; (setq-default header-line-format (concat (propertize battery-mode-line-format 'display '((space :align-to 0))) " ")))

(add-load-path! "lisp")

(map!
 :n "z C-w" 'save-buffer ; I can use this onehanded which is nice when I need to leave or eat or something
 :g "C-`" #'+workspace/other ; faster than SPC w `
 :leader
 :desc "Enable Coloured Values" "t c" #'rainbow-mode
 :desc "Toggle Tabs" "t B" #'centaur-tabs-local-mode
 :desc "Open Elfeed" "o l" #'=rss
 :desc "Open Irc" "o c" #'=irc
 ;; I recompile more than I compile
 "cc" #'recompile
 "cC" #'compile)

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)

(map! :leader
      "h r c" #'yeet/reload)

(defun ar/consult-apple-search ()
  "Ivy interface for dynamically querying apple.com docs."
  (interactive)
  (require 'request)
  (require 'json)
  (require 'url-http)
  (consult--read "apple docs: "
            (lambda (input)
              (let* ((url (url-encode-url (format "https://developer.apple.com/search/search_data.php?q=%s" input)))
                     (c1-width (round (* (- (window-width) 9) 0.3)))
                     (c2-width (round (* (- (window-width) 9) 0.5)))
                     (c3-width (- (window-width) 9 c1-width c2-width)))
                (let ((request-curl-options (list "-H" (string-trim (url-http-user-agent-string)))))
                   (request url
                     :type "GET"
                     :parser 'json-read
                     :success (cl-function
                               (lambda (&key data &allow-other-keys)
                                 (ivy-update-candidates
                                  (mapcar (lambda (item)
                                            (let-alist item
                                              (propertize
                                               (format "%s   %s   %s"
                                                       (truncate-string-to-width (propertize (or .title "")
                                                                                             'face '(:foreground "yellow")) c1-width nil ?\s "…")
                                                       (truncate-string-to-width (or .description "") c2-width nil ?\s "…")
                                                       (truncate-string-to-width (propertize (string-join (or .api_ref_data.languages "") "/")
                                                                                             'face '(:foreground "cyan1")) c3-width nil ?\s "…"))
                                               'url .url)))
                                          (cdr (car data)))))))
                   0)))
            ;; :action (lambda (selection)
            ;;           (browse-url (concat "https://developer.apple.com"
            ;;                               (get-text-property 0 'url selection))))
            ;; :dynamic-collection t
            ;; :caller 'ar/counsel-apple-search)
  ))

(map! :leader
      "w C-t" nil
      "w C-t" #'toggle-window-split)

(defvar yeet/insert-cat-width nil
  "the width of the cats")

(defun yeet/insert-cat ()
  (interactive)
  (insert-before-markers
   (shell-command-to-string
    (format "jp2a --width= %s https://cataas.com/cat" (if yeet/insert-cat-width
                                                          yeet/insert-cat-width
                                                        60)))))

(defmacro with-temp-buffer! (&rest BODY)
  "A wrapper around `with-temp-buffer' that implicitly calls `buffer-string'
This is in an effort to streamline a very common usecase"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
     (progn ,@BODY)
     (buffer-string)))

;; I plan on upstreamin this.
(defmacro thread-as (initial-form var &rest forms)
  "Thread INITIAL-FORM through FORMS as VAR to there successor.
Example:
     (thread-as
       5
       my-var
       (+ my-var 20)
       (/ 25 my-var)
       (+ my-var 40))
Is equivalent to:
     (+ (/ 25 (+ 5 20)) 40 )
Note that unlike the other threading macro's that every call needs to
explicitly use the variable."
  `(let* ,(mapcar (lambda (form)
                    (list var form))
                  (cons initial-form forms))
     ,var))

(thread-as 3 my-var (+ 2 my-var) (+ 4 my-var))

(display-time-mode +1)

(global-subword-mode +1)

(use-package! type-break
  :defer
  :config
  (setq type-break-interval 1800 ;; half an hour between type breaks
        type-break-keystroke-threshold (cons 2000  14000))
  (type-break-mode 1))

(display-battery-mode 1)

(defvar yeet/birds '(default confused emacs nyan rotating science thumbsup))

(use-package! nyan-mode
  :after doom-modeline
  :config
  (setq nyan-bar-length 15
        nyan-wavy-trail t)
  (nyan-mode +1)
  (nyan-start-animation))

(use-package! parrot
  :defer t
  :config
  (parrot-set-parrot-type (nth (random (length yeet/birds)) yeet/birds)) ;; this chooses a random bird on startup
  (parrot-mode +1)
  (parrot-start-animation))

;; (add-to-list 'marginalia-prompt-categories '("bird" . bird))

(defun bird-annotations (cand)
  "Takes a CANDidate (which is a bird) and returns a description of said bird"
  (let ((yeet/birds+annotations (-zip-pairs yeet/birds '("default bird is best bird"
                                                         "they have got the spirit"
                                                         "EMACS BIRD EMACS BIRD"
                                                         "nananananan"
                                                         "you spin me right round right round like a record baby"
                                                         "science bitch!"
                                                         "He is just happy to be here"))))
    (cdr (assoc cand yeet/birds+annotations))))

;; (add-to-list 'marginalia-annotator-registry '(bird bird-annotations))

(defun yeet/sidebar-toggle ()
  "toggle both ibuffer and dired sidebars"
  (interactive)
  (ibuffer-sidebar-toggle-sidebar)
  (dired-sidebar-toggle-sidebar))

(map! :leader "o p" nil
      :leader "o p" #'dired-sidebar-toggle-sidebar ;; this is more useful most of the time
      :leader "o P" #'yeet/sidebar-toggle) ;; this is when I need too do some buffer management

;; (after! dired-sidebar (add-hook! 'dired-sidebar-mode-hook (doom-modeline-mode -1)))

(use-package! dired-sidebar
  :defer t
  :commands dired-sidebar-toggle-sidebar
  :config
  (setq dired-sidebar-use-custom-modeline t
        dired-sidebar-should-follow-file t))

(use-package! ibuffer-sidebar
  :commands ibuffer-sidebar-toggle-sidebar
  :defer t)

(use-package! org-sidebar
  :after org)

(add-hook! (prog-mode text-mode) #'flymake-mode)

(after! lsp-mode
  (setq lsp-diagnostics-provider :flymake))

(use-package! flymake-popon
  :hook (flymake-mode . flymake-popon-mode))

(use-package! flymake-vale
  :hook ((text-mode       . flymake-vale-load)
         (latex-mode      . flymake-vale-load)
         (org-mode        . flymake-vale-load)
         (markdown-mode   . flymake-vale-load)
         (message-mode    . flymake-vale-load)))

(add-hook! 'org-msg-mode-hook
  (setq flymake-vale-file-ext ".org")
  (flymake-vale-load))

(add-hook! 'flymake-mode-hook
  (defun +emacs-lisp-reduce-flymake-errors-in-emacs-config-h ()
    (when (and (bound-and-true-p flymake-mode)
             (eq major-mode 'emacs-lisp-mode)
             (or (not default-directory)
                 (null (buffer-file-name (buffer-base-buffer)))
                 (cl-find-if (doom-partial #'file-in-directory-p default-directory)
                             +emacs-lisp-disable-flycheck-in-dirs)))
      (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-checkdoc))))

(use-package! dired-dragon
  :after dired
  :config
  (map! :map dired-mode-map
        (:prefix "C-s"
         :n "d" #'dired-dragon
         :n "s" #'dired-dragon-stay
         :n "i" #'dired-dragon-individual)))

(use-package! carbon-now-sh
  :config
  (defun yeet/carbon-use-eaf ()
    (interactive)
    (split-window-right)
    (let ((browse-url-browser-function 'browse-url-firefox))
      (browse-url (concat carbon-now-sh-baseurl "?code="
                          (url-hexify-string (carbon-now-sh--region))))))
  (map! :n "g C-c" #'yeet/carbon-use-eaf))

;; (use-package! screenshot :defer)

(use-package! aas)

(use-package! lexic
  :commands lexic-search lexic-list-dictionary
  :config
  (map! :map lexic-mode-map
        :n "q" #'lexic-return-from-lexic
        :nv "RET" #'lexic-search-word-at-point
        :n "a" #'outline-show-all
        :n "h" (cmd! (outline-hide-sublevels 3))
        :n "o" #'lexic-toggle-entry
        :n "n" #'lexic-next-entry
        :n "N" (cmd! (lexic-next-entry t))
        :n "p" #'lexic-previous-entry
        :n "P" (cmd! (lexic-previous-entry t))
        :n "E" (cmd! (lexic-return-from-lexic) ; expand
                     (switch-to-buffer (lexic-get-buffer)))
        :n "M" (cmd! (lexic-return-from-lexic) ; minimise
                     (lexic-goto-lexic))
        :n "C-p" #'lexic-search-history-backwards
        :n "C-n" #'lexic-search-history-forwards
        :n "/" (cmd! (call-interactively #'lexic-search))))

(defadvice! +lookup/dictionary-definition-lexic (identifier &optional arg)
  "Look up the definition of the word at point (or selection) using `lexic-search'."
  :override #'+lookup/dictionary-definition
  (interactive
   (list (or (doom-thing-at-point-or-region 'word)
             (read-string "Look up in dictionary: "))
         current-prefix-arg))
  (lexic-search identifier nil nil t))

(use-package! company-org-block
  :after org
  :config
  (setq company-org-block-edit-style 'auto))

(after! org
  (set-company-backend! 'org-mode-hook '(company-org-block company-capf))

  ;; (setq org-babel-load-languages
  ;;       '((elisp   . t)
  ;;         (python  . t)
  ;;         (ruby    . t)
  ;;         (haskell . t)
  ;;         (scheme  . t)
  ;;         (latex   . t)))
  )

(use-package! org-pandoc-import :after org)

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! org-modern :defer t)

(use-package! org-remark
   :defer t
   :init
   (map! :g "C-c n m" #'org-remark-mark
         (:after org-remark
          (:map org-remap-mode-map
           (:prefix "C-c n"
            :g "o" #'org-remark-open
            :g "]" #'org-remark-view-next
            :g "[" #'org-remark-view-previous
            :g "r" #'org-remark-remove)))))

(use-package! nameless
  :defer t
  :hook (emacs-lisp-mode-hook . nameless-mode)
  :config
  (setq nameless-global-aliases '(("d" . "doom"))
        nameless-private-prefix t)

  (map! :map emacs-lisp-mode-map
        :localleader
        "i" #'nameless-insert-name))

(after! sql
  (add-to-list 'sql-connection-alist
               '(psql (sql-product 'postgres)
                      (sql-port 22)
                      (sql-server (read-from-minibuffer "server ip: ")))))

(use-package! caddyfile-mode
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package! vimrc-mode
  :mode "\\.vim$\\'"
  :config)
;; (sp-local-pair 'vimrc-mode "\"" nil :actions :rem))

(use-package! feature-mode
  :mode "\\.feature$\\'")

(use-package! janet-mode
  :mode "\\.janet$\\'")

(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/reading/calibre"
        calibredb-db-dir   (expand-file-name "metadata.db" calibredb-root-dir))
  ;; the view for all books
  (map! :map calibredb-search-mode-map
        :ne "?" #'calibredb-entry-dispatch
        :ne "a" nil
        :ne "a" #'calibredb-add
        :ne "A" nil
        :ne "A" #'calibredb-add-dir
        :ne "." #'calibredb-open-dired
        :ne "e" #'calibredb-export-dispatch
        :ne "m" #'calibredb-mark-at-point
        :ne "o" #'calibredb-find-file
        :ne "O" #'calibredb-find-file-other-frame
        :ne "q" #'calibredb-search-quit
        :ne "s" nil
        :ne "s" #'calibredb-sort-dispatch
        :ne "S" #'calibredb-set-metadata-dispatch
        :ne "u" #'calibredb-unmark-at-point
        :ne "V" #'calibredb-open-file-with-default-tool
        :ne [tab] #'calibredb-toggle-view-at-point)
  ;; the veiw for one book
  (map! :map calibredb-show-mode-map
        :ne [mouse-3] #'calibredb-search-mouse
        :ne "RET" #'calibredb-find-file
        :ne "?" #'calibredb-dispatch
        :ne "a" #'calibredb-add
        :ne "A" #'calibredb-add-dir
        :ne "c" #'calibredb-clone
        :ne "d" #'calibredb-remove
        :ne "D" #'calibredb-remove-marked-items
        :ne "j" #'calibredb-next-entry
        :ne "k" #'calibredb-previous-entry
        :ne "l" #'calibredb-virtual-library-list
        :ne "L" #'calibredb-library-list
        :ne "n" #'calibredb-virtual-library-next
        :ne "N" #'calibredb-library-next
        :ne "p" #'calibredb-virtual-library-previous
        :ne "P" #'calibredb-library-previous
        :ne "s" #'calibredb-set-metadata-dispatch
        :ne "S" #'calibredb-switch-library
        :ne "o" #'calibredb-find-file
        :ne "O" #'calibredb-find-file-other-frame
        :ne "v" #'calibredb-view
        :ne "V" #'calibredb-open-file-with-default-tool
        :ne "." #'calibredb-open-dired
        :ne "b" #'calibredb-catalog-bib-dispatch
        :ne "e" #'calibredb-export-dispatch
        :ne "r" #'calibredb-search-refresh-and-clear-filter
        :ne "R" #'calibredb-search-clear-filter
        :ne "q" nil
        :ne "q" #'calibredb-search-quit
        :ne "m" #'calibredb-mark-and-forward
        :ne "f" #'calibredb-toggle-favorite-at-point
        :ne "x" #'calibredb-toggle-archive-at-point
        :ne "h" #'calibredb-toggle-highlight-at-point
        :ne "u" #'calibredb-unmark-and-forward
        :ne "i" #'calibredb-edit-annotation
        :ne "DEL" #'calibredb-unmark-and-backward
        :ne [backtab] #'calibredb-toggle-view
        :ne [tab] #'calibredb-toggle-view-at-point
        :ne "M-n" #'calibredb-show-next-entry
        :ne "M-p" #'calibredb-show-previous-entry
        :ne "/" #'calibredb-search-live-filter
        :ne "M-t" #'calibredb-set-metadata--tags
        :ne "M-a" #'calibredb-set-metadata--author_sort
        :ne "M-A" #'calibredb-set-metadata--authors
        :ne "M-T" #'calibredb-set-metadata--title
        :ne "M-c" #'calibredb-set-metadata--comments))

(defun +book/quit ())

(defun =book ()
  (interactive)
  (if (featurep! :ui workspaces)
      (progn
        (+workspace-switch "*book*" t)
        (doom/switch-to-scratch-buffer)
        (calibredb)
        (+workspace/display))
    (calibredb)))

;; I read books more than I read files in my buffer
(map! :leader
      "ob" nil
      "ob" #'=book
      "oB" #'browse-url-of-file)

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (add-hook! 'nov-mode-hook #'olivetti-mode ;; Centers the text making it easier to read
    (mixed-pitch-mode +1)
    (defun yeet/nov-setup ()
      (setq-local olivetti-body-width 125))))

(after! olivetti)

(use-package! tldr
  :config
  (setq tldr-directory-path (expand-file-name "tldr/" doom-etc-dir)) ;; don't be cluttering my work tree
  (setq tldr-enabled-categories '("common" "linux")))

(use-package elfeed-tube
  :after elfeed
  :config
  (setq elfeed-tube-auto-fetch-p t) ;;  t is auto-fetch (default)
  (elfeed-tube-setup)

  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))

;; center the board
(add-hook! 'tetris-mode-hook
           (defun yeet/center-tetris ()
             (setq-local olivetti-body-width 102)
             (olivetti-mode +1)))

(map! :after tetris
      :map tetris-mode-map
      :n "g" #'tetris-move-bottom
      :n "n" #'tetris-start-game
      :n "p" #'tetris-pause-game)

(when (daemonp)
  (use-package! elcord ;; FIXME: flatpak discord can't pick up the calls :(
    :config
    (defun yeet/elcord-buffer-info ()
      "Get the buffer name or whether we are editing it or not and return a formatted string."
      (format "%s %s" (if buffer-read-only
                          "Reading"
                        "Editing")
              (buffer-name)))

    (setq elcord-quiet t
          elcord-use-major-mode-as-main-icon nil
          elcord-show-small-icon t
          elcord-buffer-details-format-function #'yeet/elcord-buffer-info)

    (elcord-mode +1)))

(after! company
  (setq company-idle-delay 6 ; I like my autocomplete like my tea. Mostly made by me but appreciated when someone else makes it for me
        ;; company-minimum-prefix-length 2
        company-show-numbers t))

(after! ivy
  (setq ivy-height 20
        ivy-wrap nil
        ivy-magic-slash-non-match-action t)
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus)))

(setq-default history-length 10000)
(setq-default prescient-history-length 10000)

(defvar-local consult-toggle-preview-orig nil)

(defun consult-toggle-preview ()
  "Command to enable/disable preview."
  (interactive)
  (if consult-toggle-preview-orig
      (setq consult--preview-function consult-toggle-preview-orig
            consult-toggle-preview-orig nil)
    (setq consult-toggle-preview-orig consult--preview-function
          consult--preview-function #'ignore)))

;; Bind to `vertico-map' or `selectrum-minibuffer-map'
(after! vertico
  (define-key vertico-map (kbd "M-o c") #'consult-toggle-preview))

(defun yeet/face-annotator (cand)
  "Annotate faces with dummy text and face documentation"
  (when-let (sym (intern-soft cand))
    (marginalia--fields
     ("The Quick Brown Fox Jumped Over The Lazy Dog" :face sym)
     ((documentation-property sym 'face-documentation)
      :truncate marginalia-truncate-width :face 'marginalia-documentation))))

(after! marginalia
  (add-to-list 'marginalia-annotator-registry
               '(face yeet/face-annotator marginalia-annotate-face builtin none)))

(after! evil
  (setq evil-split-window-below  t
        evil-vsplit-window-right t
        evil-disable-insert-state-bindings t
        evil-want-fine-undo t))

;; Change out fonts quickly
 (setq yeet/font-name "Iosevka")

 (setq! doom-font (font-spec :family yeet/font-name :size 16)
        doom-big-font (font-spec :family yeet/font-name :size 25)
        doom-variable-pitch-font (font-spec :family "Merriweather" :size 17))

;; HACK to get rid of weird black circles in mu4e screen.
 (delete "Noto Emoji" doom-emoji-fallback-font-families)
 (delete "Noto Color Emoji" doom-emoji-fallback-font-families)

(after! doom-themes
  (setq! doom-themes-enable-bold t
         doom-themes-enable-italic t
         doom-horizon-brighter-comments t
         doom-flatwhite-brighter-modeline t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme (if (or (daemonp) (display-graphic-p))
                     'doom-horizon
                   'horizon))

(use-package! tao-theme ; messing around with tao
  :defer
  :config
  (setq tao-theme-use-sepia t
        tao-theme-sepia-depth 50))

;; (setq doom-theme 'tao-yang)

(setq fancy-splash-image "~/code/other/doom-banners/splashes/emacs/emacs-gnu-logo.png")

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Get back to work")))

(defvar phrase-api-url
  (nth (random 3)
       '(("https://corporatebs-generator.sameerkumar.website/" :phrase)
         ("https://useless-facts.sameerkumar.website/api" :data)
         ("https://dev-excuses-api.herokuapp.com/" :text))))

(defmacro phrase-generate-callback (token &optional format-fn ignore-read-only callback buffer-name)
  `(lambda (status)
     (unless (plist-get status :error)
       (goto-char url-http-end-of-headers)
       (let ((phrase (plist-get (json-parse-buffer :object-type 'plist) (cadr phrase-api-url)))
             (inhibit-read-only ,(when (eval ignore-read-only) t)))
         (setq phrase-last (cons phrase (float-time)))
         (with-current-buffer ,(or (eval buffer-name) (buffer-name (current-buffer)))
           (save-excursion
             (goto-char (point-min))
             (when (search-forward ,token nil t)
               (with-silent-modifications
                 (replace-match "")
                 (insert ,(if format-fn format-fn 'phrase)))))
           ,callback)))))

(defvar phrase-last nil)
(defvar phrase-timeout 5)

(defmacro phrase-insert-async (&optional format-fn token ignore-read-only callback buffer-name)
  `(let ((inhibit-message t))
     (if (and phrase-last
              (> phrase-timeout (- (float-time) (cdr phrase-last))))
         (let ((phrase (car phrase-last)))
           ,(if format-fn format-fn 'phrase))
       (url-retrieve (car phrase-api-url)
                     (phrase-generate-callback ,(or token "\ufeff") ,format-fn ,ignore-read-only ,callback ,buffer-name))
       ;; For reference, \ufeff = Zero-width no-break space / BOM
       ,(or token "\ufeff"))))

(defun doom-dashboard-phrase ()
  (phrase-insert-async
   (progn
     (setq-local phrase-position (point))
     (mapconcat
      (lambda (line)
        (+doom-dashboard--center
         +doom-dashboard--width
         (with-temp-buffer
           (insert-text-button
            line
            'action
            (lambda (_)
              (setq phrase-last nil)
              (+doom-dashboard-reload t))
            'face 'doom-dashboard-menu-title
            'mouse-face 'doom-dashboard-menu-title
            'help-echo "Random phrase"
            'follow-link t)
           (buffer-string))))
      (split-string
       (with-temp-buffer
         (insert phrase)
         (setq fill-column (min 70 (/ (* 2 (window-width)) 3)))
         (fill-region (point-min) (point-max))
         (buffer-string))
       "\n")
      "\n"))
   nil t
   (progn
     (goto-char phrase-position)
     (forward-whitespace 1))
   +doom-dashboard-name))

(defadvice! doom-dashboard-widget-loaded-with-phrase ()
  :override #'doom-dashboard-widget-loaded
  (setq line-spacing 0.2)
  (insert
   "\n\n"
   (propertize
    (+doom-dashboard--center
     +doom-dashboard--width
     (doom-display-benchmark-h 'return))
    'face 'doom-dashboard-loaded)
   "\n"
   (doom-dashboard-phrase)
   "\n"))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

(after! hl-todo
  (add-to-list 'hl-todo-keyword-faces `("DONE" org-done bold)))

;; (set-popup-rule! "\\*info*\\" :side 'right)

(after! doom-modeline
  (setq doom-modeline-buffer-file-name-style 'auto
        doom-modeline-height 30
        doom-modeline-icon t
        doom-modeline-modal-icon nil
        doom-modeline-env-version t
        doom-modeline-buffer-modification-icon t
        doom-modeline-enable-word-count t
        doom-modeline-continuous-word-count-modes '(text-mode)
        doom-modeline-icon (display-graphic-p)
        doom-modeline-persp-name t
        doom-modeline-persp-icon t
        doom-modeline-github t
        doom-modeline-mu4e t))

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
    '(misc-info vcs persp-name grip irc mu4e github debug repl lsp minor-modes input-method indent-info buffer-encoding checker major-mode process " " bar " ")))

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook! 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(custom-set-faces! `(doom-modeline-persp-name :foreground ,(doom-color 'red) :weight bold )
  `(doom-modeline-buffer-modified   :foreground ,(doom-color 'orange))
  `(doom-modeline-buffer-major-mode :foreground ,(doom-color 'blue)))

(after! treemacs
  (setq +treemacs-git-mode 'extended
        treemacs-width 30))

(defadvice! rigor/which-key-show-workspace (orig-fun &rest pages-obj)
  "Show my workspaces in the echo thingy"
  :around #'which-key--process-page
  (let ((out (apply orig-fun pages-obj))
        (prefix-title (which-key--pages-prefix-title (car pages-obj))))
    (if (not (string-equal prefix-title "workspace"))
        out
      (cons (car out)
            (lambda ()
              (funcall (cdr out))
              (which-key--echo (concat (current-message) " " (+workspace--tabline))))))))

(map! :leader "TAB TAB" nil
      :leader "TAB TAB" #'+workspace/switch-to)

(custom-set-faces! `(eros-result-overlay-face
                     :foreground ,(doom-color 'violet)))

(after! eros
  (setq eros-eval-result-prefix "->  "))

(map! :leader "gw" #'magit-worktree)

(setq lsp-enable-file-watchers nil)

;; I also don't want suggested servers
(after! lsp-mode
  (setq lsp-enable-suggest-server-download nil))

(after! (pdf-tools doom-modeline)
  (doom-modeline-def-segment pdf-icon
    (concat
     (doom-modeline-spc)
     (doom-modeline-icon 'octicon "file-pdf" nil nil
                         :face (if (doom-modeline--active)
                                   'all-the-icons-red
                                 'mode-line-inactive)
                         :v-adjust 0.02)))

  (doom-modeline-def-segment buffer-name
    (concat
     (doom-modeline-spc)
     (doom-modeline--buffer-name)))

  (defun doom-modeline-update-pdf-pages ()
    "Update PDF pages."
    (setq doom-modeline--pdf-pages
          (concat " P"
                  (number-to-string (eval `(pdf-view-current-page)))
                  (propertize (concat "/" (number-to-string (pdf-cache-number-of-pages))) 'face 'doom-modeline-buffer-minor-mode))))

  (doom-modeline-def-segment pdf-pages
    "Display PDF pages."
    (if (doom-modeline--active) doom-modeline--pdf-pages
      (propertize doom-modeline--pdf-pages 'face 'mode-line-inactive)))

  (doom-modeline-def-modeline 'pdf
    '(bar window-number matches pdf-pages pdf-icon buffer-name)
    '(misc-info major-mode process vcs))

  (defun doom-set-pdf-modeline-h ()
    "sets the pdf modeline"
    (doom-modeline-set-modeline 'pdf))

  (add-hook! 'pdf-view-mode-hook 'doom-set-pdf-modeline-h))

(after! evil
  (evil-ex-define-cmd "run" #'+tmux:run))

(after! tree-sitter
  (pushnew! tree-sitter-major-mode-language-alist
            '(scss-mode . css)))

(after! evil-textobj-tree-sitter
  (pushnew! evil-textobj-tree-sitter-major-mode-language-alist
            '(scss-mode . css)))

(use-package! hideshow-tree-sitter :after tree-sitter)
(use-package! tree-sitter-playground
  :after tree-sitter
  :config
  (setq tree-sitter-playground-jump-buttons t
        tree-sitter-playground-highlight-jump-region t))

(custom-set-faces!  `(tree-sitter-hl-face:function.call :foreground ,(doom-color 'blue)))

(after! evil-textobj-tree-sitter
  (map! (:map +tree-sitter-outer-text-objects-map
         "m" (+tree-sitter-get-textobj "import"
                                       '((python-mode . [(import_statement) @import])
                                         (rust-mode . [(use_declaration) @import]))))))

(setq dired-dwim-target t)

(add-hook! 'dired-mode-hook #'dired-hide-details-mode)

;; (setq-hook! 'dired-mode-hook
;;   header-line-format (concat (propertize )))

(set-eshell-alias!
 "cls" "clear") ; this is what I use in my regular shell

(defun yeet/current-git-branch ()
  "liteally just to change the format string"
  (let ((fstring " (%s)"))
    (cl-destructuring-bind (status . output)
        (doom-call-process "git" "symbolic-ref" "-q" "--short" "HEAD")
      (if (equal status 0)
          (format fstring output)
        (cl-destructuring-bind (status . output)
            (doom-call-process "git" "describe" "--all" "--always" "HEAD")
          (if (equal status 0)
              (format fstring output)
            ""))))))

(defun yeet/prompt-function ()
  (concat tramp-default-host ":"
          (format-time-string "(%a %d)")
          (yeet/current-git-branch)
          (propertize " ᐅ" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))

;; (setq eshell-prompt-function #'yeet/prompt-function)
;; (setq eshell-prompt-regexp "\\.+:\\(\\.+\\)\\.+ᐅ ")

(map! (:after spell-fu
       (:map override ;; HACK spell-fu does not define a modemap
        :n [return]
        (cmds! (memq 'flymake-error-face (face-at-point nil t))
               #'+spell/correct))))

(add-to-list '+emacs-lisp-disable-flycheck-in-dirs "~/code/emacs/tutorial")

(setq org-directory "~/org-notes/")
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "NEXT(n)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "+DAY(+)" "TODAY(T)" "BLOG(B)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](b)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))

  (setq org-agenda-files (seq-map
                          (lambda (x)
                            (concat org-directory x))
                          '("tasks.org" "blog-ideas.org" "hitlist.org")) ;; FIXME make it more specific
        org-hide-emphasis-markers nil ;; this makes org feel more like a proper document and less like a mark up format
        org-startup-with-latex-preview t)

  (when (featurep! :lang org +pretty) ;; I used to use the +pretty flag but I now don't thus the `when'
    (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
          org-superstar-headline-bullets-list '("⁕" "܅" "⁖" "⁘" "⁙" "⁜"))))

(custom-set-faces!
  `(org-date :foreground ,(doom-color 'violet))
  '(org-document-title :height 1.75 :weight bold)
  `(org-level-1 :foreground ,(doom-color 'blue) :height 1.3 :weight normal)
  `(org-level-2 :foreground ,(doom-color 'grey) :height 1.1 :weight normal)
  `(org-level-3 :foreground ,(doom-color 'violet) :height 1.0 :weight normal)
  `(org-level-4 :foreground ,(doom-color 'cyan)   :height 1.0 :weight normal)
  `(org-level-5 :foreground ,(doom-color 'grey) :weight normal)
  `(org-level-6 :foreground ,(doom-color 'blue) :weight normal))

(after! org-capture
  (setq org-capture-templates
        '(("n" "Note" entry (file+olp+datetree "slipbox.org") "**** %T %?" :prepend t :kill-buffer t)
          ("t" "Task" entry (file+headline "tasks.org" "Inbox") "**** TODO %U %?\n%i" :prepend t :kill-buffer t)
          ("b" "Blog" entry (file+headline "blog-ideas.org" "Ideas") "**** +DAY  %?\n%i" :prepend t :kill-buffer t)
          ("U" "UTCR" entry (file+headline "UTCR-TODO.org" "Tasks") "**** TODO %?\n%i" :prepend t :kill-buffer t))))

;; (use-package! org-cook
;;   :after org)

(setq org-roam-directory (concat org-directory "roam/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db"))

(defadvice! yeet/org-roam-in-own-workspace-a (&rest _)
  "Open all roam buffers in there own workspace."
  :before #'org-roam-node-find
  :before #'org-roam-node-random
  :before #'org-roam-buffer-display-dedicated
  :before #'org-roam-buffer-toggle
  (when (featurep! :ui workspaces)
    (+workspace-switch "*roam*" t)))

(after! org-journal
  (setq org-journal-enable-encryption t
        org-journal-encrypt-journal t))

(use-package! org-super-agenda
  :commands org-super-agenda-mode)

(after! org-agenda
  (org-super-agenda-mode))

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)

(after! org-agenda
  (setq org-agenda-custom-commands
        '(("o" "Overview"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :date today
                            :todo "TODAY"
                            :scheduled today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Next to do"
                             :todo "NEXT"
                             :order 1)
                            (:name "Due Today"
                             :deadline today
                             :order 2)
                            (:name "Important"
                             :tag "Important"
                             :priority "A"
                             :order 6)
                            (:name "Overdue"
                             :deadline past
                             :scheduled past
                             :face error
                             :order 7)
                            (:name "Due Soon"
                             :deadline future
                             :order 8)
                            (:name "University"
                             :tag "uni"
                             :order 10)
                            (:name "Issues"
                             :tag "issue"
                             :order 12)
                            (:name "Projects"
                             :todo "PROJ"
                             :tag "project"
                             :order 14)
                            (:name "Back Burner"
                             :order 40
                             :todo "+DAY"
                             :todo "BLOG")
                            (:name "Trivial"
                             :priority<= "E"
                             :tag ("Trivial" "Unimportant")
                             :order 90)
                            (:discard (:tag ("chore" "routine" "Daily"))))))))))))

(after! go-mode ;; I have stopped using ligatures so this is not useful to me but it can be to you!
  (when (featurep! :ui ligatures)
    (set-ligatures! 'go-mode
                    :def "func"
                    :true "true" :false "false"
                    :int "int" :str "string"
                    :float "float" :bool "bool"
                    :for "for"
                    :return "return" )))

(setq-hook! 'go-mode-hook
  lsp-enable-file-watchers nil)

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "ormolu"))

(setq! +python-ipython-command '("ipython3" "-i" "--simple-prompt" "--no-color-info"))
(set-repl-handler! 'python-mode #'+python/open-ipython-repl)

(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

(setq +latex-viewers '(pdf-tools zathura)) ;; don't be going to those filthy third party apps

(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)

(setenv "HTML_TIDY" (expand-file-name "tidy.conf" doom-private-dir))
(setq +format-on-save-enabled-modes
      '(not web-mode))

(map! (:map 'scss-mode-map
       :localleader
       "b" nil
       (:prefix ("s" . "sass")
        "b" #'yeet/scss-build
        "c" #'yeet/scss-start
        "C" #'yeet/scss-stop)))

(remove-hook! '(scss-mode-local-vars-hook
                sass-mode-local-vars-hook)
  #'lsp!)

(after! circe
  (set-irc-server! "irc.eu.libera.chat"
    `(:tls t
      :port 6697
      :nick "jeetelongname"
      :sasl-username "jeetelongname"
      :sasl-password ,(+pass-get-secret "social/freenode")
      :channels ("#emacs" "#haskell" "#doomemacs"))))

(after! elfeed
  (setq elfeed-search-filter "@4-week-ago -fun") ;; /they post so much/

  (setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org"))) ;; +org
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update)) ; update on entry

(after! elfeed-goodies
  (setq elfeed-goodies/powerline-default-separator 'bar))

(defadvice! yeet/open-content-in-eww-a (orig-fun &rest args)
  :around #'elfeed-search-browse-url
  (let ((browse-url-browser-function #'eww-browse-url))
    (funcall orig-fun args)))

;; (map! (:map elfeed-show-mode-map
;;        :n "gc" nil
;;        :n "gc" #'yeet/elfeed-copy-link))

(set-email-account! "gmail"
                    '((mu4e-sent-folder       . "/gmail/\[Gmail\]/Sent Mail")
                      (mu4e-drafts-folder     . "/gmail/\[Gmail\]/Drafts")
                      (mu4e-trash-folder      . "/gmail/\[Gmail\]/Trash")
                      (mu4e-refile-folder     . "/gmail/\[Gmail\]/All Mail")
                      (smtpmail-smtp-user     . "jeetelongname@gmail.com"))t)

(after! mu4e
  (setq mu4e-mu-version "1.6.11")
  (setq smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 25))

(setq sendmail-program (executable-find "msmtp")
      send-mail-function #'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function #'message-send-mail-with-sendmail)

(map! (:map org-msg-edit-mode-map
       :n "<tab>" #'org-msg-tab
       :localleader
       (:prefix "m"
        "k" #'org-msg-edit-kill-buffer
        "s" #'message-goto-subject
        "b" #'org-msg-goto-body
        "a" #'org-msg-attach)))

(after! mu4e
  (setq
   ;; org-msg-default-alternatives '(html)
   org-msg-greeting-fmt "\nHi *%s*,\n\n"
   org-msg-signature "\nRegards,
 #+begin_signature
 -- *Jeetaditya Chatterjee* \\\\
 /Sent using my text editor/
 #+end_signature"))

(custom-set-faces! `(mu4e-replied-face :foreground ,(doom-color 'red) :inherit font-lock-builtin-face))

;; (after! emacs-everywhere
;;   (add-hook! 'emacs-everywhere-init-hooks 'markdown-mode)
;;   (remove-hook! 'emacs-everywhere-init-hooks 'org-mode))

(defvar +literate-tangle--proc nil)
(defvar +literate-tangle--proc-start-time nil)

(defadvice! +literate-tangle-async-h ()
  "A very simplified version of `+literate-tangle-h', but async."
  :override #'+literate-tangle-h
  (unless (getenv "__NOTANGLE")
    (let ((default-directory doom-private-dir))
      (when +literate-tangle--proc
        (message "Killing outdated tangle process...")
        (set-process-sentinel +literate-tangle--proc #'ignore)
        (kill-process +literate-tangle--proc)
        (sit-for 0.3)) ; ensure the message is seen for a bit
      (setq +literate-tangle--proc-start-time (float-time)
            +literate-tangle--proc
            (start-process "tangle-config"
                           (get-buffer-create " *tangle config*")
                           "emacs" "--batch" "--eval"
                           (format "(progn \
(require 'ox) \
(require 'ob-tangle) \
(setq org-confirm-babel-evaluate nil \
      org-inhibit-startup t \
      org-mode-hook nil \
      write-file-functions nil \
      before-save-hook nil \
      after-save-hook nil \
      vc-handled-backends nil \
      org-startup-folded nil \
      org-startup-indented nil) \
(org-babel-tangle-file \"%s\" \"%s\"))"
                                   +literate-config-file
                                   (expand-file-name (concat doom-module-config-file ".el")))))
      (set-process-sentinel +literate-tangle--proc #'+literate-tangle--sentinel)
      (run-at-time nil nil (lambda () (message "Tangling config.org"))) ; ensure shown after a save message
      "Tangling config.org...")))

(defun +literate-tangle--sentinel (process signal)
  (cond
   ((and (eq 'exit (process-status process))
         (= 0 (process-exit-status process)))
    (message "Tangled config.org sucessfully (took %.1fs)"
             (- (float-time) +literate-tangle--proc-start-time))
    (setq +literate-tangle--proc nil))
   ((memq (process-status process) (list 'exit 'signal))
    (+popup-buffer (get-buffer " *tangle config*"))
    (message "Failed to tangle config.org (after %.1fs)"
             (- (float-time) +literate-tangle--proc-start-time))
    (setq +literate-tangle--proc nil))))

(defun +literate-tangle-check-finished ()
  (when (and (process-live-p +literate-tangle--proc)
             (yes-or-no-p "Config is currently retangling, would you please wait a few seconds?"))
    (switch-to-buffer " *tangle config*")
    (signal 'quit nil)))

(add-hook! 'kill-emacs-hook #'+literate-tangle-check-finished)
