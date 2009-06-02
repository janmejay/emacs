;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)

;; Don't print /away messages.
;; This does not require rcirc to be loaded already,
;; since rcirc doesn't define a 301 handler (yet).
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")

;; Turn on spell checking.
(add-hook 'rcirc-mode-hook (lambda ()
                             (flyspell-mode 1)))

(setq rcirc-time-format "%Y-%m-%d %H:%M ")

;; Change user info
(setq rcirc-default-nick "janmejay")
(setq rcirc-default-port 8000)
(setq rcirc-default-user-name "janmejay")
(setq rcirc-default-user-full-name "Janmejay Singh")

(setq rcirc-server-alist 
      '(("irc.freenode.net" :channels
         ("#emacs" "#debian" "#rubyonrails" "#ruby" "#gosu" "#jruby")))) 


;; Connect to servers.
;(rcirc); freenode is the default
;(rcirc-connect "localhost"); if you run bitlbee, this will connect to it
