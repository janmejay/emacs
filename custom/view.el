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

(defun enable-ecb-and-switch-to-dir-window ()
  (ecb-activate)
  (ecb-goto-window-directories))

(setq ecb-is-enabled nil)
(defun toggle-ecb-activation ()
  (interactive)
  (if ecb-is-enabled (ecb-deactivate)
    (enable-ecb-and-switch-to-dir-window))
  (setq ecb-is-enabled (not ecb-is-enabled)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left3" (0.1921182266009852 . 0.35294117647058826) (0.1921182266009852 . 0.3137254901960784) (0.1921182266009852 . 0.3137254901960784)))))
 '(ecb-options-version "2.33beta2")
 '(ecb-source-path (find-all-emacs-projects))
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
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 60 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(ecb-layout-switch "left3")
(ecb-activate)

;;(global-set-key (kbd "<f6>") 'ecb-goto-window-sources)
;;(global-set-key (kbd "<f7>") 'ecb-goto-window-methods)

(set-frame-size-according-to-resolution)

(require 'window-numbering)
(window-numbering-mode 1)


;; Set encoding to UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Useful key strokes
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-p" 'emacs-wiki-change-project)

;; Anti Aliasing
;; (setq mac-allow-anti-aliasing t)
(setq mac-allow-anti-aliasing nil)

;; Frame title : set to buffer name
(setq frame-title-format "Emacs - %f ")
(setq icon-title-format  "Emacs - %b")

;; Editor Preferences
(column-number-mode t)  ;; Show column numbers
(menu-bar-mode nil)     ;; Disable menu bar
(setq-default truncate-lines t)
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)   ;; Scrolling 
(show-paren-mode t)                  ;; Highlight parens 
(setq show-paren-style 'parentheses) ;; Shor parens
(blink-cursor-mode nil)              ;; Disable blinking of cursor
(fset 'yes-or-no-p 'y-or-n-p)        ;; Alias Y and N
(setq message-log-max 100)           ;; Set log buffer size
;; (resize-minibuffer-mode 1) ;; Resize buffer depending on text
(follow-mode t)                     ;; Easier editing of longs files
(setq inhibit-startup-message t)    ;; Disable start up message
(setq search-highlight t)           ;; Highlight search results
(setq kill-whole-line t)            ;; Kill whole line
(setq backup-inhibited t)           ;; Never backup
(setq column-number-mode t)         ;; Show column numbers
(setq line-number-mode 1)           ;; Show line numbers
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
(setq visible-bell t)               ;; Visable bells
;; (kill-buffer "*scratch*") ;; Kill default scratch buffer
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)