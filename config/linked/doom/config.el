;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Don't edit this file directly unless you like your changes being wiped

(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com" ;; god I can't wait to get away from gmail
      doom-scratch-initial-major-mode 'lisp-interaction-mode
      auth-sources '("~/.authinfo.gpg")
      ispell-dictionary "en"
      display-line-numbers-type 'relative ;; this is a reminder that I should try and use relative actions more
      browse-url-browser-function 'browse-url-firefox)

(when (boundp 'native-comp-async-jobs-number)
  (setq native-comp-async-jobs-number 9))

(setq pgtk-wait-for-event-timeout 0.001)

  ;; (setq-default header-line-format (concat (propertize battery-mode-line-format 'display '((space :align-to 0))) " ")))

(add-load-path! "lisp")

(map!
 :n "z C-w" 'save-buffer ; I can use this onehanded which is nice when I need to leave or eat or something
 :g "C-`" #'+workspace/other
 :leader
 :desc "Enable Coloured Values""t c" #'rainbow-mode
 :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode
 :desc "Open Elfeed""o l" #'elfeed
 ;; I recompile more than I compile
 "cc" #'recompile
 "cC" #'compile)

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))
;; this snippet can be replaced with `(after! magit (setq magit-save-repository-buffers t))'
;; (after! magit (add-hook! 'magit-status-mode-hook :append (call-interactively #'save-some-buffers)))

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map! :leader
      "h r c" #'yeet/reload)

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

(display-time-mode +1)

(global-subword-mode +1)

(use-package! type-break
  :defer
  :config
  (setq type-break-interval 1800 ;; half an hour between type breaks
        type-break-keystroke-threshold (cons 2000  14000))
  (type-break-mode 1))

(display-battery-mode 1)

(use-package! caddyfile-mode
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package! vimrc-mode
  :mode "\\.vim$\\'"
  :config)
;; (sp-local-pair 'vimrc-mode "\"" nil :actions :rem))

(use-package! feature-mode
  :mode "\\.feature$\\'")

(use-package! nameless
  :defer t
  :hook (emacs-lisp-mode-hook . nameless-mode)
  :config
  (setq nameless-global-aliases '(("d" . "doom"))
        nameless-private-prefix t)

  (map! :map emacs-lisp-mode-map
        :localleader
        "i" #'nameless-insert-name))

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

(use-package! janet-mode
  :mode "\\.janet$\\'")

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(use-package! emacs-easy-hugo
  :after markdown
  :config
  (setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/"))

(defvar yeet/birds '(default confused emacs nyan rotating science thumbsup))

(use-package! nyan-mode
  :after doom-modeline
  :config
  (setq nyan-bar-length 15
        nyan-wavy-trail t)
  (nyan-mode)
  (nyan-start-animation))

(use-package! parrot
  :defer t
  :config
  (parrot-set-parrot-type (nth (random (length yeet/birds)) yeet/birds)) ;; this chooses a random bird on startup
  (parrot-mode)
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

(use-package! dired-dragon
  :after dired
  :config
  (map! :map dired-mode-map
        (:prefix "C-s"
         :n "d" #'dired-dragon
         :n "s" #'dired-dragon-stay
         :n "i" #'dired-dragon-individual)))

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

(use-package! tldr
  :config
  (setq tldr-directory-path (expand-file-name "tldr/" doom-etc-dir)) ;; don't be cluttering my work tree
  (setq tldr-enabled-categories '("common" "linux")))

(use-package! atomic-chrome
  :after-call focus-out-hook
  :config
  (setq atomic-chrome-buffer-open-style 'frame
        atomic-chrome-default-major-mode 'markdown-mode
        atomic-chrome-url-major-mode-alist
        '(("github.\\.com" . gfm-mode)
          ("reddit\\.com" . fundamental-mode)))

  (atomic-chrome-start-server))

(use-package! hackernews :defer t)

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

(after! sql
  (add-to-list 'sql-connection-alist
               '(psql (sql-product 'postgres)
                      (sql-port 22)
                      (sql-server (read-from-minibuffer "server ip: ")))))

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

(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/reading/calibre"
        calibredb-db-dir   (expand-file-name "metadata.db" calibredb-root-dir))
  ;; the view for all books
  (map! :map calibredb-search-mode-map
        :ne "?" #'calibredb-entry-dispatch
        :ne "." #'calibredb-open-dired
        :ne "e" #'calibredb-export-dispatch
        :ne "m" #'calibredb-mark-at-point
        :ne "o" #'calibredb-find-file
        :ne "O" #'calibredb-find-file-other-frame
        :ne "q" #'calibredb-entry-quit
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
             (defun yeet/nov-setup ()
               (setq olivetti-body-width 125))))

(after! olivetti)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

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

(setq evil-split-window-below  t
      evil-vsplit-window-right t)

(setq! doom-font
       (font-spec :family "Iosevka" :size 16)
       doom-big-font
       (font-spec :family "Iosevka" :size 25)
       doom-variable-pitch-font
       (font-spec :family "Merriweather" :size 17))

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

;; (set-popup-rule! "\\*info*\\" :side 'right)

(after! doom-modeline
  (setq doom-modeline-buffer-file-name-style 'auto
        doom-modeline-height 30
        doom-modeline-icon 't
        doom-modeline-modal-icon 'nil
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
    '(objed-state misc-info vcs persp-name grip irc mu4e github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process checker " " bar " ")))

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

(setq lsp-enable-file-watchers nil)

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

(use-package! hideshow-tree-sitter :after tree-sitter)
(use-package! tree-sitter-playground
  :after tree-sitter
  :config
  (setq tree-sitter-playground-jump-buttons t
        tree-sitter-playground-highlight-jump-region t))

(custom-set-faces!  `(tree-sitter-hl-face:function.call :foreground ,(doom-color 'blue)))

(setq dired-dwim-target t)

(add-hook! 'dired-mode-hook #'dired-hide-details-mode)

;; (setq-hook! 'dired-mode-hook
;;   header-line-format (concat (propertize )))

(set-eshell-alias!
 "cls" "clear") ; this is what I use in my regular shell

(map! (:after spell-fu
       (:map override ;; HACK spell-fu does not define a modemap
        :n [return]
        (cmds! (memq 'spell-fu-incorrect-face (face-at-point nil t))
               #'+spell/correct))))

(setq org-directory "~/org-notes/")
(after! org
  (setq org-agenda-files (seq-map
                          (lambda (x)
                            (concat org-directory x))
                          '("tasks.org" "blog-ideas.org" "hitlist.org")) ;; FIXME make it more specific
        org-hide-emphasis-markers nil) ;; this makes org feel more like a proper document and less like a mark up format

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
        '(("x" "Note" entry (file+olp+datetree "journal.org") "**** %T %?" :prepend t :kill-buffer t)
          ("t" "Task" entry (file+headline "tasks.org" "Inbox") "**** TODO %U %?\n%i" :prepend t :kill-buffer t)
          ("b" "Blog" entry (file+headline "blog-ideas.org" "Ideas") "**** TODO  %?\n%i" :prepend t :kill-buffer t)
          ("U" "UTCR" entry (file+headline "UTCR-TODO.org" "Tasks") "**** TODO %?\n%i" :prepend t :kill-buffer t))))

;; (use-package! org-cook
;;   :after org)

(setq org-roam-directory (concat org-directory "roam/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db"))

(after! org-journal
  (setq org-journal-enable-encryption t
        org-journal-encrypt-journal t))

(use-package! org-super-agenda
  :defer t
  :config
  (setq org-super-agenda-groups
         '(;; Each group has an implicit boolean OR operator between its selectors.
           (:name "Today"  ; Optionally specify section name
            :time-grid t  ; Items that appear on the time grid
            :todo "TODO")  ; Items that have this TODO keyword
           (:name "Important"
            ;; Single arguments given alon
            :tag "bills"
            :priority "A")
           ;; Groups supply their own section names when none are given
           (:todo "WAITING" :order 8)  ; Set order of this section
           (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
            ;; Show this group at the end of the agenda (since it has the
            ;; highest number). If you specified this group last, items
            ;; with these todo keywords that e.g. have priority A would be
            ;; displayed in that group instead, because items are grouped
            ;; out in the order the groups are listed.
            :order 9    )
           (:priority<= "B"
            ;; Show this section after "Today" and "Important", becaus  e
            ;; their order is unspecified, defaulting to 0. Sections
            ;; are displayed lowest-number-first.
            :order 1))
         org-agenda-start-day "0d"
         org-agenda-span 1))

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

(set-email-account! "gmail"
                    '((mu4e-sent-folder       . "/gmail/\[Gmail\]/Sent Mail")
                      (mu4e-drafts-folder     . "/gmail/\[Gmail\]/Drafts")
                      (mu4e-trash-folder      . "/gmail/\[Gmail\]/Trash")
                      (mu4e-refile-folder     . "/gmail/\[Gmail\]/All Mail")
                      (smtpmail-smtp-user     . "jeetelongname@gmail.com"))t)

(after! mu4e
  (setq mu4e-mu-version "1.6.6")
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

(after! circe
  (set-irc-server! "irc.eu.libera.chat"
                   `(:tls t
                     :port 6697
                     :nick "jeetelongname"
                     :sasl-username ,"jeetelongname"
                     :sasl-password ,(+pass-get-secret "social/freenode")
                     :channels ("#emacs" "#haskell" "#doomemacs"))))

(after! elfeed
  (setq elfeed-search-filter "@3-week-ago -fun") ;; /they post so much/

  (setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org"))) ;; +org
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update)) ; update on entry

(after! elfeed-goodies
  (setq elfeed-goodies/powerline-default-separator 'bar))

;; (map! (:map elfeed-show-mode-map
;;        :n "gc" nil
;;        :n "gc" #'yeet/elfeed-copy-link))

;; (after! emacs-everywhere
;;   (add-hook! 'emacs-everywhere-init-hooks 'markdown-mode)
;;   (remove-hook! 'emacs-everywhere-init-hooks 'org-mode))
