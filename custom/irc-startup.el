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

(setq rcirc-time-format "%H:%M ")

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

(defun bring-forth-all-irc-windows ()
  (interactive)
  (delete-other-windows)
  (being-forth-all-irc-channels rcirc-server-alist))

(defun being-forth-all-irc-channels (server-alist)
  (let ((server-alist-elem (car server-alist)) (balance-server-alist (cdr server-alist)))
    (being-forth-irc-channels-for-server (car server-alist-elem) (caddr server-alist-elem))
    (if (> (length balance-server-alist) 0)
        (being-forth-all-irc-channels balance-server-alist))))

(defun being-forth-irc-channels-for-server (server channels)
  (let ((splitable (selected-window)) (irc-window-width 67))
    (setq splitable (split-window (selected-window) (- (window-width) irc-window-width) t))
    (create-window-for-channel-list channels server splitable)))

(defun create-window-for-channel-list (channel-list server splittable)
  (let ((height (/ (window-height splittable) (length channel-list)))
        (other-channels-list (cdr channel-list)))
    (set-window-buffer splittable (concat (car channel-list) "@" server))
    (setq splittable (split-window splittable height))
    (if (> (length other-channels-list) 0)
        (create-window-for-channel-list (cdr channel-list) server splittable))))
