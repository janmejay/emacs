(setq ido-execute-command-cache nil)
(defun ido-execute-command ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (progn
       (unless ido-execute-command-cache
         (mapatoms (lambda (s)
                     (when (commandp s)
                       (setq ido-execute-command-cache
                             (cons (format "%S" s) ido-execute-command-cache))))))
       ido-execute-command-cache)))))

(defun populate-emacs-project-files-table (file)
  (if (file-directory-p file)
      (mapc 'populate-emacs-project-files-table (directory-files file t "^[^\.]"))
    (let* ((file-name (file-name-nondirectory file))
	   (existing-record (assoc file-name emacs-project-files-table))
	   (unique-parts (get-unique-emacs-project-directory-names file (cdr existing-record))))
      (if existing-record
	  (let ((new-key (concat file-name " - " (car unique-parts)))
		(old-key (concat (car existing-record) " - " (cadr unique-parts))))
	    (setf (car existing-record) old-key)
	    (setq emacs-project-files-table (acons new-key file emacs-project-files-table)))
	(setq emacs-project-files-table (acons file-name file emacs-project-files-table))))))

(defun get-unique-emacs-project-directory-names (path1 path2)
  (let* ((parts1 (and path1 (split-string path1 "/" t)))
	 (parts2 (and path2 (split-string path2 "/" t)))
	 (part1 (pop parts1))
	 (part2 (pop parts2))
	 (looping t))
    (while (and part1 part2 looping)
      (if (equal part1 part2)
          (setq part1 (pop parts1) part2 (pop parts2))
        (setq looping nil)))
    (list part1 part2)))

(defun emacs-project-find (file)
  (interactive (list (if (functionp 'ido-completing-read)
			 (ido-completing-read "Find file in project: " (mapcar 'car (emacs-project-files)))
                       (completing-read "Find file in project: " (mapcar 'car (emacs-project-files))))))
  (find-file (cdr (assoc file emacs-project-files-table))))

(defun emacs-proj-root (&optional dir)
  (or dir (setq dir default-directory))
  (if (file-exists-p (concat dir ".emacs_project"))
      dir
    (if (equal dir  "/")
	nil
      (emacs-proj-root (expand-file-name (concat dir "../"))))))

(defun emacs-project-files (&optional file)
                                        ; uncomment these lines if it's too slow to load the whole emacs-project-files-table
                                        ;  (when (or (not emacs-project-files-table) ; initial load
                                        ;	    (not (string-match (emacs-proj-root) (cdar emacs-project-files-table)))) ; switched projects
  (setq emacs-project-files-table nil)
  (populate-emacs-project-files-table (or file (emacs-proj-root)))
  emacs-project-files-table)

;;find tests
(defun find-test-in-project (file)
  (interactive (list (if (functionp 'ido-completing-read)
			 (ido-completing-read "Find file in project: " (mapcar 'car (project-tests)))
                       (completing-read "Find file in project: " (mapcar 'car (project-tests))))))
  (find-file (cdr (assoc file project-files-table))))

(defun project-tests (&optional file)
                                        ; uncomment these lines if it's too slow to load the whole project-files-table
                                        ;  (when (or (not project-files-table) ; initial load
                                        ;	    (not (string-match (rails-root) (cdar project-files-table)))) ; switched projects
  (setq project-files-table nil)
  (populate-project-files-table (or file (project-test-dir)))
  project-files-table)

(defun project-test-dir ()
  (let ((test-dir (concat (emacs-proj-root) "/test"))
       (spec-dir (concat (emacs-proj-root) "/spec")))
       (cond ((file-exists-p test-dir) test-dir)
             ((file-exists-p spec-dir) spec-dir))))

(defun discover-emacs-project-file-path (traversed-path path-frags)
  (unless (eq 1 (length path-frags))
    (let ((path (concat traversed-path "/" (pop path-frags))))
      (let ((project-file-path (concat path "/.emacs_project")))
        (if (file-exists-p project-file-path) project-file-path
          (discover-emacs-project-file-path path path-frags))))))

(defun find-emacs-project-file-for (file-path)
  (discover-emacs-project-file-path "/" (split-string file-path "/" t)))

(defun load-emacs-project-file-for (file-path)
  (let ((prj-file (find-emacs-project-file-for file-path)))
    (if prj-file (load-file prj-file))))


(defun dumb-indent-without-reindent-of-current-line ()
  (interactive)
  (let* ((indent-lvl (current-indentation)))
    (newline-and-indent)
    (indent-to indent-lvl)))

(defun run-ruby-file ()
  (interactive)
  (let ((buffer (current-buffer)))
    (setq last-run-ruby-file (buffer-file-name buffer))
    (start-process "run-ruby-file" "*run-ruby-file*" "ruby" (buffer-file-name buffer))))

(defun run-ruby-file-last-run ()
  (interactive)
  (start-process "run-ruby-file" "*run-ruby-file*" "ruby" last-run-ruby-file))

(defun discover-corresponding-tags-file ()
  (labels
      ((find-tags-file-r (path)
                         (let* ((parent (file-name-directory path))
                                (possible-tags-file (concat parent "TAGS")))
                           (cond
                            ((file-exists-p possible-tags-file) (add-to-list 'tags-table-list  possible-tags-file))
                            ((string= "/TAGS" possible-tags-file) (error "no tags file found"))
                            (t (find-tags-file-r (directory-file-name parent)))))))
    
    (if (buffer-file-name)
        (find-tags-file-r (buffer-file-name)))))

(defun confirm-and-reset-tags-table ()
  (interactive)
  (if (y-or-n-p "Reset tags table?") (tags-reset-tags-tables)))

(defun newline-and-indent-in-haml ()
  (interactive)
  (let* ((indent-lvl (current-indentation)))
    (newline)
    (haml-indent-line)))

(defun indent-haml-region ()
  (interactive)
  (haml-indent-region (region-beginning) (region-end)))


(defun un-camelcase-word (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
    Default for SEP is a hyphen \"-\".

    If third argument START is non-nil, convert words after that
    index in STRING."
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "_") 
                                     (downcase (match-string 0 s))) 
                             t nil s)))
    (downcase s)))

(defun mapcar-head (fn-head fn-rest list)
  "Like MAPCAR, but applies a different function to the first element."
  (if list
      (cons (funcall fn-head (car list)) (mapcar fn-rest (cdr list)))))

(defun camel-case-word (s)
  "Convert under_score string S to CamelCase string."
  (mapconcat 'identity (mapcar
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))

(defun camelize-method (s)
  "Convert under_score string S to camelCase string."
  (mapconcat 'identity (mapcar-head
                        '(lambda (word) (downcase word))
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string-and-unquote s "_")) ""))

(defun js-camelize ()
  "Camelize the word under the point"
  (interactive)
  (let ((pt (bounds-of-thing-at-point 'symbol)))
    (set-window-point (selected-window) (car pt))
    (let ((matched-symbol (delete-and-extract-region (re-search-forward "_*") (cdr pt))))
      (insert (camelize-method matched-symbol)))))

(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun bars ()
  (interactive)
  (menu-bar-mode)
  (tool-bar-mode))