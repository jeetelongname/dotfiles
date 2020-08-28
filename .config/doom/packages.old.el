;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))
;; Comands!
;; (unpin! some-package  ; unpins the package from the commits thats holding them
;;         other-package) set to "t" to live on the edge (Unpin all packages)
;; (package! some-package) ; this would declare it straight from melpa elpa or emacs mirror
;; (package! some-package
;;   :recipe (
;;            :host some-git-remote-provider (github gitlab)
;;            :repo "username/repo"
;;            :branch "some branch"
;;            :files ("Some-files") )) ; if you want a cetain file then use the file property
;; (package! some-package
;;   `:type'some type ; specifys the type
;;   `:disable' BOOL ; disables the packages and all of its use package configs
;;   `:ignore' FORM ; don't install this package
;;   `:pin' STR|nil ; same as `:ignore' but for built in packages
;;   `:built-in' BOOL | 'prefer
;;   )

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
