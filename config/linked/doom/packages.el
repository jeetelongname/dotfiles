;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! caddyfile-mode)

(package! vimrc-mode)

(package! feature-mode)

(package! nameless)

(package! brainfuck-mode)

(package! company-org-block)

(package! emacs-easy-hugo
  :recipe (:host github
           :repo "masasam/emacs-easy-hugo"
           :files ("*el")))

(package! nyan-mode)
(package! parrot)

(package! evil-tutor)

;; (package! dired-dragon :recipe (:local-repo "~/code/elisp/dired-dragon"))
(package! dired-dragon :recipe (:host github :repo "jeetelongname/dired-dragon"))

(package! horizon-theme)
(unpin! doom-themes)
(package! tao-theme)

(package! elcord)

(package! tldr)

(package! atomic-chrome)

(package! hackernews)

;; (package! eaf :recipe
;;   (:host github
;;    :repo "manateelazycat/emacs-application-framework"
;;    :files ("*")
;;    :build (:not compile)))

;; (package! epc)
;; (package! ctable)
;; (package! deferred)

(package! webkit :recipe
  (:host github :repo "akirakyle/emacs-webkit"
   :branch "main"
   :files (:defaults "*")))

(package! carbon-now-sh)

;; (package! screenshot. :recipe
;;   (:host github :repo "tecosaur/screenshot"))

;; (package! matrix-client.el :recipe (:host github :repo "alphapapa/matrix-client.el"))

(package! keycast)

(package! power-mode :recipe (:host github :repo "elizagamedev/power-mode.el"))

(package! selectric-mode)

;; (package! emacs-2048
;;   :recipe (:host github
;;            :repo "sprang/emacs-2048"))

(package! dired-sidebar)

(package! ibuffer-sidebar)

;; (package! org-sidebar)

(package! affe)

(unpin! forge)

(package! origami)
(package! org-super-agenda)

(package! mu4e-alert :disable t)

(package! elfeed-goodies)
(package! elfeed-web)
