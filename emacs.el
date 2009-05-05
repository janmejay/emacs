(add-to-list 'load-path 
             "~/.emacs.d")
(load "local")
(load "vendor/cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(add-to-list 'load-path
             "~/.emacs.d/vendor/ecb")
(load "custom/view")

(require 'ecb)

