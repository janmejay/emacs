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