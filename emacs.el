(setq overrides nil)

(nconc load-path '("~/.emacs.d"
                   "~/.emacs.d/vendor"
                   "~/.emacs.d/vendor/async"
                   "~/.emacs.d/vendor/swiper"
                   "~/.emacs.d/vendor/find-file-in-project"
                   "~/.emacs.d/vendor/linum"
                   "~/.emacs.d/vendor/goodies"
                   "~/.emacs.d/vendor/goodies/test-runner"
                   "~/.emacs.d/vendor/rust"
                   "~/.emacs.d/vendor/collection"
                   "~/.emacs.d/vendor/collection/ruby"
                   "~/.emacs.d/vendor/collection/js2-mode"
                   "~/.emacs.d/vendor/rinari"
                   "~/.emacs.d/vendor/yasnippet"
                   "~/.emacs.d/vendor/haml/extra"
                   "~/.emacs.d/vendor/puppet"
                   "~/.emacs.d/vendor/ecb"
                   "~/.emacs.d/vendor/ess/lisp"
                   ;;"~/.emacs.d/vendor/jde/lisp"
                   "~/.emacs.d/vendor/slime"
                   "~/.emacs.d/vendor/slime/contrib"
                   "~/.emacs.d/vendor/clojure"
                   "~/.emacs.d/vendor/scala-mode2"
                   "~/.emacs.d/vendor/go"
                   "~/.emacs.d/vendor/thrift-mode"
                   "~/.emacs.d/vendor/multiple-cursors"
                   "~/.emacs.d/vendor/vr"
                   "~/.emacs.d/vendor/vrs"
                   "~/.emacs.d/vendor/string-inflections"))
(nconc exec-path '("~/bin"))

(require 'cl-lib)

(require 'counsel)
(require 'swiper)
(require 'ivy)
(require 'find-file-in-project)

(require 'ecb)


;;making rope available in python load path assuming pymacs is installed
;;if not, use your OS' package manager to get it. (on gentoo i use app-emacs/pymacs)
;; (setq pymacs-load-path '("~/.emacs.d/vendor/rope"
;;                          "~/.emacs.d/vendor/ropemacs"))

;;elib must be installed locally (debian (elib) and gentoo (app-emacs/elib) have it available as a package)

;;(require 'jde)

(require 'markerpen)
(require 'haml-mode)
(require 'sass-mode)
(require 'csv-mode)
(require 'js2-mode)
(require 'ess-site)
(require 'thrift-mode)
(require 'multiple-cursors)
(require 'visual-regexp-steroids)

(load "custom/view")
(load "custom/additions")
(load "custom/behaviour")
(load "custom/irc-startup")
(load "~/.emacs.d/vendor/scratch-el/scratch.el")
(load "puppet-mode-init")

(autoload 'rust-mode "rust-mode" nil t)

;;(require 'tabbar);; lost after latest upgrade, don't know what it does, should bring it back soon

(load "defunkt")
(load "custom/daddy")
(load "custom/overrides.el")
(require 'bison-mode)
(require 'go-mode-autoloads)
(require 'go-guru)

(require 'string-inflection)
