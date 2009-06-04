;;this is a wrapper, as jde expects avltree to be available in the load path, and not avl-tree (which is what avl-tree.el provides)

(require 'avl-tree)
(provide 'avltree)

