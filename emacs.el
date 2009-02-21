(nconc load-path '("~/.emacs.d"
                   "~/.emacs.d/vendor"
                   "~/.emacs.d/vendor/goodies"
                   "~/.emacs.d/vendor/collection"
                   "~/.emacs.d/vendor/jump"
                   "~/.emacs.d/vendor/yasnippet"
                   "~/.emacs.d/vendor/ecb"))

(load "cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(require 'ecb)

(load "custom/view")
(load "custom/behaviour")

(require 'tabbar)
(require 'jump)

(load "defunkt")
