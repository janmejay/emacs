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

(custom-set-variables
  '(semanticdb-default-file-name ".semantic.cache")
  '(semanticdb-default-save-directory "~/.emacs.d/.semantic"))

(defun discover-emacs-project-file-path (traversed-path path-frags)
  (let ((path (concat traversed-path "/" (pop path-frags))))
    (let ((project-file-path (concat path "/.emacs_project")))
      (if (file-exists-p project-file-path) project-file-path
        (discover-emacs-project-file-path path path-frags)))))

(defun find-emacs-project-file-for (file-path)
  (discover-emacs-project-file-path "/" (split-string file-path "/")))

(defun load-emacs-project-file-for (file-path)
  (load-file (find-emacs-project-file-for file-path)))


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