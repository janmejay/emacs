;;; espuds-buffer.el --- Buffer related definitions


;; Switches buffer in the current window to BUFFER.
;;
;; Usage:
;;   Given I am in buffer "*scratch*"
(Given "^I am in buffer \"\\(.+\\)\"$"
       (lambda (buffer)
         (let ((v (vconcat [?\C-x ?b] (string-to-vector buffer))))
           (execute-kbd-macro v))))

;; Asserts that the current buffer is BUFFER.
;;
;; Usage:
;;   Then I should be in buffer "*scratch*"
(Then "^I should be in buffer \"\\(.+\\)\"$"
      (lambda (buffer)
        (should (equal buffer (buffer-name)))))

;; Asserts that the current buffer is connected to FILE.
;;
;; Usage:
;;   Then I should be in file "/path/to/some/file"
(Then "^I should be in file \"\\(.+\\)\"$"
      (lambda (file)
        (let ((file-name (buffer-file-name)))
          (should file-name)
          (should (string-match-p (concat file "$") file-name)))))


;; Clears all text in the current buffer.
;;
;; Usage:
;;   Given the buffer is empty
(Given "^the buffer is empty$"
       (lambda ()
         (erase-buffer)))

;; Clears all text in the current buffer.
;;
;; Usage:
;;   When I clear the buffer
(When "I clear the buffer"
      (lambda ()
        (erase-buffer)))


(provide 'espuds-buffer)

;;; espuds-buffer.el ends here
