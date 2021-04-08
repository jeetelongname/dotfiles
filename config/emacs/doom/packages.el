;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! caddyfile-mode)

(package! vimrc-mode)

(package! feature-mode)

(package! emacs-easy-hugo
  :recipe (:host github
           :repo "masasam/emacs-easy-hugo"
           :files ("*el")))

(package! nyan-mode)
(package! parrot)

(package! evil-tutor)

(package! elcord)

;; (package! origami)
(package! org-super-agenda)

(package! elfeed-goodies)
(package! elfeed-web)

;; (package! dired-dragon :recipe (:local-repo "~/code/elisp/dired-dragon"))
(package! dired-dragon :recipe (:host github :repo "jeetelongname/dired-dragon"))

(package! horizon-theme)
(unpin! doom-themes)

(package! tldr)

(package! atomic-chrome)

(package! hackernews)

(package! eaf :recipe
  (:host github
   :repo "manateelazycat/emacs-application-framework"
   :files ("*")
   :build (:not compile)))

(package! epc)
(package! ctable)
(package! deferred)

(package! webkit :recipe
  (:host github :repo "akirakyle/emacs-webkit"
   :branch "main"
   :files (:defaults "*")))

(package! carbon-now-sh)

;; (package! matrix-client.el :recipe (:host github :repo "alphapapa/matrix-client.el"))

(package! keycast)

(package! selectric-mode)

;; (package! emacs-2048
;;   :recipe (:host github
;;            :repo "sprang/emacs-2048"))

(package! dired-sidebar)

(package! ibuffer-sidebar)

(package! org-sidebar)

(package! mu4e-alert :disable t)
