;; -*- no-byte-compile: t; -*-
;;; ui/tree-sitter/packages.el

(package! tree-sitter
  ;; :ignore (null (bound-and-true-p module-file-suffix))
  :pin "c7a1c34549cad41a3618c6f17e0e9dabd3e98fe1")
(package! tree-sitter-langs
  ;; :ignore (null (bound-and-true-p module-file-suffix))
  :pin "e7b8db7c4006c04a4bc1fc6865ec31f223843192")
(package! evil-textobj-treesitter
  :pin "f20598676f99...")
