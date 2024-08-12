;;; thrift-mode.el --- Major mode for editing Thrift definition files

;; Copyright (C) 2011 David Miller <david@deadpansincerity.com>
;; Author: David Miller <david@deadpansincerity.com>
;; Keywords: Thrift

;; This file is NOT part of GNU Emacs

;;; License

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

;;
;;; Commentary:
;;
;; This mode provides an editing environment for Thrift IDL files
;; in Emacs.
;;
;;; Code:

;; Requirements:
(require 'font-lock)

;;
;; Thrift Functionality
;;
;; Commentary:
;;
;; Compile with C-c C-k
;;

(defun thrift-gen ()
  "Generate the relevant thrift code"
  (interactive)
  (let ((cmd (concat "thrift --gen py "
                         (expand-file-name buffer-file-name))))
    (message cmd)
    (shell-command cmd))
  (message (concat "Generating " buffer-file-name)))

;;
;; Syntax Highlighting
;;
;; Commentary:
;;
;; Highlight with font-lock faces
;;
(defconst thrift-font-lock-keywords
  (list
   '("#.*$" . font-lock-comment-face)  ;; perl style comments
   '("\\<\\(include\\|struct\\|union\\|namespace\\|exception\\|typedef\\|php_namespace\\|const\\|enum\\|service\\|extends\\|void\\|async\\|throws\\|optional\\|required\\)\\>" . font-lock-keyword-face)  ;; keywords
   '("\\<\\(b\\(?:inary\\|ool\\|yte\\)\\|double\\|i\\(?:16\\|32\\|64\\)\\|list\\|map\\|s\\(?:et\\|tring\\)\\)\\>" . font-lock-type-face)  ;; built-in types
   '("\\<[0-9]+: \\(\\w+\\)" (1 font-lock-type-face)) ;; typedeffed types
   '("\\<\\(cpp\\|java\\|p\\(?:erl\\|hp\\|y\\)\\)" . font-lock-builtin-face)  ;; langs
   '("\\<\\([A-Z]\\w*\\)\\>" . font-lock-type-face)   ;; typenames (unions & structs)
   '("\\<\\([0-9]+\\)\\>" . font-lock-variable-name-face)   ;; ordinals
   '("\\<\\(\\w+\\)\\s-*(" (1 font-lock-function-name-face))  ;; functions
   )
  "Thrift regexps for font-lock")

;; C/C++ comments; also allowing underscore in words
(defvar thrift-mode-syntax-table
  (let ((thrift-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" thrift-mode-syntax-table)
    (modify-syntax-entry ?/ ". 124b" thrift-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" thrift-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" thrift-mode-syntax-table)
    thrift-mode-syntax-table)
  "Syntax table for thrift-mode")

;;
;; Editing environment
;;
;; Commentary:
;;
;; Set and provide Indentation levels and calculation.
;; Provide Imenu integration
;;
(defvar thrift-indent-level 4
  "Defines 4 spaces for thrift indentation.")

(defun thrift-indent-line ()
  "Indent current line as Thrift code."
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
      (if (looking-at "^[ \t]*\\(}\\|throws\\)")
          (if (looking-at "^[ \t]*}")
              (progn
                (save-excursion
                  (forward-line -1)
                  (setq cur-indent (- (current-indentation) thrift-indent-level)))
                (if (< cur-indent 0)
                    (setq cur-indent 0)))
            (progn
              (save-excursion
                (forward-line -1)
                (if (looking-at "^[ \t]*[\\.<>[:word:]]+[ \t]+[\\.<>[:word:]]+[ \t]*(")
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                  (setq cur-indent (current-indentation))))))
        (save-excursion
          (while not-indented
            (forward-line -1)
            (if (looking-at "^[ \t]*}")
                (progn
                  (setq cur-indent (current-indentation))
                  (setq not-indented nil))
              (if (looking-at "^.*{[^}]*$")
                  (progn
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*throws")
                  (progn
                    (setq cur-indent (- (current-indentation) thrift-indent-level))
                    (if (< cur-indent 0)
                        (setq cur-indent 0))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*[\\.<>[:word:]]+[ \t]+[\\.<>[:word:]]+[ \t]*([^)]*$")
                  (progn
                    (setq cur-indent (+ (current-indentation) thrift-indent-level))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*\\/\\*")
                  (progn
                    (setq cur-indent (+ (current-indentation) 1))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              (if (looking-at "^[ \t]*\\*\\/")
                  (progn
                    (setq cur-indent (- (current-indentation) 1))
                    (setq not-indented nil))
                (if (bobp)
                    (setq not-indented nil)))
              ))))
      (if cur-indent
          (indent-line-to cur-indent)
        (indent-line-to 0)))))

(defvar thrift-imenu-generic-expression
  '(("service"   "^service \\(.*\\) ?{" 1)
    ("struct"    "^struct \\(.*\\) ?{" 1)
    ("enum"      "^enum \\(.*\\) ?{" 1)
    ("typedef"   "^typedef \\(.*\\) ?{" 1)
    )
  "Imenu Regexps for thrift mode")

;;
;; Keys
;;
;; Commentary:
;;
;; Provide the keymap for the mode - presently pretty sparse
;;

(defvar thrift-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-c\C-k" 'thrift-gen)
    map)
  "Keymap for THRIFT major mode")

;;
;; Thrift mode
;;
;; Commentary:
;;
;; Provide hooks, and mode function.
;;
;(define-mode-abbrev)

(defvar thrift-mode-hook nil)

(defun thrift-mode ()
  "Major Mode for editing Thrift IDL files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table thrift-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(thrift-font-lock-keywords))
  (setq major-mode 'thrift-mode)
  (setq mode-name "Thrift")
  (set (make-local-variable 'indent-line-function) 'thrift-indent-line)
  (use-local-map thrift-mode-map)
  (run-hooks 'thrift-mode-hook)
  )

;; Default hook, sets up Imenu
(add-hook 'thrift-mode-hook '(lambda ()
                               (setq imenu-generic-expression
                                     thrift-imenu-generic-expression)))

(provide 'thrift-mode)
;; code ends
