(nconc load-path '("~/.emacs.d"
                   "~/.emacs.d/vendor"
                   "~/.emacs.d/vendor/goodies"
                   "~/.emacs.d/vendor/goodies/test-runner"
                   "~/.emacs.d/vendor/collection"
                   "~/.emacs.d/vendor/collection/ruby"
                   "~/.emacs.d/vendor/rinari"
                   "~/.emacs.d/vendor/yasnippet"
                   "~/.emacs.d/vendor/ecb"))

(load "cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(require 'ecb)

(load "custom/view")
(load "custom/additions")
(load "custom/behaviour")

(require 'tabbar)

(load "defunkt")
(cua-mode nil)
