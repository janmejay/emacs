;; My .gnus.el... change the literals... and this shd work for someone else too...
;; i keep ~/.gnus.el symlinked to this file.

(setq user-mail-address "singh.janmejay@gmail.com")
(setq user-full-name "Janmejay Singh")
(setq gnus-check-new-newsgroups nil)

(setq gnus-select-method '(nnimap "gmail"
                                  (nnimap-authinfo-file "~/.authinfo.gpg")
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials "~/.authinfo.gpg"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "thoughtworks.com")


(load-file "~/.emacs.d/custom/gnus.el")