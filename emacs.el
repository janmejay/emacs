(setq overrides)

(nconc load-path '("~/.emacs.d"
                   "~/.emacs.d/vendor"
                   "~/.emacs.d/vendor/goodies"
                   "~/.emacs.d/vendor/goodies/test-runner"
                   "~/.emacs.d/vendor/collection"
                   "~/.emacs.d/vendor/collection/ruby"
                   "~/.emacs.d/vendor/rinari"
                   "~/.emacs.d/vendor/yasnippet"
                   "~/.emacs.d/vendor/haml/extra"
                   "~/.emacs.d/vendor/ecb"
                   "~/.emacs.d/vendor/jde/lisp"
                   "~/.emacs.d/vendor/slime"
                   "~/.emacs.d/vendor/slime/contrib"
                   "~/.emacs.d/vendor/clojure"))
(nconc exec-path '("~/bin"))

;;making rope available in python load path assuming pymacs is installed
;;if not, use your OS' package manager to get it. (on gentoo i use app-emacs/pymacs)
(setq pymacs-load-path '("~/.emacs.d/vendor/rope"
                         "~/.emacs.d/vendor/ropemacs"))

;;elib must be installed locally (debian (elib) and gentoo (app-emacs/elib) have it available as a package)

;;(require 'jde)

(require 'haml-mode)
(require 'sass-mode)

(load "custom/view")
(load "custom/additions")
(load "custom/behaviour")
(load "custom/irc-startup")
(load "~/.emacs.d/vendor/scratch-el/scratch.el")

(require 'tabbar)

(load "defunkt")
(load "custom/overrides.el")