(add-to-list 'load-path 
             "~/.emacs.d")
(add-to-list 'load-path 
	     "~/.emacs.d/vendor")
(add-to-list 'load-path 
	     "~/.emacs.d/vendor/goodies")
(add-to-list 'load-path 
	     "~/.emacs.d/vendor/ecb")

(load "cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(require 'ecb)

(load "custom/view")
(load "custom/behaviour")
