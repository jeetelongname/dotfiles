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
       :size 15)
      doom-variable-pitch-font
      (font-spec
       :family "Inconsolata Nerd Font"
       :size 15))

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

(setq centaur-tabs-style "zigzag"
      centaur-tabs-height 3 
      centaur-tabs-show-navigation-buttons t
      centaur-tabs-set-bar 'under
      x-underline-at-descent-line t
      centaur-tabs-close-button "×"
      centaur-tabs-modified-marker "Ø")

(setq fancy-splash-image
      (concat doom-private-dir "icons/emacs-icon.png"))

(setq +mu4e-backend 'offlineimap)

(map! :n
 "zz " 'save-buffer ;; = :w ZZ = :wq

 :leader
 "t c" #'rainbow-mode)

(require 'ox-reveal)
(setq org-reveal-root "")
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

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
