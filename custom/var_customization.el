(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 

 '(ecb-windows-width 0.2)
 '(ecb-options-version "2.33beta2")
 '(ecb-source-path (find-all-emacs-projects))
 '(ecb-tip-of-the-day nil)
 '(case-fold-search nil)
 '(cua-mode nil nil (cua-base))
 '(jde-jdk-registry (quote (("1.6" . "/usr/local/jdk_1_6/bin/java"))))
 '(jde-gen-k&r t)
 '(show-paren-mode t)
 '(highlight-current-line-globally t)
 '(semanticdb-default-file-name ".semantic.cache")
 '(semanticdb-default-save-directory "~/.emacs.d/.semantic")
 '(gdb-many-windows t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 92 :width expanded :foundry "unknown" :family "Ubuntu Mono")))))


(setq junit-jar-location "~/projects/code_review/junit-4.3.1.jar")

(defvar *textmate-project-roots*
  '(".git" ".hg" ".emacs_project")
  "The presence of any file/directory in this list indicates a project root.")
