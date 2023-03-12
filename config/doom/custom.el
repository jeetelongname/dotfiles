(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fce8c428aa62c06dfb5becf9d538ff24bcba7b0f2fc6d8892f2fbf7d19ba746b" default))
 '(pdf-misc-print-program-executable "/usr/bin/lp")
 '(safe-local-variable-values
   '((org-export-with-author)
     (org-log-done quote time)
     (org-re-reveal-root. "../reveal.js")
     (org-re-reveal-root. "./presentations/reveal.js")
     (org-re-reveal-root . "presentations/reveal.js"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-buffer-major-mode ((t (:foreground "#21bfc2"))))
 '(doom-modeline-buffer-modified ((t (:foreground "#f09383"))))
 '(doom-modeline-persp-name ((t (:foreground "#e95678" :weight bold))))
 '(eros-result-overlay-face ((t (:foreground "#b877db"))))
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:slant italic))))
 '(mu4e-replied-face ((t (:foreground "#e95678" :inherit font-lock-builtin-face))))
 '(org-date ((t (:foreground "#5b6268"))))
 '(org-document-title ((t (:height 1.75 :weight bold))))
 '(org-level-1 ((t (:foreground "#21bfc2" :height 1.3 :weight normal))))
 '(org-level-2 ((t (:foreground "#6c6f93" :height 1.1 :weight normal))))
 '(org-level-3 ((t (:foreground "#b877db" :height 1.0 :weight normal))))
 '(org-level-4 ((t (:foreground "#58cfd1" :height 1.0 :weight normal))))
 '(org-level-5 ((t (:foreground "#9093ae" :weight normal))))
 '(org-level-6 ((t (:foreground "#90dfe0" :weight normal))))
 '(tree-sitter-hl-face:function.call ((t (:foreground "#21bfc2"))))
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(put 'erase-buffer 'disabled nil)

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
