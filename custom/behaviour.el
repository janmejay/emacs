;;;;;; ido
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

;;;;;;;;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/custom/snippets")

;;;;;;;;; css-mode
(load "goodies/css-mode")

;; enable test-case-mode automatically
(add-hook 'find-file-hook 'enable-test-case-mode-if-test)

;; run the test when saving the file
(setq test-case-run-after-saving t)

;;;;;;;;;;ruby & rinari

(load "rinari/rinari")
(load "collection/ruby/ruby-mode")
(load "collection/ruby/inf-ruby")
(load "collection/ruby/ruby-compilation")
(require 'cl)
(require 'toggle)
(require 'find-file-in-project)
;;(require 'rinari-movement)
;;(load "collection/ruby/rinari")
(define-key ruby-mode-map (kbd "<return>") 'ruby-reindent-then-newline-and-indent)
(define-key ruby-mode-map "\C-j" 'dumb-indent-without-reindent-of-current-line)
(define-key ruby-mode-map (kbd "S-<f8>") 'run-ruby-file)
(define-key ruby-mode-map (kbd "<f8>") 'run-ruby-file-last-run)

;;renari html support tweak
(define-key rinari-minor-mode-map
  "\C-c\M-s" 'rinari-console)
(define-key rinari-minor-mode-map
  "\C-c\C-v" (lambda () (interactive) (toggle-buffer 'rails-view)))
(define-key rinari-minor-mode-map
  "\C-c\C-t" 'toggle-buffer)
(define-key rinari-minor-mode-map
  "\C-c\C-r" 'ruby-rake)
(define-key rinari-minor-mode-map
  "\C-c\C-g" 'rinari-get-path)
(define-key rinari-minor-mode-map
  "\C-c\C-f" 'rinari-find-config-file)
(define-key rinari-minor-mode-map
  "\C-c\C-b" 'rinari-find-by-context)
;;(define-key rinari-minor-mode-map
;;  "\C-x\C-\M-F" 'find-file-in-project)

;;;;; running tests
(require 'test-runner)

(global-set-key [(f7)] 'run-test)
(define-key ruby-mode-map (kbd "S-<f7>") 'toggle-run-current-rspec-block)

;;;;; settings

(global-set-key (kbd "<f6>") 'shell)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)

;; C++ and C mode...
(defun my-c++-mode-hook ()
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c++-mode-map "\C-ce" 'c-comment-edit)
  (setq c++-auto-hungry-initial-state 'none)
  (setq c++-delete-function 'backward-delete-char)
  (setq c++-tab-always-indent t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c++-empty-arglist-indent 4))

(defun my-c-mode-hook ()
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c-mode-map "\C-ce" 'c-comment-edit)
  (setq c-auto-hungry-initial-state 'none)
  (setq c-delete-function 'backward-delete-char)
  (setq c-tab-always-indent t)
  ;; BSD-ish indentation style
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 0)
  (setq c-label-offset -4))

;; Perl mode
(defun my-perl-mode-hook ()
  (setq tab-width 4)
  (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (setq perl-indent-level 4)
  (setq perl-continued-statement-offset 4))

;; Scheme mode...
(defun my-scheme-mode-hook ()
  (define-key scheme-mode-map "\C-m" 'reindent-then-newline-and-indent))

;; Emacs-Lisp mode...
(defun my-lisp-mode-hook ()
  (define-key lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key lisp-mode-map "\C-i" 'lisp-indent-line)
  (define-key lisp-mode-map "\C-j" 'eval-print-last-sexp))

;; Add all of the hooks...
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'perl-mode-hook 'my-perl-mode-hook)

(global-set-key (kbd "M-d") 'kill-word)


;;;;;aliases

(defalias 'sh 'shell)
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)
(defalias 'sh 'shell)

(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)
(defalias 'dml 'delete-matching-lines)
(defalias 'rof 'recentf-open-files)

(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)

(defalias 'rs 'replace-string)

(defalias 'el 'ielm)

;;;;;;paste with indent
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode scheme-mode lisp-mode c-mode c++-mode objc-mode latex-mode plain-tex-mode ruby-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode scheme-mode lisp-mode c-mode c++-mode objc-mode latex-mode plain-tex-mode ruby-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))
(global-set-key (kbd "C-j") 'dumb-indent-without-reindent-of-current-line)
;;(define-key c++-mode-map "\C-j" 'dumb-indent-without-reindent-of-current-line)
;;(define-key lisp-mode-map "\C-j" 'dumb-indent-without-reindent-of-current-line)

(global-set-key (kbd "C-M-z") 'emacs-project-find)
(global-set-key (kbd "C-M-y") 'longlines-mode)
(global-set-key (kbd "C-x C-M-t") 'find-test-in-project)
(global-set-key (kbd "<f5>") 'toggle-ecb-activation)

;;pick up the corresponding tags file by recursively looking up parent dirs and add it to tags-table-list
(defadvice find-tag 
  (before discover-before-lookup)
  (discover-corresponding-tags-file))

(global-set-key (kbd "C-`") 'confirm-and-reset-tags-table)

(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

(define-key haml-mode-map (kbd "<RET>") 'newline-and-indent-in-haml)
(define-key haml-mode-map (kbd "C-;") 'indent-haml-region)