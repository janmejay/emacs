(defvar daddy-minor-mode-map (make-sparse-keymap) "daddy-minor-mode keymap.")

(define-minor-mode daddy-minor-mode
    "A minor mode so that my key settings override annoying major/minor modes."
  t
  " daddy"
  'daddy-minor-mode-map)


(defun daddy-minibuffer-setup-hook ()
  (daddy-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'daddy-minibuffer-setup-hook)

(daddy-minor-mode 1)

(define-key daddy-minor-mode-map "\C-c\C-t" 'org-todo)
