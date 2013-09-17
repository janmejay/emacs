(require 'erc)

(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#gnu" "#gcc" "#modest" "#maemo")
        (".*\\.gimp.org" "#unix" "#gtk+")))

(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

                                "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

      (erc-track-switch-buffer 1) ;; yes: switch to last active
      (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
        (load-file "~/.erc-authinfo.el.gpg"))))

(global-set-key (kbd "C-c e") 'erc-start-or-switch) ;; ERC
