(setq overrides nil)

(nconc load-path '("~/.my.emacs.d"
                   "~/.my.emacs.d/vendor"
                   "~/.my.emacs.d/vendor/async"
                   "~/.my.emacs.d/vendor/swiper"
                   "~/.my.emacs.d/vendor/find-file-in-project"
                   "~/.my.emacs.d/vendor/linum"
                   "~/.my.emacs.d/vendor/goodies"
                   "~/.my.emacs.d/vendor/goodies/test-runner"
                   "~/.my.emacs.d/vendor/collection"
                   "~/.my.emacs.d/vendor/collection/ruby"
                   "~/.my.emacs.d/vendor/collection/js2-mode"
                   "~/.my.emacs.d/vendor/rinari"
                   "~/.my.emacs.d/vendor/yasnippet"
                   "~/.my.emacs.d/vendor/haml/extra"
                   "~/.my.emacs.d/vendor/puppet"
                   ;; "~/.my.emacs.d/vendor/ecb"
                   ;; "~/.my.emacs.d/vendor/ess/lisp"
                   ;; "~/.my.emacs.d/vendor/jde/lisp"
                   "~/.my.emacs.d/vendor/slime"
                   "~/.my.emacs.d/vendor/slime/contrib"
                   "~/.my.emacs.d/vendor/clojure"
                   "~/.my.emacs.d/vendor/scala-mode2"
                   "~/.my.emacs.d/vendor/go"
                   "~/.my.emacs.d/vendor/thrift-mode"
                   "~/.my.emacs.d/vendor/multiple-cursors"
                   "~/.my.emacs.d/vendor/vr"
                   "~/.my.emacs.d/vendor/vrs"
                   "~/.my.emacs.d/vendor/string-inflections"
                   "~/.my.emacs.d/vendor/disable-mouse"
                   "~/.my.emacs.d/vendor/tlamode/lisp"))
(nconc exec-path '("~/bin"))

(require 'cl-lib)

(require 'counsel)
(require 'swiper)
(require 'ivy)
(require 'find-file-in-project)

;; (require 'ecb)


;;making rope available in python load path assuming pymacs is installed
;;if not, use your OS' package manager to get it. (on gentoo i use app-emacs/pymacs)
;; (setq pymacs-load-path '("~/.my.emacs.d/vendor/rope"
;;                          "~/.my.emacs.d/vendor/ropemacs"))

;;elib must be installed locally (debian (elib) and gentoo (app-emacs/elib) have it available as a package)

;;(require 'jde)

(require 'markerpen)
(require 'haml-mode)
(require 'sass-mode)
;; (require 'csv-mode)
(require 'js2-mode)
;; (require 'ess-site)
(require 'thrift-mode)
(require 'multiple-cursors)
(require 'visual-regexp-steroids)

(load "custom/view")
(load "custom/additions")
(load "custom/macros")
(load "custom/behaviour")
(load "custom/irc-startup")
(load "~/.my.emacs.d/vendor/scratch-el/scratch.el")
(load "puppet-mode-init")

(autoload 'rust-mode "rust-mode" nil t)

;;(require 'tabbar);; lost after latest upgrade, don't know what it does, should bring it back soon

(load "defunkt")
(load "custom/daddy")
(load "custom/overrides.el")
(require 'bison-mode)
(autoload 'go-mode "go-mode" nil t)
(require 'go-guru)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(require 'string-inflection)

(require 'disable-mouse)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; RUN THIS THE VERY FIRST TIME ;;
;; (package-refresh-contents)
;; (package-install 'proof-general)
;; (package-install 'company-coq)

(require 'tla+-mode)
(transient-mark-mode t)
