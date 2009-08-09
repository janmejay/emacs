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
                   "~/.emacs.d/vendor/jde/lisp")) 

;;elib is locally installed (debian has an elib package)

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