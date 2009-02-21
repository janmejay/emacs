(add-to-list 'load-path 
             "~/.emacs.d")
(add-to-list 'load-path 
             "~/.emacs.d/vendor")
(add-to-list 'load-path 
             "~/.emacs.d/vendor/goodies")
(add-to-list 'load-path
             "~/.emacs.d/vendor/collection")
(add-to-list 'load-path
             "~/.emacs.d/vendor/jump")
(add-to-list 'load-path 
	     "~/.emacs.d/vendor/yasnippet")
(add-to-list 'load-path 
	     "~/.emacs.d/vendor/ecb")

(load "cedet/common/cedet")
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

(require 'ecb)

(load "custom/view")
(load "custom/behaviour")

(require 'tabbar)
(require 'jump)

(load "defunkt")
