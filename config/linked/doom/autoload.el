;;;###autoload
(defun yeet/reload ()
  "A simple cmd to make reloading my config easier"
  (interactive)
  (load! "config" doom-private-dir)
  (message "Reloaded!"))

;;;###autoload
(defun henlo ()
  "henlo."
  (interactive)
  (message "henlo"))

(henlo) ;; oh wait thats how

;;;###autoload
(defun stop ()
  (interactive)
  (let ((name "*I can quit at any time*"))
    (switch-to-buffer (get-buffer-create name))
    (insert "I can stop at any time\nI am in control")))

;;;###autoload
(defun uwu (start end)
  "Uwu the text between START and END."
  (interactive "r")
  (let ((str (buffer-substring-no-properties start end)))
    (goto-char start)
    (delete-region start end)
    (insert (format "%s" (shell-command-to-string ;; I have to pipe the text into uwuify unless making a temp-file is more your style
                          (concat "echo "
                                  "'" str "'"
                                  " | " (executable-find "uwuify")))))))

;;;###autoload
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;;;###autoload
(defun yeet/select-bird (bird)
  "Select BIRD from birds"
  (interactive (list (completing-read "Select bird: " birds)))
  (parrot-set-parrot-type bird))

(defun yeet/scss-compile (watch)
  "Get sass compiling my scss files."
  (start-process-shell-command
   "sass-compile" "*sass-compile-log*"
   (concat "sass "
           (if watch "--watch " " ")
           (concat (projectile-acquire-root) "css/scss") ":"
           (concat (projectile-acquire-root) "css" )
           " --no-color")))

;;;###autoload
(defun yeet/scss-build ()
  "Build Scss files in directory."
  (interactive)
  (yeet/scss-compile nil)
  (message "SCSS Compiled!"))

;;;###autoload
(defun yeet/scss-start ()
  "Watch Scss file in directory."
  (interactive)
  (yeet/scss-compile t))

;;;###autoload
(defun yeet/scss-stop ()
  "Kill any current scss processes"
  (interactive)
  (delete-process "sass-compile")
  (message "Sass process killed"))

;;;###autoload
(defun yeet/elfeed-copy-link ()
  "Copy current link to clipboard for easy sharing"
  (interactive)
  (let ((link (elfeed-entry-link elfeed-show-entry)))
    (when link
      (kill-new link)
      (message "Copied %s to clipboard" link))))

;; not actually useful as you can just use =title to filter by title
;;;###autoload
(defun yeet/search-feeds-by-title (feed-title)
  (interactive (list (completing-read "Select Feed" (let (feed-titles)
                                                (dolist (feed elfeed-feeds feed-titles)
                                                  (push (cons (elfeed-feed-title (elfeed-entry-feed (car (elfeed-feed-entries (car feed)))))
                                                              (car feed))
                                                        feed-titles))))))
  (message "%s"  feed-title))
