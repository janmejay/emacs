(defun daddy-minibuffer-setup-hook ()
  (daddy-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'daddy-minibuffer-setup-hook)

(daddy-minor-mode 1)

(defvar *daddy-mode-map*
  (let ((map (make-sparse-keymap)))
;;    (define-key map [(control c)(control t)] 'org-todo)
    map))

(defun arm-twist-textmate-mode ()
  (define-key *textmate-mode-map* [(control c)(control t)] 'org-todo)
  (global-set-key (kbd "C-c <f12>") 'textmate-clear-cache))

(define-minor-mode daddy-minor-mode "A minor mode to arm-twist annoying major/minor modes."
  :lighter " daddy" :global t :keymap *daddy-mode-map*
  (arm-twist-textmate-mode))

(provide 'daddy)