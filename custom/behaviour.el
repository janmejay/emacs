(require 'ido)

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
    
(add-hook 'ido-setup-hook
          (lambda ()
            (setq ido-enable-flex-matching t)
            (global-set-key "\M-x" 'ido-execute-command)))

(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")

(load "goodies/css-mode")