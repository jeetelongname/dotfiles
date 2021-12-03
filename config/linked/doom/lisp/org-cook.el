;;; org-cook.el --- integration with cooklang -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 TEC
;;
;; Author: TEC <https://github.com/tecosaur>
;; Maintainer: TEC <tec@tecosaur.com>
;; Created: October 26, 2021
;; Modified: October 26, 2021
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/tecosaur/org-cook
;; Package-Requires: ((emacs "26.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  integration with cooklang
;;
;;; Code:

(eval-when-compile
  (require 'cl-lib))

(defvar org-cook-units
  '("g" "ml" "kg" "cups" "tbsp" "tsp")
  "Units to complete")

(defvar org-cook--ingredients-cache nil)

(defun org-cook-add-ingredients-to-cache ()
  "Add ingredients from the current buffer to the cache."
  (interactive)
  (org-element-map (org-element-parse-buffer) 'link
    (lambda (link)
      (when (string= (org-element-property :type link) "ingredient")
        (add-to-list 'org-cook--ingredients-cache
                     (car (split-string (org-element-property :path link) "::")))))))

(defun org-cook-get-ingredient-spec ()
  (let* ((ingredient (completing-read "Ingredient: " org-cook--ingredients-cache))
         (units-1 (completing-read "Units: " (append org-cook-units '("None"))))
         (units (unless (or (string= "" units-1) (string= "None" units-1)) units-1))
         (quantity (read-string "Quantity: ")))
    (unless (member ingredient org-cook--ingredients-cache)
      (add-to-list 'org-cook--ingredients-cache ingredient))
    (concat "ingredient:"
            ingredient
            (cond
             ((and quantity units) (format "::%s %s" quantity units))
             (quantity (format "::%s" quantity))))))

(defun org-cook-parse-ingredient-string (spec-string)
  "Parse an ingredients SPEC-string-STRING to (ingredient quantity units)."
  (let ((ingredient (car (split-string spec-string "::")))
        (ammount (cadr (split-string spec-string "::")))
        quantity units)
    (when ammount
      (save-match-data
        (string-match "^\\([0-9\\./ ]+?\\) ?\\(.*\\)?$" ammount)
        (setq quantity (match-string 1 ammount)
              units (match-string 2 ammount))
        (when (string= "" units)
          (setq units nil))))
    (list ingredient quantity units)))

(defun org-cook-cooklang-ingredient (spec)
  (cl-destructuring-bind (ingredient quantity units) spec
    (cond ((and ingredient quantity units)
           (format "@%s{%s%%%s}" ingredient quantity units))
          ((and ingredient quantity)
           (format "@%s{%s}" ingredient quantity))
          ((string-match-p " " ingredient)
           (format "@%s{}" ingredient))
          (t (concat "@" ingredient)))))

(org-export-define-derived-backend 'cook
    (if (require 'ox-gfm nil t) 'gfm 'md))

;;;###autoload
(defun org-cook-export-to-cook
    (&optional async subtreep visible-only body-only ext-plist)
  "Export current buffer as a cook file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, nothing different happens.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return cook file's name."
  (interactive)
  (let ((file (org-export-output-file-name ".cook" subtreep)))
    (org-export-to-file 'cook file
      async subtreep visible-only body-only ext-plist)))

(defun org-cook-ingredient-export (path _description backend _info)
  (let ((spec (org-cook-parse-ingredient-string path)))
    (message "cook: %S %s" spec backend)
    (if (org-export-derived-backend-p backend 'cook)
        (message "%s" (org-cook-cooklang-ingredient spec))
      (mapconcat #'identity (list (nth 1 spec) (nth 2 spec) (nth 0 spec)) " "))))

(defun org-cook-export-as-cook
    (&optional async subtreep visible-only body-only ext-plist)
  "Export current buffer as a Cook buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, nothing different happens.

EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Export is done in a buffer named \"*Org Cook Export*\", which
will be displayed when `org-export-show-temporary-export-buffer'
is non-nil."
  (interactive)
  (org-export-to-buffer 'cook "*Org Cook Export*"
    async subtreep visible-only body-only ext-plist))

(org-link-set-parameters "ingredient"
                         :face 'font-lock-type-face
                         :complete #'org-cook-get-ingredient-spec
                         :export #'org-cook-ingredient-export)

(provide 'org-cook)
;;; org-cook.el ends here
