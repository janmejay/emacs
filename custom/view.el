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

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left3" (0.1921182266009852 . 0.35294117647058826) (0.1921182266009852 . 0.3137254901960784) (0.1921182266009852 . 0.3137254901960784)))))
 '(ecb-options-version "2.33beta2")
 '(ecb-source-path (cons "~/emacs_extensions" (find-all-emacs-projects)))
 '(ecb-tip-of-the-day nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(case-fold-search nil)
 '(cua-mode nil nil (cua-base))
 '(transient-mark-mode t)
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
)

(ecb-layout-switch "left3")
(ecb-activate)

(global-set-key (kbd "<f5>") 'ecb-goto-window-directories)
;;(global-set-key (kbd "<f6>") 'ecb-goto-window-sources)
;;(global-set-key (kbd "<f7>") 'ecb-goto-window-methods)

(set-frame-size-according-to-resolution)

(require 'window-numbering)
(window-numbering-mode 1)

