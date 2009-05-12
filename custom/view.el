(defun set-frame-size-according-to-resolution ()
  ;;(interactive)
  (if window-system
  (progn
    (if (> (x-display-pixel-width) 1280)
        (add-to-list 'default-frame-alist (cons 'width 203))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (- (x-display-pixel-height) 70) (frame-char-height))))))
  (enlarge-window-horizontally 20)
  (set-frame-position (selected-frame) 0 0))

(defun find-all-emacs-projects ()
  (let ((projs (file-expand-wildcards "~/projects/**/.emacs_project")))
    (let (value)
      (dolist (element projs value)
        (setq value (cons (car (split-string element "/.emacs_project")) value))))))


(global-set-key (kbd "<f5>") 'ecb-goto-window-directories)
;;(global-set-key (kbd "<f6>") 'ecb-goto-window-sources)
;;(global-set-key (kbd "<f7>") 'ecb-goto-window-methods)

