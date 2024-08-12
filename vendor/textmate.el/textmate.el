;; textmate.el --- TextMate minor mode for Emacs

;; Copyright (C) 2008, 2009 Chris Wanstrath <chris@ozmm.org>

;; Licensed under the same terms as Emacs.

;; Keywords: textmate osx mac
;; Created: 22 Nov 2008
;; Author: Chris Wanstrath <chris@ozmm.org>
;; Version: 1

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; This minor mode exists to mimick TextMate's awesome
;; features.

;;    ⌘T - Go to File
;;  ⇧⌘T - Go to Symbol
;;    ⌘L - Go to Line
;;  ⇧⌘L - Select Line (or expand Selection to select lines)
;;    ⌘/ - Comment Line (or Selection/Region)
;;    ⌘] - Shift Right
;;    ⌘[ - Shift Left
;;  ⌥⌘] - Align Assignments
;;  ⌥⌘[ - Indent Line
;;  ⌘RET - Insert Newline at Line's End
;;  ⌥⌘T - Reset File Cache (for Go to File)

;; A "project" in textmate-mode is determined by the presence of
;; a .git directory, an .hg directory, a Rakefile, or a Makefile.

;; You can configure what makes a project root by appending a file
;; or directory name onto the `*textmate-project-roots*' list.

;; If no project root indicator is found in your current directory,
;; textmate-mode will traverse upwards until one (or none) is found.
;; The directory housing the project root indicator (e.g. a .git or .hg
;; directory) is presumed to be the project's root.

;; In other words, calling Go to File from
;; ~/Projects/fieldrunners/app/views/towers/show.html.erb will use
;; ~/Projects/fieldrunners/ as the root if ~/Projects/fieldrunners/.git
;; exists.

;;; Installation

;; $ cd ~/.emacs.d/vendor
;; $ git clone git://github.com/defunkt/textmate.el.git
;;
;; In your emacs config:
;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
;; (require 'textmate)
;; (textmate-mode)

;;; Depends on imenu
(require 'imenu)

;;; Needed for flet
(eval-when-compile
  (require 'cl))

;;; Minor mode

(defvar *textmate-gf-exclude*
  "/\\.|fixtures|tmp|log|build|\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc|\\.elc|\\.o|\\.so"
  "Regexp of files to exclude from `textmate-goto-file'.")

(defvar *textmate-project-roots*
  '(".git" ".hg" "Rakefile" "Makefile" "README" "build.xml" ".emacs_project" "TAGS")
  "The presence of any file/directory in this list indicates a project root.")

(defvar textmate-use-file-cache t
  "Should `textmate-goto-file' keep a local cache of files?")

(defvar textmate-completing-library 'ido
  "The library `textmade-goto-symbol' and `textmate-goto-file' should use for
completing filenames and symbols (`ido' by default)")

(defvar *textmate-completing-function-alist* '((ido ido-completing-read)
                                               (icicles  icicle-completing-read)
                                               (none completing-read))
  "The function to call to read file names and symbols from the user")

(defvar *textmate-completing-minor-mode-alist*
  `((ido ,(lambda (a) (progn (ido-mode a) (setq ido-enable-flex-matching t))))
    (icicles ,(lambda (a) (icy-mode a)))
    (none ,(lambda (a) ())))
  "The list of functions to enable and disable completing minor modes")

(defvar *textmate-mode-map*
  (let ((map (make-sparse-keymap)))
    (cond ((featurep 'aquamacs)
     (define-key map [A-return] 'textmate-next-line)
     (define-key map (kbd "A-M-t") 'textmate-clear-cache)
     (define-key map (kbd "A-M-]") 'align)
     (define-key map (kbd "A-M-[") 'indent-according-to-mode)
     (define-key map (kbd "A-]")  'textmate-shift-right)
     (define-key map (kbd "A-[") 'textmate-shift-left)
     (define-key map (kbd "A-/") 'comment-or-uncomment-region-or-line)
     (define-key map (kbd "A-L") 'textmate-select-line)
     (define-key map (kbd "A-t") 'textmate-goto-file)
     (define-key map (kbd "A-T") 'textmate-goto-symbol)
     (define-key map (kbd "A-C-<up>") 'textmate-move-line-up)
     (define-key map (kbd "A-C-<down>") 'textmate-move-line-down)
     (define-key map (kbd "C-S-d") 'textmate-duplicate-line))
    ((and (featurep 'mac-carbon) (eq window-system 'mac) mac-key-mode)
     (define-key map [(alt meta return)] 'textmate-next-line)
     (define-key map [(alt meta t)] 'textmate-clear-cache)
     (define-key map [(alt meta \])] 'align)
     (define-key map [(alt meta \[)] 'indent-according-to-mode)
     (define-key map [(alt \])]  'textmate-shift-right)
     (define-key map [(alt \[)] 'textmate-shift-left)
     (define-key map [(meta /)] 'comment-or-uncomment-region-or-line)
     (define-key map [(alt t)] 'textmate-goto-file)
     (define-key map [(alt shift l)] 'textmate-select-line)
     (define-key map [(alt shift t)] 'textmate-goto-symbol)
     (define-key map [(alt control up)] 'textmate-move-line-up)
     (define-key map [(alt control down)] 'textmate-move-line-down)
     (define-key map [(control shift d)] 'textmate-duplicate-line))
    ((featurep 'ns)  ;; Emacs.app
     (define-key map [(super meta return)] 'textmate-next-line)
     (define-key map [(super meta t)] 'textmate-clear-cache)
     (define-key map [(super meta \])] 'align)
     (define-key map [(super meta \[)] 'indent-according-to-mode)
     (define-key map [(super \])]  'textmate-shift-right)
     (define-key map [(super \[)] 'textmate-shift-left)
     (define-key map [(super /)] 'comment-or-uncomment-region-or-line)
     (define-key map [(super t)] 'textmate-goto-file)
     (define-key map [(super shift l)] 'textmate-select-line)
     (define-key map [(super shift t)] 'textmate-goto-symbol)
     (define-key map [(super control up)] 'textmate-move-line-up)
     (define-key map [(super control down)] 'textmate-move-line-down)
     (define-key map [(control shift d)] 'textmate-duplicate-line))
    (t ;; Any other version
     (define-key map [(meta return)] 'textmate-next-line)
     (define-key map [(control c)(control t)] 'textmate-clear-cache)
     (define-key map [(control c)(control a)] 'align)
     (define-key map [(control tab)] 'textmate-shift-right)
     (define-key map [(control shift tab)] 'textmate-shift-left)
     (define-key map [(control c)(control k)] 'comment-or-uncomment-region-or-line)
     (define-key map [(meta t)] 'textmate-goto-file)
     (define-key map [(meta shift l)] 'textmate-select-line)
     (define-key map [(meta shift t)] 'textmate-goto-symbol)
     (define-key map [(control super up)] 'textmate-move-line-up)
     (define-key map [(control super down)] 'textmate-move-line-down)
     (define-key map [(control shift d)] 'textmate-duplicate-line)))
    map))

(defvar *textmate-project-root* nil
  "Used internally to cache the project root.")
(defvar *textmate-project-files* '()
  "Used internally to cache the files in a project.")

;;; Bindings

(defun textmate-ido-fix ()
  "Add up/down keybindings for ido."
  (define-key ido-completion-map [up] 'ido-prev-match)
  (define-key ido-completion-map [down] 'ido-next-match))

(defun textmate-completing-read (project-files &rest args)
  "Uses `*textmate-completing-function-alist*' to call the appropriate completing function."
  (let ((reading-fn
         (cadr (assoc textmate-completing-library
                      *textmate-completing-function-alist*))))
    (let ((selected-base-name (apply (symbol-function reading-fn) args)))
      (concat (gethash selected-base-name (caddr project-files)) selected-base-name))))

;;; allow-line-as-region-for-function adds an "-or-line" version of
;;; the given comment function which (un)comments the current line is
;;; the mark is not active.  This code comes from Aquamac's osxkeys.el
;;; and is licensed under the GPL

(defmacro allow-line-as-region-for-function (orig-function)
`(defun ,(intern (concat (symbol-name orig-function) "-or-line"))
   ()
   ,(format "Like `%s', but acts on the current line if mark is not active." orig-function)
   (interactive)
   (if mark-active
       (call-interactively (function ,orig-function))
     (save-excursion
       ;; define a region (temporarily) -- so any C-u prefixes etc. are preserved.
       (beginning-of-line)
       (set-mark (point))
       (end-of-line)
       (call-interactively (function ,orig-function))))))

(defun textmate-define-comment-line ()
  "Add or-line (un)comment function if not already defined"
  (unless (fboundp 'comment-or-uncomment-region-or-line)
    (allow-line-as-region-for-function comment-or-uncomment-region)))

;;; Commands

(defun textmate-next-line ()
  "Inserts an indented newline after the current line and moves the point to it."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun textmate-select-line ()
  "If the mark is not active, select the current line.
Otherwise, expand the current region to select the lines the region touches."
  (interactive)
  (if mark-active ;; expand the selection to select lines
      (let ((top (= (point) (region-beginning)))
            (p1 (region-beginning))
            (p2 (region-end)))
        (goto-char p1)
        (beginning-of-line)
        (push-mark (point))
        (goto-char p2)
        (unless (looking-back "\n")
          (progn
            (end-of-line)
            (if (< (point) (point-max)) (forward-char))))
        (setq mark-active t
              transient-mark-mode t)
        (if top (exchange-point-and-mark)))
    (progn
      (beginning-of-line)
      (push-mark (point))
      (end-of-line)
      (if (< (point) (point-max)) (forward-char))
      (setq mark-active t
            transient-mark-mode t))))

;; http://chopmo.blogspot.com/2008/09/quickly-jumping-to-symbols.html
(defun textmate-goto-symbol ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char (if (overlayp position) (overlay-start position) position)))))

(defun textmate-goto-file ()
  "Uses your completing read to quickly jump to a file in a project."
  (interactive)
  (let ((root (textmate-project-root)))
    (when (null root)
      (error
       (concat
        "Can't find a suitable project root ("
        (string-join " " *textmate-project-roots* )
        ")")))
    (let ((project-files (textmate-find-project-files root)))
      (find-file
       (concat
        (expand-file-name root) "/"
        (textmate-completing-read project-files "Find file: " (cadr project-files)))))))

(defun textmate-move-line-down ()
 "Move the current line down one.
  Not quite the same as TextMate's as the point moves *with* the line."
 (interactive)
 (let ((col (current-column)))
   (save-excursion (next-line)
     (transpose-lines 1))
   (next-line)
   (move-to-column col)))

(defun textmate-move-line-up ()
  "Move the current line up one.
  Not quite the same as TextMate's as the point moves *with* the line."
  (interactive)
  (let ((col (current-column)))
    (save-excursion (next-line)
      (transpose-lines -1))
    (move-to-column col)))

(defun textmate-duplicate-line ()
  "Duplicates current line.
   TODO: allow for region duplication."
  (interactive)
  (let ((str (concat
              (buffer-substring (point)
                                (save-excursion (end-of-line) (point)))
              "\n"
              (buffer-substring (save-excursion (beginning-of-line) (point))
                                (point)))))
    (insert str)))

(defun textmate-clear-cache ()
  "Clears the project root and project files cache. Use after adding files."
  (interactive)
  (setq *textmate-project-root* nil)
  (setq *textmate-project-files* '())
  (message "textmate-mode cache cleared."))

;;; Utilities

(defun textmate-all-keys (hash-table)
  (let ((all-keys '()))
    (maphash (lambda (key value) (add-to-list 'all-keys key)) hash-table)
    all-keys))

(defun textmate-file-base-name-map (rel-paths)
  (let ((base-to-rel-map (make-hash-table :test 'equal))
        (non-unique-entry-to-dir-map (make-hash-table :test 'equal)))
    (while rel-paths
      (let ((path (car rel-paths)))
        (textmate-populate-file-base-name-map path base-to-rel-map non-unique-entry-to-dir-map))
      (setq rel-paths (cdr rel-paths)))
    base-to-rel-map))

(defun textmate-insert-with-parent-dir-in-base-name (dir-name base-name base-name-map conflict-map)
  (let ((no-terminal-seperator-dir-name (replace-regexp-in-string "\/$" "" (or dir-name ""))))
    (let ((existing-parent-dir-name (file-name-directory no-terminal-seperator-dir-name))
          (existing-immediate-dir-name (file-name-nondirectory no-terminal-seperator-dir-name)))
      (textmate-insert-file-name-map-entry existing-parent-dir-name (concat existing-immediate-dir-name (and dir-name "/") base-name) base-name-map conflict-map))))

(defun textmate-insert-file-name-map-entry (dir-name base-name base-name-map conflict-map)
  (let ((existing-dir-name (gethash base-name base-name-map)))
    (if existing-dir-name 
        (progn 
          (remhash base-name base-name-map)
          (puthash base-name dir-name conflict-map)
          (textmate-insert-with-parent-dir-in-base-name existing-dir-name base-name base-name-map conflict-map)))
    (if (gethash base-name conflict-map)
        (textmate-insert-with-parent-dir-in-base-name dir-name base-name base-name-map conflict-map)
      (puthash base-name dir-name base-name-map))))

(defun textmate-populate-file-base-name-map (rel-path base-name-map conflict-map)
  (let ((base-name (file-name-nondirectory rel-path))
        (dir-name (file-name-directory rel-path)))
    (textmate-insert-file-name-map-entry dir-name base-name base-name-map conflict-map)))

(defun textmate-project-files (root)
  "Finds all files in a given project."
  (message (concat "textmate-mode: finding file list for project " root))
  (let ((relative-paths (split-string
                         (shell-command-to-string
                          (concat
                           "find "
                           root
                           " -type f  | grep -vE '"
                           *textmate-gf-exclude*
                           "' | sed 's:"
                           *textmate-project-root*
                           "::'")) "\n" t)))
    (let ((base-path-map (textmate-file-base-name-map relative-paths)))
      `(,root ,(textmate-all-keys base-path-map) ,base-path-map))))

(defun textmate-find-and-cache-project-files-for (root)
  (let ((new-cache (textmate-project-files root)))
    (add-to-list '*textmate-project-files* new-cache)
    new-cache))

(defun textmate-find-or-load-project-file-cache (root find-among-cached-nodes) 
  (let ((current-cache-node (car find-among-cached-nodes)))
    (cond ((null current-cache-node) (textmate-find-and-cache-project-files-for root))
          ((equal (car current-cache-node) root) current-cache-node)
          (t (textmate-find-or-load-project-file-cache root (cdr find-among-cached-nodes))))))

(defun textmate-find-project-files (root)
  (if textmate-use-file-cache 
      (textmate-find-or-load-project-file-cache root *textmate-project-files*)
    (textmate-project-files root)))

(defun textmate-project-root ()
  "Returns the current project root."
  (when (or
         (null *textmate-project-root*)
         (not (string-match *textmate-project-root* default-directory)))
    (let ((root (textmate-find-project-root)))
      (if root
          (setq *textmate-project-root* (expand-file-name (concat root "/")))
        (setq *textmate-project-root* nil))))
  *textmate-project-root*)

(defun root-match(root names)
  (member (car names) (directory-files root)))

(defun root-matches(root names)
	(if (root-match root names)
			(root-match root names)
			(if (eq (length (cdr names)) 0)
					'nil
					(root-matches root (cdr names)))))

(defun textmate-find-project-root (&optional root)
  "Determines the current project root by recursively searching for an indicator."
  (when (null root) (setq root default-directory))
  (cond
   ((root-matches root *textmate-project-roots*)
    (expand-file-name root))
   ((equal (expand-file-name root) "/") nil)
   (t (textmate-find-project-root (concat (file-name-as-directory root) "..")))))

(defun textmate-shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.

A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))

(defun textmate-shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (textmate-shift-right (* -1 (or arg 1))))

;;;###autoload
(define-minor-mode textmate-mode "TextMate Emulation Minor Mode"
  :lighter " mate" :global t :keymap *textmate-mode-map*
  (add-hook 'ido-setup-hook 'textmate-ido-fix)
  (textmate-define-comment-line)
  ; activate preferred completion library
  (dolist (mode *textmate-completing-minor-mode-alist*)
    (if (eq (car mode) textmate-completing-library)
        (funcall (cadr mode) t)
      (when (fboundp
             (cadr (assoc (car mode) *textmate-completing-function-alist*)))
        (funcall (cadr mode) -1)))))

(provide 'textmate)
;;; textmate.el ends here