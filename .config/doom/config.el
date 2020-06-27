;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file! run SPC-m-e-b (this reruns the config)

(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      doom-theme 'doom-horizon; pretty self explanitory
      treemacs-width 30
      display-line-numbers-type 'relative
      company-idle-delay 0.3) ; i like my autocomplete like my tea fast and always

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
      doom-modeline-env-version t
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
      doom-modeline-icon(display-graphic-p))

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
  "zw" 'save-buffer ; = :w ZZ = :wq

 :leader
  :desc "Enable Coloured Values""t c" #'rainbow-mode
  :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode :desc)

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

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

;;swich to the window after spliting
(setq evil-split-window-below t
      evil-vsplit-window-right t)


;; - `load!' for loading external *.el files to relative this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
