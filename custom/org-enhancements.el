(defun produce-estimate-csv-for (str)
  (let* ((lines (filter-out-non-estimate-lines (split-string str "\n" t)))
         (max-depth (find-max-org-nesting-depth lines))
         (min-depth (find-max-org-nesting-depth lines)))
    (mapcar #'produce-estimate-csv-for lines min-depth max-depth)))

(defun find-max-org-nesting-depth (lines)
  (mapcar #'))

(defun produce-estimate-csv-row (line)
  (mapcar ))

(defun export-estimate-csv (start end)
  (interactive "r")
  (let ((str (buffer-substring start end)))
    (set-buffer (generate-new-buffer "*Estimate CSV*"))
    (produce-estimate-csv-for str)))

(defun find-max-org-nesting-depth (str)
  ())


(defun filter-out-non-estimate-lines (lines)
  ())
