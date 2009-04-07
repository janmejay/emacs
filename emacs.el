(add-to-list 'load-path 
             "~/.emacs.d")

(load "vendor/cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(add-to-list 'load-path
             "~/.emacs.d/vendor/ecb")
(require 'ecb)

(load "custom/view")