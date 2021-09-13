(defcli! repl ((in-rlwrap-p ["--rl"] "For internal use only."))
  "Start an elisp REPL."
  (when (and (executable-find "rlwrap") (not in-rlwrap-p))
    ;; For autocomplete
    (setq autocomplete-file "/tmp/doom_elisp_repl_symbols")
    (unless (file-exists-p autocomplete-file)
      (princ "\e[0;33mInitialising autocomplete list...\e[0m\n")
      (with-temp-buffer
        (cl-do-all-symbols (s)
          (let ((sym (symbol-name s)))
            (when (string-match-p "\\`[[:ascii:]][[:ascii:]]+\\'" sym)
              (insert sym "\n"))))
        (write-region nil nil autocomplete-file)))
    (princ "\e[F")
    (throw 'exit (list "rlwrap" "-f" autocomplete-file
                       (concat doom-emacs-dir "bin/doom") "repl" "--rl")))

  (doom-initialize-packages)
  (require 'engrave-faces-ansi)
  (setq engrave-faces-ansi-color-mode '3-bit)

  ;; For some reason (require 'parent-mode) doesn't work :(
  (defun parent-mode-list (mode)
    "Return a list of MODE and all its parent modes.

The returned list starts with the parent-most mode and ends with MODE."
    (let ((result ()))
      (parent-mode--worker mode (lambda (mode)
                                  (push mode result)))
      result))
  (defun parent-mode--worker (mode func)
    "For MODE and all its parent modes, call FUNC.

FUNC is first called for MODE, then for its parent, then for the parent's
parent, and so on.

MODE shall be a symbol referring to a function.
FUNC shall be a function taking one argument."
    (funcall func mode)
    (when (not (fboundp mode))
      (signal 'void-function (list mode)))
    (let ((modefunc (symbol-function mode)))
      (if (symbolp modefunc)
          ;; Hande all the modes that use (defalias 'foo-parent-mode (stuff)) as
          ;; their parent
          (parent-mode--worker modefunc func)
        (let ((parentmode (get mode 'derived-mode-parent)))
          (when parentmode
            (parent-mode--worker parentmode func))))))
  (provide 'parent-mode)
  ;; Some extra highlighting (needs parent-mode)
  (require 'rainbow-delimiters)
  (require 'highlight-quoted)
  (require 'highlight-numbers)
  (setq emacs-lisp-mode-hook '(rainbow-delimiters-mode
                               highlight-quoted-mode
                               highlight-numbers-mode))
  ;; Pretty print
  (defun pp-sexp (sexp)
    (with-temp-buffer
      (cl-prettyprint sexp)
      (emacs-lisp-mode)
      (font-lock-ensure)
      (with-current-buffer (engrave-faces-ansi-buffer)
        (princ (string-trim (buffer-string)))
        (kill-buffer (current-buffer)))))
  ;; Now do the REPL
  (defvar accumulated-input nil)
  (while t
    (condition-case nil
        (let ((input (if accumulated-input
                         (read-string "\e[31m .\e[0m  ")
                       (read-string "\e[31mλ:\e[0m "))))
          (setq input (concat accumulated-input
                              (when accumulated-input "\n")
                              input))
          (cond
           ((string-match-p "\\`[[:space:]]*\\'" input)
            nil)
           ((string= input "exit")
            (princ "\n") (kill-emacs 0))
           (t
            (condition-case err
                (let ((input-sexp (car (read-from-string input))))
                  (setq accumulated-input nil)
                  (pp-sexp (eval input-sexp))
                  (princ "\n"))
              ;; Caused when sexp in unbalanced
              (end-of-file (setq accumulated-input input))
              (error
               (cl-destructuring-bind (backtrace &optional type data . _)
                   (cons (doom-cli--backtrace) err)
                 (princ (concat "\e[1;31mERROR:\e[0m " (get type 'error-message)))
                 (princ "\n       ")
                 (pp-sexp (cons type data))
                 (when backtrace
                   (print! (bold "Backtrace:"))
                   (print-group!
                    (dolist (frame (seq-take backtrace 10))
                      (print!
                       "%0.74s" (replace-regexp-in-string
                                 "[\n\r]" "\\\\n"
                                 (format "%S" frame))))))
                 (princ "\n")))))))
      ;; C-d causes an end-of-file error
      (end-of-file (princ "exit\n") (kill-emacs 0)))
    (unless accumulated-input (princ "\n"))))
