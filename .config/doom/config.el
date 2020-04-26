;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      ;; pretty self explanitory
      doom-theme 'doom-horizon
      treemacs-width 30
      ;; my line numbers count away from the line im on easier to jump to lines
      display-line-numbers-type 'relative
      ;; i like my autocomplete like my tea fast and always
      company-idle-delay 0)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org-notes/")

(setq prettify-symbols-mode t)
;; some simple additions to the modeline that make it more usable for me
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project
      doom-modeline-height 3
      doom-modeline-icon 't
      doom-modeline-modal-icon 'nil
      doom-modeline-mu4e 't
      doom-modeline-env-version t
      doom-modeline-env-enable-python 't
      doom-modeline-env-enable-go 't)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
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
