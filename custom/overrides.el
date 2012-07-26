;;exec all overrides
(mapcar (lambda (fn) (funcall fn)) overrides)

