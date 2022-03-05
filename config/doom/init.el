;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load

;; I add it to the list early.. for no reason. put in your config.el
(add-to-list 'load-path "~/.nix-profile/share/emacs/site-lisp/mu4e")

;; drop in $DOOMDIR/init.el
(defadvice! fix-doom--straight-fallback-to-tty-prompt-a (fn prompt actions)
  :override #'doom--straight-fallback-to-tty-prompt-a
  (if doom-interactive-p
      (funcall fn prompt actions)
    (let ((doom--straight-auto-options doom--straight-auto-options)
          (last-resort
           (lambda ()
             (unless straight--default-directory
               (error "Can't determine package"))
             (let (packages)
               (dolist (recipe
                        (let ((repo (file-name-base (directory-file-name straight--default-directory))))
                          (seq-filter (lambda (r)
                                        (string= (plist-get r :local-repo) repo))
                                      (hash-table-values straight--recipe-cache))))
                 (straight--with-plist recipe (local-repo package)
                   (push (intern package) packages)
                   (when local-repo
                     (print! (warn "Deleting repo: %S" (straight--repos-dir local-repo)))
                     (delete-directory (straight--repos-dir local-repo) t))
                   (when package
                     (print! (warn "Deleting package: %S" (straight--build-dir package)))
                     (delete-directory (straight--build-dir package) t))))
               (mapc #'straight-use-package packages)))))
      ;; We can't intercept C-g, so no point displaying any options for this key
      ;; when C-c is the proper way to abort batch Emacs.
      (delq! "C-g" actions 'assoc)
      ;; HACK These are associated with opening dired or magit, which isn't
      ;;      possible in tty Emacs, so...
      (delq! "e" actions 'assoc)
      (delq! "g" actions 'assoc)
      (setf (alist-get "X" actions nil nil #'equal)
            (list "Reclone and rebuild the package" last-resort))
      (unless
          (and doom-auto-discard
               (or (cl-loop with doom-auto-accept = t
                            for (_key desc func) in actions
                            when (doom--straight-recommended-option-p prompt desc)
                            return (progn (funcall func) t))
                   (funcall last-resort)))
        (print! (start "%s") (red prompt))
        (print-group!
         (terpri)
         (let (recommended options)
           (print-group!
            (print! " 1) Abort")
            (cl-loop for (_key desc func) in actions
                     when desc
                     do (push func options)
                     and do
                     (print! "%2s) %s" (1+ (length options))
                             (if (or (doom--straight-recommended-option-p prompt desc)
                                     (and (not recommended)
                                          (equal func last-resort)))
                                 (progn
                                   (setq doom--straight-auto-options nil
                                         recommended (length options))
                                   (green (concat desc " (Choose this if unsure)")))
                               desc))))
           (terpri)
           (let* ((options
                   (cons (lambda ()
                           (let ((doom-output-indent 0))
                             (terpri)
                             (print! (warn "Aborted")))
                           (kill-emacs 1))
                         (nreverse options)))
                  (prompt
                   (format! "How to proceed? (%s%s) "
                            (mapconcat #'number-to-string
                                       (number-sequence 1 (length options))
                                       ", ")
                            (if (not recommended) ""
                              (format "; don't know? Pick %d" (1+ recommended)))))
                  answer fn)
             (while (null (nth (setq answer (1- (read-number prompt)))
                               options))
               (print! (warn "%s is not a valid answer, try again.")
                       answer))
             (funcall (nth answer options)))))))))

(doom! :input
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion
       (company            ; the ultimate code completion backend
        +childframe)
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ;;(ivy +prescient)  ; a search engine for love and life
      (vertico +icons)     ; verting co


       :ui
       ;;deft              ; notational velocity for Emacs
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       doom-quit           ; DOOM quit-message prompts when you quit Emacs
       (emoji              ; 🙂
         +github
         +unicode)
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra
       ;;indent-guides     ; highlighted indent columns
       ;;ligatures         ; ligatures and symbols to make your code pretty again
       ;;minimap           ; show a map of the code on the side
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink cursor line after big motions
       ;;neotree           ; a project drawer, like NERDTree for vim
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;; tabs             ; a tab bar for Emacs
       (treemacs +lsp)     ; a project drawer, like neotree but cooler
       ;;unicode           ; extended unicode support for various languages
       vc-gutter           ; vcs diff in the fringe
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB
       (window-select      ; visually switch windows
        +numbers)
       workspaces          ; tab emulation, persistence & separate workspaces
       zen                 ; distraction-free coding or writing

       :editor
       (evil +everywhere)  ; come to the dark side, we have cookies
       file-templates      ; auto-snippets for empty files
       fold                ; (nigh) universal code folding
       (format +onsave)    ; automated prettiness
       ;;god               ; run Emacs commands without modifier keys
       lispy               ; vim for lisp, for people who don't like vim
       multiple-cursors    ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text         ; cycle region at point between text candidates
       snippets            ; my elves. They type so I don't have to
       word-wrap           ; soft wrapping with language-aware indent

       :emacs
       (dired              ; making dired pretty [functional]
        +icons)
       electric            ; smarter, keyword-based electric-indent
       ibuffer             ; interactive buffer management
       (undo +tree)        ; persistent, smarter undo for your inevitable mistakes
       vc                  ; version-control and Emacs, sitting in a tree

       :term
       eshell              ; the elisp shell that works everywhere
       ;;shell             ; simple shell REPL for Emacs
       ;;term              ; basic terminal emulator for Emacs
       vterm               ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe) ; tasing you for every semicolon you forget
       (spell  +aspell)     ; tasing you for misspelling mispelling
       grammar              ; tasing grammar mistake every you make

       :tools
       ;;ansible
       debugger            ; FIXME stepping through code, to help you add bugs
       direnv
       ;;docker
       editorconfig        ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       gist                ; interacting with github gists
       (lookup
        +docset)           ; navigate your code and its documentation
       (lsp -eglot
            +peek)
       (magit +forge)      ; a git porcelain for Emacs
       make                ; run make tasks from Emacs
       pass                ; password manager for nerds
       pdf                 ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb                 ; creating color strings
       ;;taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       tmux                ; an API for interacting with tmux
       tree-sitter         ; syntax and parsing, sitting in a tree...
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       ;;macos             ; improve compatibility with macOS *me, using macos, Ha!*
       tty                 ; improve the terminal Emacs experience

       :lang
       ;;agda              ; types of types of types of types...
       beancount           ; the accounting system in Emacs
       (cc +lsp            ; C/C++/Obj-C madness
           +tree-sitter)
       ;;clojure           ; java with a lisp
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data                ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       (go +lsp)           ; the hipster dialect
       (haskell +lsp)      ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ; a language you can depend on
       json                ; At least it ain't XML
       (java +lsp          ; the poster child for carpal tunnel syndrome
             +tree-sitter)
       (javascript +lsp    ; all(hope(abandon(ye(who(enter(here))))))
                   +tree-sitter)
       (julia +tree-sitter); a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       (latex              ; writing papers in Emacs has never been so fun
        +latexmk
        +cdlatex
        +lsp)
       ;;lean
       ;;factor
       ;;ledger            ; an accounting system in Emacs
       (lua  +fennel)      ; one-based indices? one-based indices
       (markdown +grip)    ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       nix                 ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org                ; organize your plain life in plain text
        +dragndrop
        +journal           ; Only `M-x'`doctor' can save me now
        +noter
        +pandoc            ; See all the file formats from the magic of org
        +present
        +roam2             ; so that I can map my insanity
        )
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python +lsp        ; beautiful is better than ugly
               +poetry
               +pyright
               +tree-sitter)
       ;;qt                ; the 'cutest' gui framework ever
       (racket +lsp +xp)   ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       (ruby +rails        ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
             +lsp
             +tree-sitter)
       ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       (scheme +guile)     ; a fully conniving family of lisps
       sh                  ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       (web +lsp           ; the tubes
            +tree-sitter)
       yaml                ; JSON, but readable
       ;;zig               ; C, but simpler

       :email
       (mu4e +gmail +org)  ; The emacs experience is not complete without email
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       everywhere          ; *leave* Emacs!? You must be joking
       irc                 ; how neckbeards socialize
       (rss +org)          ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :config
       literate
       tutorial
       (default +bindings +smartparens))
