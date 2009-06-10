(add-to-list 'load-path "~/.emacs.d/vendor")

; custom place to save customizations
(setq custom-file "~/.emacs.d/defunkt/custom.el")
(load custom-file)

(when (file-exists-p ".passwords") (load ".passwords"))

(load "defunkt/lisp")
(load "defunkt/global")
(load "defunkt/defuns")
(load "defunkt/bindings")
(load "defunkt/modes")
(load "defunkt/theme")
(load "defunkt/temp_files")
(load "defunkt/github")
(load "defunkt/git")

(vendor 'ack)
(vendor 'cheat)
(vendor 'feature-mode)
(vendor 'magit)
(vendor 'gist)
(vendor 'growl)
(vendor 'haml-mode)
(vendor 'rhtml-mode)
(vendor 'sass-mode)
(vendor 'twittering-mode)
(vendor 'textile-mode)

(vendor 'textmate)
(textmate-mode)

(vendor 'yaml-mode)

(vendor 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")

