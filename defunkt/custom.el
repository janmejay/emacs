;; customization
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 163 t)
 '(cua-keep-region-after-copy t)
 '(cua-mode t nil (cua-base))
 '(default-frame-alist (quote ((tool-bar-lines . 0) (foreground-color . "white") (background-color . "black") (menu-bar-lines . 1) (font . "-apple-inconsolata-medium-r-normal--20-160-72-72-m-160-iso10646-1"))))
 '(ecb-layout-window-sizes (quote (("left3"))))
 '(ecb-options-version "2.33beta2")
 '(ecb-source-path (cons "~/emacs_extensions" (find-all-emacs-projects)))
 '(ecb-tip-of-the-day nil)
 '(erc-modules (quote (autojoin button completion fill irccontrols match menu netsplit noncommands readonly ring scrolltobottom stamp track)))
 '(javascript-shell-command "johnson")
 '(js2-auto-indent-flag nil)
 '(js2-bounce-indent-flag t)
 '(js2-enter-indents-newline t)
 '(js2-highlight-level 3)
 '(js2-strict-missing-semi-warning t)
 '(pc-selection-mode t nil (pc-select))
 '(show-trailing-whitespace t)
 '(standard-indent 2)
 '(tabbar-mode t nil (tabbar))
 '(whitespace-global-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :family "monaco"))))
 '(autoface-default ((t (:inherit default :family "apple-inconsolata"))))
 '(ecb-analyse-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "#223322"))))
 '(ecb-directory-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-history-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-method-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-source-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(emacs-lisp-mode-default ((t (:inherit autoface-default :slant normal :weight normal))) t)
 '(minibuffer-prompt ((((background dark)) (:foreground "cyan"))))
 '(mode-line ((t (:inherit aquamacs-variable-width :background "grey25" :foreground "grey75" :width normal))))
 '(mode-line-inactive ((t (:inherit aquamacs-variable-width :background "grey10" :foreground "grey30" :box (:line-width -1 :color "grey20") :strike-through nil :underline nil :slant normal :weight normal :width normal))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "#321"))))
 '(tabbar-default ((t (:inherit nil :background "gray20" :foreground "gray60" :box nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :family "lucida grande"))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#432" :foreground "gray80" :box (:line-width 2 :color "#432")))))
 '(tabbar-selected-highlight ((t (:foreground "white"))))
 '(tabbar-separator ((t (:inherit tabbar-default :background "grey50" :foreground "grey50" :height 1.0))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "gray25"))))
 '(tabbar-unselected-highlight ((t (:foreground "grey75"))))
 '(text-mode-default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :width normal))) t)
 '(trailing-whitespace ((((class color) (background dark)) (:background "#042020")))))
