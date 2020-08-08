;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; personal settings
(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      doom-theme 'doom-horizon); pretty self explanitory
;;
;; move to the split after making it (tbh should be a default)
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq fancy-splash-image
      (concat doom-private-dir "icons/emacs-icon.png"))

(setq display-line-numbers-type 'relative
      company-idle-delay 0.3 ; i like my autocomplete like my tea fast and always
      prettify-symbols-mode t
)

;; fonts
(setq doom-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 15)
      doom-big-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 20)
      doom-variable-pitch-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 15)
      ;; doom-unicode-font
      ;; (font-spec
      ;;  :family "Ligconsolata Regular"
      ;;  :size 15)
)

;;org
(setq org-directory "~/org-notes/")

;; golang
(after! go-mode
  (set-pretty-symbols! 'go-mode
    :def "func"
    :true "true" :false "false"
    :int "int" :str "string"
    :float "float" :bool "bool"
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :return "return" :yeild "yeild"))
;; easy hugo

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
;;
;; elfeed
(after! elfeed
  (setq elfeed-search-filter "@1-week-ago"))
(setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org")))
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
;; doom modeline
(setq doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-height 3
      doom-modeline-icon 't
      doom-modeline-modal-icon 'nil
      doom-modeline-env-version t
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
      doom-modeline-icon(display-graphic-p))

(setq centaur-tabs-style "box"
      centaur-tabs-height 32
      centaur-tabs-show-navigation-buttons t
      centaur-tabs-set-bar 'under
      x-underline-at-descent-line t
      centaur-tabs-close-button "×"
      centaur-tabs-modified-marker "Ø")

(setq +mu4e-backend 'offlineimap)

(setq +treemacs-git-mode 'extended
      treemacs-width 30)
(map!
  (:after dired
    (:map dired-mode-map
     "p" #'peep-dired
     )))
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map!
 :n
  "zw" 'save-buffer ; = :w ZZ = :wq

 :leader
  :desc "Enable Coloured Values""t c" #'rainbow-mode
  :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode
  :desc "Open Elfeed""o l" #'elfeed
  )

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(require 'elfeed-goodies)
(elfeed-goodies/setup)
