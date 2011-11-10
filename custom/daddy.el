(defun daddy-minibuffer-setup-hook ()
  (daddy-mode 1))

(add-hook 'minibuffer-setup-hook 'daddy-minibuffer-setup-hook)

(defvar *daddy-mode-map*
  (let ((map (make-sparse-keymap)))
    (define-key map [(control c)(control t)] 'org-todo)
    (global-set-key (kbd "C-c <f12>") 'textmate-clear-cache)
    map))

;;(defun arm-twist-textmate-mode ()
;;  (define-key *textmate-mode-map* [(control c)(control t)] 'org-todo)
;;  (global-set-key (kbd "C-c <f12>") 'textmate-clear-cache))

(define-minor-mode daddy-mode "A minor mode to arm-twist annoying major/minor modes."
  :lighter " daddy" :global t :keymap *daddy-mode-map*
  ;;(arm-twist-textmate-mode)
)

(daddy-mode)

(provide 'daddy)