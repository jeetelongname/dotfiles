;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

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
(package! smooth-scrolling :recipe (:host github
           :repo "DarwinAwardWinner/smooth-scrolling"
            :files ("smooth-scrolling.el")))

(package! org-reveal :recipe (:host github
           :repo "yjwen/org-reveal"
           :files ("*el")))

;; (package! latex-preview-pane)
