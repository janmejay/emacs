;;;;;; ido
(setq confirm-nonexistent-file-or-buffer nil)
(require 'ido)
(add-hook 'ido-setup-hook
          (lambda ()
            (setq ido-enable-flex-matching t)
            (global-set-key "\M-x" 'ido-execute-command)))
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion t)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil)
(setq ido-show-dot-for-dired t)
(setq ido-use-filename-at-point t)
(setq ido-enable-flex-matching nil)

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

;;python
(require 'pair-mode)

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
(define-key ruby-mode-map (kbd "C-{") 'ruby-encomment-region)
(define-key ruby-mode-map (kbd "C-}") 'ruby-decomment-region)

(load "ruby/rubydb3x")

;;;;; running tests
(require 'test-runner)

(global-set-key [(f7)] 'run-test)
(define-key ruby-mode-map (kbd "S-<f7>") 'run-current-rspec-block)

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

(defun my-python-mode-hook ()
  (pair-mode)
  (let ((key-map 
         (if (boundp 'py-mode-map) py-mode-map python-mode-map)))
    (define-key key-map (kbd "C-M-/") 'rope-code-assist)))

;; ropemacs configuration
(setq ropemacs-enable-shortcuts 'nil)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")


;; Add all of the hooks...
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'perl-mode-hook 'my-perl-mode-hook)
(add-hook 'python-mode-hook 'my-python-mode-hook)

(global-set-key (kbd "M-d") 'kill-word)


;;;;;aliases

(defalias 'sh 'ansi-term)
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)

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

(global-set-key (kbd "C-M-y") 'longlines-mode)
(global-set-key (kbd "C-x C-M-t") 'find-test-in-project)
(global-set-key (kbd "<f5>") 'toggle-ecb-activation)

;;pick up the corresponding tags file by recursively looking up parent dirs and add it to tags-table-list
(defadvice find-tag 
  (before discover-before-lookup)
  (discover-corresponding-tags-file))

(ad-activate 'find-tag)

(global-set-key (kbd "C-`") 'confirm-and-reset-tags-table)

(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

(define-key haml-mode-map (kbd "<RET>") 'newline-and-indent-in-haml)
(define-key haml-mode-map (kbd "C-;") 'indent-haml-region)

;;(setq js2-mode-must-byte-compile nil) 

(setq x-select-enable-clipboard t)

(global-set-key (kbd "C-M-t") 'transpose-lines)

(add-hook 'js2-mode-hook 
          (lambda () 
            (define-key js2-mode-map (kbd "C-c C-c") 'js-camelize)))

(global-set-key (kbd "<end>") 'bury-buffer)

(add-to-list 'overrides
             (lambda ()
               (cua-mode nil)
               (put 'set-goal-column 'disabled nil)

               (add-to-list 'auto-mode-alist '("\\.rhtml$" . nxml-mode))
               (add-to-list 'auto-mode-alist '("\\.html.erb$" . nxml-mode))
               (add-to-list 'auto-mode-alist '("buildfile" . ruby-mode))
               (add-to-list 'auto-mode-alist '("rakefile" . ruby-mode))
               (define-key *textmate-mode-map* (kbd "C-S-n") 'textmate-move-line-down)
               (define-key *textmate-mode-map* (kbd "C-S-p") 'textmate-move-line-up)
               (global-set-key (kbd "C-z") 'emacs-project-find)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/conkeror")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link) 
(define-key global-map "\C-ca" 'org-agenda)

(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" (buffer-substring beg end))))

(global-set-key (kbd "C-c C-q") 'google-region)

(global-set-key (kbd "<f11>") 'fullscreen)

(setq slime-lisp-implementations
      `((sbcl ("sbcl"))
;;        (sbcl ("sbcl"))
        ))

(eval-after-load "slime"
  '(progn
     (require 'slime-fancy)
     (require 'slime-banner)
     (require 'slime-asdf)
     (slime-banner-init)
     (slime-asdf-init)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (slime-setup)))

(require 'slime-autoloads)
(require 'slime)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (slime-mode t)))

(require 'clojure-mode)

(call-interactively 'server-start)

(require 'browse-kill-ring)
