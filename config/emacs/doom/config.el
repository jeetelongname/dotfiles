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

(setq-default header-line-format
        (concat (propertize " " 'display '((space :align-to 0)))
                " "))

(let ((width  500)
      (height 250)
      (display-height (display-pixel-height))
      (display-width  (display-pixel-width)))
  (pushnew! initial-frame-alist
            `(left . ,(- (/ display-width 2) (/ width 2)))
            `(top . ,(- (/ display-height 2) (/ height 2)))
            `(width text-pixels ,width)
            `(height text-pixels ,height)))

(map!
 :n "z C-w" 'save-buffer ; I can use this onehanded which is nice when I need to leave or eat or something
 :leader
 :desc "Enable Coloured Values""t c" #'rainbow-mode
 :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode
 :desc "Open Elfeed""o l" #'elfeed


 (:after spell-fu (:map override ;; HACK spell-fu does not define a modemap
                   :n [return]
                   (cmds! (memq 'spell-fu-incorrect-face (face-at-point nil t))
                          #'+spell/correct))))

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))
;; this snippet can be replaced with `(after! magit (setq magit-save-repository-buffers t))'
;; (after! magit (add-hook! 'magit-status-mode-hook :append (call-interactively #'save-some-buffers)))

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(defun yeet/reload ()
  "A simple cmd to make reloading m config easier"
  (interactive)
  (load! "config" doom-private-dir)
  (message "Reloaded!"))

(map! :leader
      "h r c" #'yeet/reload)

(defvar yeet/paint-insert-prefix-dir (concat org-directory "pictures")
  "where to put the picture")
(defvar yeet/paint-ask t
  "Ask if you want to name the file if no it will be named you current buffer + picture")
(defvar yeet/paint-cmd "gnome-paint"
  "the program you want to use as your paint program")

(defun yeet/paint-insert()
  ""
  (interactive)
  (shell-command yeet/paint-cmd))

(defun henlo ()
  "henlo."
  (interactive)
  (message "\"henlo\""))
(henlo)

(defun stop ()
  (interactive)
  (defvar name "*I can quit at any time*")
  (switch-to-buffer (get-buffer-create name))
  (insert "I can stop at any time\nI am in control"))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(use-package! caddyfile-mode
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package! vimrc-mode
  :mode "\\.vim\\'"
  :config
  (sp-with-modes 'vimrc-mode
    (sp-local-pair "\"" :action nil)))

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(use-package! emacs-easy-hugo
  :after markdown
  :config
  (setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/"))

(use-package! peep-dired
  ;; :after dired
  :defer t
  :config
  (setq peep-dired-cleanup-on-disable t)
  (map! (:after dired (:map dired-mode-map
                       :n "j" #'peep-dired-next-file
                       :n "k" #'peep-dired-prev-file
                       :localleader
                       "p" #'peep-dired))))

(use-package! nyan-mode
  :defer t
  :config
  (setq nyan-bar-length 20
        nyan-wavy-trail t))

(use-package! parrot
  :defer t
  :config
  (parrot-set-parrot-type 'rotating))
;; (defvar birds '('default 'confused 'emacs 'nyan 'rotating 'science 'thumbsup)) ; FIXME
;; (parrot-set-parrot-type (nth (random (length birds)) birds)))


(after! doom-modeline
  (nyan-mode)
  (nyan-start-animation)
  (parrot-mode)
  (parrot-start-animation))

(when (daemonp)
  (use-package! discord-emacs ;; for face value discord intergration
    :config
    ;; (discord-emacs-run "747913611426529440") ;;mine
    (discord-emacs-run "384815451978334208"))) ;;default

(use-package! dired-dragon
  :after dired
  :config
  (map! :map dired-mode-map
        (:prefix "C-s"
         :n "d" #'dired-dragon
         :n "s" #'dired-dragon-stay
         :n "i" #'dired-dragon-individual)))

(use-package! tldr
  :config
  (setq tldr-directory-path (expand-file-name "tldr/" doom-etc-dir))
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

(use-package! eaf
  :defer t
  :config
  ;; (setq eaf-enable-debug t) ; should only be used when eaf is wigging out
  (eaf-setq eaf-browser-dark-mode "false") ; dark mode is overrated
  (setq eaf-browser-default-search-engine "duckduckgo")
  (eaf-setq eaf-browse-blank-page-url "https://duckduckgo.com"))

(use-package! eaf-evil ;; evil bindings in my browser
  :after eaf
  :config
  (setq eaf-evil-leader-keymap doom-leader-map)
  (setq eaf-evil-leader-key "SPC"))

(use-package! carbon-now-sh
  :config
  (defun yeet/carbon-use-eaf ()
    (interactive)
    (split-window-right)
    (let ((browse-url-browser-function 'eaf-open-browser))
      (browse-url (concat carbon-now-sh-baseurl "?code="
                          (url-hexify-string (carbon-now-sh--region))))))
  (map! :n "g C-c" #'yeet/carbon-use-eaf))

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

(use-package! snow
  :config
  (set-popup-rule! "^\\*snow\\*$" :ignore t :modeline nil)) ;; FIXME does not work

(defun yeet/sidebar ()
  "Wrappoer for multiple sidebars
there will be more..."
  (interactive)
  (require 'dired-sidebar)
  (require 'ibuffer-sidebar)
  (ibuffer-sidebar-toggle-sidebar)
  (dired-sidebar-toggle-sidebar)) ;; order matters

(after! dired (add-hook! 'dired-sidebar-mode-hook (doom-modeline-mode -1)))

(use-package dired-sidebar
  :defer t
  :config
  (setq dired-sidebar-use-custom-modeline t
        dired-sidebar-should-follow-file t))
(map! :leader "o p" nil :leader "o p" #'yeet/sidebar)

(use-package! ibuffer-sidebar
  :defer t)

(use-package! org-sidebar
  :after org)

(after! company
  (setq company-idle-delay 0.7 ; I like my autocomplete like my tea fast not oftern but still there
        ;; company-minimum-prefix-length 2
        company-show-numbers t))

(after! ivy
  (setq ivy-height 20
        ivy-wrap nil
        ivy-magic-slash-non-match-action t)
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus)))

(setq-default history-length 10000)
(setq-default prescient-history-length 10000)

(setq! doom-font
       (font-spec :family "Iosevka" :size 16)
       doom-big-font
       (font-spec :family "Iosevka" :size 25)
       doom-variable-pitch-font
       (font-spec :family "LibreBaskerville" :size 17))

(after! doom-themes
  (setq! doom-themes-enable-bold t
         doom-themes-enable-italic t
         doom-horizon-brighter-comments t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; (require 'rose-pine-theme-moon)
(if (not (daemonp))
    (if (not (display-graphic-p))
        (setq doom-theme 'horizon)
      (setq doom-theme 'doom-horizon))
  (setq doom-theme 'doom-horizon))

(setq fancy-splash-image (concat doom-private-dir "icons/emacs-icon.png"))

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Get back to work")))

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
    '(objed-state misc-info persp-name grip irc mu4e github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process checker vcs "  " bar)))

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook! 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(custom-set-faces! '(doom-modeline-persp-name :foreground "#e95678" :weight bold ))

;; (set-popup-rule! ".+"
;;   :side 'right
;;   :width 90
;;   :actions '+popup-display-buffer-stacked-side-window-fn
;;   :quit t)
;; (set-popup-rule! "COMMIT_EDITMSG"
;;   :side 'top
;;   :height 20)

(when (featurep! :ui tabs)
  (after! centaur-tabs
    (setq centaur-tabs-style "box"
          centaur-tabs-height 32
          centaur-tabs-set-bar 'under
          x-underline-at-descent-line t
          centaur-tabs-close-button "×"
          centaur-tabs-modified-marker "Ø")))

(after! treemacs
  (setq +treemacs-git-mode 'extended
        treemacs-width 30))

(after! dap-mode
  (setq dap-auto-configure-features '(sessions locals controls tooltip)
        dap-python-executable "python3"))

(add-hook 'dap-stopped-hook
          (lambda () (call-interactively #'dap-hydra)))

(map! :leader "od" nil
      :leader "od" #'dap-debug
      :leader "dt" #'dap-breakpoint-toggle)

(setq dired-dwim-target t)

(set-eshell-alias!
 "cls" "clear")

(setq org-directory "~/org-notes/")
(after! org
  (setq
        org-agenda-files (list org-directory)
        org-hide-emphasis-markers t)

  (when (featurep! :lang org +pretty) ;; I used to use the +pretty flag but I now don't thus the `when'
    (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
          org-superstar-headline-bullets-list '("⁕" "܅" "⁖" "⁘" "⁙" "⁜"))))

(custom-set-faces!
  '(org-date :foreground "#5b6268")
  '(org-document-title :height 1.75 :weight bold)
  '(org-level-1 :foreground "#21bfc2" :height 1.3 :weight normal)
  '(org-level-2 :foreground "#6c6f93" :height 1.1 :weight normal)
  '(org-level-3 :foreground "#b877db" :height 1.0 :weight normal)
  '(org-level-4 :foreground "#58cfd1":height 1.0 :weight normal)
  '(org-level-5 :foreground "#9093ae":weight normal)
  '(org-level-6 :foreground "#90dfe0":weight normal))

(after! org-capture
    (setq org-capture-templates
      '(("x" "Note" entry (file+olp+datetree "journal.org") "**** %T %?" :prepend t :kill-buffer t)
        ("t" "Task" entry (file+headline "tasks.org" "Inbox") "**** TODO %U %?\n%i" :prepend t :kill-buffer t)
        ("b" "Blog" entry (file+headline "blog-ideas.org" "Ideas") "**** TODO  %?\n%i" :prepend t :kill-buffer t)
        ("U" "UTCR" entry (file+headline "UTCR-TODO.org" "Tasks") "**** TODO %?\n%i" :prepend t :kill-buffer t))))

(setq org-roam-directory (concat org-directory "roam/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db"))

(after! go-mode ;; I have stopped using ligatures so this is not useful to me but it can be to you!
  (set-ligatures! 'go-mode
                  :def "func"
                  :true "true" :false "false"
                  :int "int" :str "string"
                  :float "float" :bool "bool"
                  :for "for"
                  :return "return" )
  )
(setq-hook! 'go-mode-hook
  lsp-enable-file-watchers nil)

(setq! +python-ipython-command '("ipython3" "-i" "--simple-prompt" "--no-color-info"))
(set-repl-handler! 'python-mode #'+python/open-ipython-repl)

(setq +latex-viewers '(pdf-tools))

(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)

(setenv "HTML_TIDY" (expand-file-name "tidy.conf" doom-private-dir))
(setq +format-on-save-enabled-modes
      '(not web-mode))

(set-email-account! "gmail"
                    '((mu4e-sent-folder       . "/gmail/\[Gmail\]/Sent Mail")
                      (mu4e-drafts-folder     . "/gmail/\[Gmail\]/Drafts")
                      (mu4e-trash-folder      . "/gmail/\[Gmail\]/Trash")
                      (mu4e-refile-folder     . "/gmail/\[Gmail\]/All Mail")
                      (smtpmail-smtp-user     . "jeetelongname@gmail.com"))t)

(after! mu4e
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

(custom-set-faces! '(mu4e-replied-face :foreground "#e95678" :inherit font-lock-builtin-face))

(after! circe
  (set-irc-server! "chat.freenode.net"
                   '(:tls t
                     :port 6697
                     :nick "yeetaditya"
                     :sasl-username ,"yeetadita"
                     :sasl-password (+pass-get-secret "social/freenode")
                     :channels ("#emacs"))))

(after! elfeed
  (setq elfeed-search-filter "@1-week-ago")
  (setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org"))) ;; +org
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update))

;; (use-package! elfeed-goodies
;;   :config
;;   (elfeed-goodies/setup))
