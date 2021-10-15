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

;; (setq-default header-line-format
;;         (concat (propertize " " 'display '((space :align-to 0))) " "))

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

(defmacro with-temp-buffer! (&rest BODY)
  "A wrapper around `with-temp-buffer' that implicitly calls `buffer-string'
This is in an effort to streamline a very common usecase"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
    (progn ,@BODY)
    (buffer-string)))

(use-package! type-break
  :defer
  :config
  (setq type-break-interval 1800 ;; half an hour between type breaks
        type-break-keystroke-threshold (cons 2000  14000))
  (type-break-mode 1))

(use-package! caddyfile-mode
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package! vimrc-mode
  :mode "\\.vim$\\'"
  :config)
;; (sp-local-pair 'vimrc-mode "\"" nil :actions :rem))

(use-package! feature-mode
  :mode "\.feature$")

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

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(use-package! emacs-easy-hugo
  :after markdown
  :config
  (setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/"))

(defvar birds '(default confused emacs nyan rotating science thumbsup))

(use-package! nyan-mode
  :defer t
  :config
  (setq nyan-bar-length 15
        nyan-wavy-trail t))

(use-package! parrot
  :defer t
  :config
  (parrot-set-parrot-type (nth (random (length birds)) birds))) ;; this chooses a random bird on startup


(after! doom-modeline
  (nyan-mode)
  (nyan-start-animation)
  (parrot-mode)
  (parrot-start-animation))

;; (add-to-list 'marginalia-prompt-categories '("bird" . bird))

(defun bird-annotations (cand)
  "Takes a CANDidate (which is a bird) and returns a description of said bird"
  (let ((birds+annotations (-zip-pairs birds '("default bird is best bird"
                                          "they have got the spirit"
                                          "EMACS BIRD EMACS BIRD"
                                          "nananananan"
                                          "you spin me right round right round like a record baby"
                                          "science bitch!"
                                          "He is just happy to be here"))))
    (cdr (assoc cand birds+annotations))))

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
  (use-package! elcord
    :config
    (setq elcord-quiet t
          elcord-use-major-mode-as-main-icon t
          elcord-show-small-icon nil)

    (elcord-mode +1))) ;; elcord is a noisy bitch. I don't need all of the output

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

(use-package! keycast
  :commands keycast-mode
  :after doom-modeline
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
                  :weight bold))
  (map! :leader "tk" #'keycast-mode))

(use-package! power-mode
  :defer t)

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
       (font-spec :family "Input" :size 17))

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
  (setq tao-theme-use-sepia nil))

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

(use-package hideshow-tree-sitter :after tree-sitter)

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
  (setq org-agenda-files (mapcar
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
                   '(:tls t
                     :port 6697
                     :nick "jeetelongname"
                     :sasl-username ,"jeetelongname"
                     :sasl-password (+pass-get-secret "social/freenode")
                     :channels ("#emacs" "#haskell"))))

(after! elfeed
  (setq elfeed-search-filter "@3-week-ago -fun") ;; /they post so much/

  (setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org"))) ;; +org
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update)) ; update on entry

(after! elfeed-goodies
  (setq elfeed-goodies/powerline-default-separator 'bar))

;; (map! (:map elfeed-show-mode-map
;;        :n "gc" nil
;;        :n "gc" #'yeet/elfeed-copy-link))

(after! emacs-everywhere
  (add-hook! 'emacs-everywhere-init-hooks 'markdown-mode)
  (remove-hook! 'emacs-everywhere-init-hooks 'org-mode))
