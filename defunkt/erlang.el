(setq load-path (cons (car (file-expand-wildcards "/usr/lib/erlang/lib/tools-*/emacs")) load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
(defvar inferior-erlang-prompt-timeout t)