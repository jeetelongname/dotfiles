;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file! run SPC-m-e-b (this reruns the config)

(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      doom-theme 'doom-horizon; pretty self explanitory
      treemacs-width 30
      display-line-numbers-type 'relative
      company-idle-delay 0.1) ; i like my autocomplete like my tea fast and always

;;
(setq doom-font
      (font-spec
       :family "Inconsolata Nerd Font"
       :size 15)
      doom-big-font
      (font-spec
       :family "Inconsolata Nerd Font"
       :size 20)
      doom-variable-pitch-font
      (font-spec
       :family "Inconsolata Nerd Font"
      :size 15)
      ;; doom-unicode-font
      ;; (font-spec
      ;;  :family "Ligconsolata Regular"
      ;;  :size 15)
)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org-notes/")

(setq prettify-symbols-mode t)
;; some simple additions to the modeline that make it more usable for me
(setq doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-height 3
      doom-modeline-icon 't
      doom-modeline-modal-icon 'nil
      doom-modeline-mu4e 't
      doom-modeline-env-version t
      doom-modeline-icon(display-graphic-p)
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
;; changes to the tab bar

(setq centaur-tabs-style "box"
      centaur-tabs-height 32
      centaur-tabs-show-navigation-buttons t
      centaur-tabs-set-bar 'under
      x-underline-at-descent-line t
      centaur-tabs-close-button "×"
      centaur-tabs-modified-marker "Ø")

(setq fancy-splash-image
      (concat doom-private-dir "icons/emacs-icon.png"))

(setq +mu4e-backend 'offlineimap)
(setq +treemacs-git-mode 'extended)
(map!
 :n
  "zw" 'save-buffer ;; = :w ZZ = :wq

 :leader
  :desc "Enable Coloured Values""t c" #'rainbow-mode
  :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode :desc)


(require 'ox-reveal)
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(after! go-mode
  (set-pretty-symbols! 'go-mode
    :def "func"
    ;; :lambda "func("
    :true "true" :false "false"
    :int "int" :str "string"
    :float "float" :bool "bool"
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :return "return" :yeild "yeild"))


;; Here are some additional functions/macros that could help you configure Doom:
;; - `load!' for loading external *.el files to relative this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#232530" "#e95678" "#09f7a0" "#fab795" "#21bfc2" "#6c6f93" "#59e3e3" "#c7c9cb"])
 '(custom-safe-themes
   (quote
    ("b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" default)))
 '(fci-rule-color "#f9cec3")
 '(jdee-db-active-breakpoint-face-colors (cons "#16161c" "#e95678"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#16161c" "#09f7a0"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#16161c" "#6a6a6a"))
 '(objed-cursor-color "#e95678")
 '(pdf-view-midnight-colors (cons "#c7c9cb" "#1c1e26"))
 '(rustic-ansi-faces
   ["#1c1e26" "#e95678" "#09f7a0" "#fab795" "#21bfc2" "#6c6f93" "#59e3e3" "#c7c9cb"])
 '(vc-annotate-background "#1c1e26")
 '(vc-annotate-color-map
   (list
    (cons 20 "#09f7a0")
    (cons 40 "#59e19c")
    (cons 60 "#a9cc98")
    (cons 80 "#fab795")
    (cons 100 "#f6ab8f")
    (cons 120 "#f39f89")
    (cons 140 "#f09383")
    (cons 160 "#c48788")
    (cons 180 "#987a8d")
    (cons 200 "#6c6f93")
    (cons 220 "#95668a")
    (cons 240 "#bf5e81")
    (cons 260 "#e95678")
    (cons 280 "#c95b74")
    (cons 300 "#a96071")
    (cons 320 "#89656d")
    (cons 340 "#f9cec3")
    (cons 360 "#f9cec3")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
