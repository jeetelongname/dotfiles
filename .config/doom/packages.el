;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! emacs-easy-hugo
  :recipe (:host github
           :repo "masasam/emacs-easy-hugo"
           :files ("*el")))

(package! discord-emacs
  :recipe (:host github
           :repo "nitros12/discord-emacs.el"
           :files ("*.el")))

(package! elfeed-goodies)
(package! elfeed-web)

(package! peep-dired)

(package! tldr)

(package! org-msg)

(package! emojify)

(package! selectric-mode)

(package! keycast :pin "038475c178...")

(package! org-pretty-tags)

(package! origami)
;; (package! org-super-agenda)
