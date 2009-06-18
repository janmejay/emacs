-> What is this? : This is my emacs setup, geared towards ruby/rails and elisp, once-in-a-while c++ development.

-> How to use this thing? : Assuming you are on unix/mac.... these steps should work....
    $ cd
    $ echo "(load-file \"~/.emacs.d/emacs.el\")" > .emacs
    $ git clone git://github.com/janmejay/emacs.git
    $ ln -s emacs .emacs.d
    $ emacs --debug-init #this will show you the stack trace if something is wrong (i guess ~/.emacs.d/defunkt/erlang.el may pop errors, because of path issues, change those paths to your system's erlang installation path)
    $ emacs -q # to byte compile js2(javascript mode). JS2 is slow for big files when not compiled. Use "M-x byte-compile-file RET ~/.emacs.d/vendor/js2.el RET". This should generate js2.elc(which is the byte compliation output)(warnings can safely be ignored).
    $ # doing emacs --debug-init again should start without any errors
    $ emacs #and enjoy the setup
  change the directory locations to fit your taste.

-> How do i find out what went wrong when i tried to do THAT? : M-x 'toggle-debug-on-error' and it will show you what went wrong.

-> How often should i pull? : May be once in a while, i will keep adding/removing/modifying things to make them work better for me, you may like those modifications, so pulling once in a while may be something you want to do...)

-> Why have i not tried/added/enabled that cool addon called X? : Because i didn't know about it... please drop me a message on my github profile... :-)
