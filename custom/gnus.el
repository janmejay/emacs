(defun newsgroup-trash-map (newsgroup)
  (cond 
   ((equalp "nnimap+gmail:INBOX" gnus-newsgroup-name) "nnimap+gmail:[Gmail]/Trash")
   (t nil)))

(defun gnus-move-to-trash ()
  (interactive)
  (gnus-summary-move-article nil (newsgroup-trash-map gnus-newsgroup-name)))


(add-hook 'gnus-summary-mode-hook 
          (lambda ()
            (local-set-key (kbd "<backspace>") 'gnus-move-to-trash)))

(require 'mm-url)
(defadvice mm-url-insert (after DE-convert-atom-to-rss () )
  "Converts atom to RSS by calling xsltproc."
  (when (re-search-forward "xmlns=\"http://www.w3.org/.*/Atom\"" 
                           nil t)
    (message "Converting Atom to RSS... ")
    (goto-char (point-min))
    (call-process-region (point-min) (point-max) 
                         "xsltproc" 
                         t t nil 
                         (expand-file-name "~/.emacs.d/vendor/atom2rss.xsl") "-")
    (goto-char (point-min))
    (message "Converting Atom to RSS... done")))

(ad-activate 'mm-url-insert)