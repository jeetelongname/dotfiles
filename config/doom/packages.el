(package! engrave-faces
  :recipe (:host github :repo "tecosaur/engrave-faces"))

;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! closql :pin "0a7226331ff1f96142199915c0ac7940bac4afdd")

(package! nyan-mode)
(package! parrot)

(package! dired-sidebar)

(package! ibuffer-sidebar)

;; (package! org-sidebar)

;; (package! ef-themes :recipe (:host nil :repo "https://git.sr.ht/~protesilaos/ef-themes"))
(package! tao-theme)

(package! flymake-vale :recipe (:host github :repo "tpeacock19/flymake-vale"))

;; (package! dired-dragon :recipe (:local-repo "~/code/emacs/dired-dragon"
;;                                 :build (:not compile)))
(package! dired-dragon :recipe (:host github :repo "jeetelongname/dired-dragon"
                                :build (:not compile)))

(package! mmm-mode)

(package! carbon-now-sh)

;; (package! screenshot. :recipe
;;   (:host github :repo "tecosaur/screenshot"))

(package! aas)
(package! laas)
(package! tempel)

(package! lexic)

(package! info-colors)
(package! info-buffer)

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

(package! simple-comment-markup :recipe (:repo "https://git.tecosaur.net/tec/simple-comment-markup.git"))

(package! ox-chameleon :recipe (:host github :repo "tecosaur/ox-chameleon"))

(package! edraw :recipe (:host github :repo "misohena/el-easydraw" :files ("*.el")))

(package! nameless)

(package! caddyfile-mode)

(package! vimrc-mode)

(package! feature-mode)

(package! janet-mode :recipe
  (:host github :repo "ALSchwalm/janet-mode"))

(package! flymake-shellcheck)

(package! nov)
(package! calibredb)
(package! olivetti)
(package! mixed-pitch)

(package! tldr)

(package! elfeed-goodies :disable t)

(package! elfeed-tube :recipe (:host github :repo "karthink/elfeed-tube"))

(package! xref :pin "a82f459b37b31546bf274388baf8aca79e9c30d9")
(package! straight :pin "3eca39d")

(package! gitconfig-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitconfig-mode.el")))
(package! gitignore-mode
  :recipe (:host github :repo "magit/git-modes"
           :files ("gitignore-mode.el")))

;; This is temporarily necessary due to an unrelated bug.
(unpin! gitignore-mode gitconfig-mode)

(package! elcord)

;; (package! arr :recipe (:local-repo "~/code/emacs/arrows"))

(package! horizon-theme)
(unpin! doom-themes)

;; (package! pdf-tools :pin "7ff6293a25baaae65651b3e1c54b61208279a7ef")
(unpin! pdf-tools)

;; (package! hideshow-tree-sitter
;;   :recipe
;;   (:local-repo "~/code/emacs/hideshow-tree-sitter"
;;    :files ( "*.el" "queries")))

;; (package! tree-sitter-playground :recipe (:local-repo "~/code/emacs/tree-sitter-playground"
;;                                           :build (:not compile)))

;; (package! tree-edit :recipe (:host github :repo "ethan-leba/tree-edit"))
(package! evil-tree-edit :recipe (:host github :repo "ethan-leba/tree-edit"))

(package! origami)
(package! org-super-agenda)

(package! circe-notifications :disable t)

;; (package! elfeed-goodies
;;   :recipe (:local-repo "~/code/emacs/elfeed-goodies"
;;            :build (:not compile))
;;   :disable nil)

(package! mu4e-alert :disable t)
