(setq overrides)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

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
                   "~/.emacs.d/vendor/jde/lisp"))

(nconc exec-path '("~/bin"))

;;making rope available in python load path assuming pymacs is installed
;;if not, use your OS' package manager to get it. (on gentoo i use app-emacs/pymacs)
(setq pymacs-load-path '("~/.emacs.d/vendor/rope"
                         "~/.emacs.d/vendor/ropemacs"))

;;elib must be installed locally (debian (elib) and gentoo (app-emacs/elib) have it available as a package)

(load "cedet/common/cedet")
;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)

(require 'jde)

(require 'ecb)

(require 'haml-mode)
(require 'sass-mode)

(load "custom/view")
(load "custom/additions")
(load "custom/behaviour")
(load "custom/irc-startup")

(require 'tabbar)

(load "defunkt")
(load "custom/overrides.el")