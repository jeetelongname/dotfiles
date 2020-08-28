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
(package! ox-reveal)

(package! origami)
;; (package! org-super-agenda)
(package! emojify)
(package! selectric-mode)
