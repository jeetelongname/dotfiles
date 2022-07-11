(package! engrave-faces
  :recipe (:host github :repo "tecosaur/engrave-faces"))

;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! nyan-mode)
(package! parrot)

(package! dired-sidebar)

(package! ibuffer-sidebar)

(package! org-sidebar)

(package! popon :recipe (:repo "https://codeberg.org/akib/emacs-popon"))
(package! flymake-popon :recipe (:repo "https://codeberg.org/akib/emacs-flymake-popon"))

(package! flymake-vale :recipe (:host github :repo "tpeacock19/flymake-vale"))

;; (package! dired-dragon :recipe (:local-repo "~/code/emacs/dired-dragon"
;;                                 :build (:not compile)))
(package! dired-dragon :recipe (:host github :repo "jeetelongname/dired-dragon"
                                :build (:not compile)))

(package! carbon-now-sh)

;; (package! screenshot. :recipe
;;   (:host github :repo "tecosaur/screenshot"))

(package! aas)
(package! tempel)

(package! lexic)

(package! company-org-block)

(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

(unpin! org-roam)
(package! websocket)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))

(package! org-modern)

(package! org-remark)

(package! nameless)

(package! caddyfile-mode)

(package! vimrc-mode)

(package! feature-mode)

(package! janet-mode :recipe
  (:host github :repo "ALSchwalm/janet-mode"))

(package! nov)
(package! calibredb)
(package! olivetti)
(package! mixed-pitch)

(package! tldr)

(package! elfeed-tube :recipe (:host github :repo "karthink/elfeed-tube"))

(package! xref :pin "a82f459b37b31546bf274388baf8aca79e9c30d9")

(package! gitconfig-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitconfig-mode.el")))
(package! gitignore-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitignore-mode.el")))

;; This is temporarily necessary due to an unrelated bug.
(unpin! gitignore-mode gitconfig-mode)

(package! elcord)

(package! arr :recipe (:local-repo "~/code/emacs/arrows"))

(package! horizon-theme)
(unpin! doom-themes)
(package! tao-theme)

(unpin! pdf-tools)

(package! hideshow-tree-sitter
  :recipe
  (:local-repo "~/code/emacs/hideshow-tree-sitter"
   :files ( "*.el" "queries")))

(package! tree-sitter-playground :recipe (:local-repo "~/code/emacs/tree-sitter-playground"
                                          :build (:not compile)))

(package! origami)
(package! org-super-agenda)

(package! circe-notifications :disable t)

(package! elfeed-goodies
  :recipe (:local-repo "~/code/emacs/elfeed-goodies"
           :build (:not compile))
  :disable nil)

(package! mu4e-alert :disable t)
