-> What is this? : This is my emacs setup, geared towards ruby/rails and elisp, once-in-a-while c++ development.

-> How to use this thing? : Assuming you are on unix/mac.... these steps should work.... 
    $ cd
    $ # install python and pymacs using your package manager (aptitude/emerge/yum/yast... whatever)
    $ # if you installed emacs from source or your dist doesn't wire pymacs in site-lisp.el, 
    $ # then you need to add pymacs initialization to your .emacs before loading emacs.el
    $ # try doing M-x load-library RET pymacs RET in your emacs session to find out if pymacs has been wired in
    $ # do the next line only if pymacs loading failed
    $ cat > .emacs # and paste the following lines in the terminal emulator
     (add-to-list 'load-path "/usr/share/emacs/site-lisp/pymacs") # i used path as used by my debian box, substitute it with your <site-python>/pymacs directory
     (autoload 'pymacs-apply "pymacs")
     (autoload 'pymacs-call "pymacs")
     (autoload 'pymacs-eval "pymacs" nil t)
     (autoload 'pymacs-exec "pymacs" nil t)
     (autoload 'pymacs-load "pymacs" nil t)
    $ # test if M-x load-library RET pymacs RET  (it should work now)
    $ # continue if successfully loaded pymacs in the previous test (you can use this repository without rope/ropemacs too(in which case, pymacs will not be required), few minutes of hacking should be enough to take pymacs out, if not, mail me and i will send you a patch to launch it without pymacs/rope)
    $ echo "(load-file \"~/.emacs.d/emacs.el\")" >> .emacs
    $ git clone git://github.com/janmejay/emacs.git
    $ ln -s emacs .emacs.d
    $ cd ~/.emacs.d
    $ git submodule init
    $ git submodule update
    $ cd vendor/rinari
    $ git submodule init
    $ git submodule update
    $ # install texinfo (Documentation system for on-line information and printed output) (debian users can fire up "sudo aptitude install texinfo" assuming aptitude is installed)
    $ # download elib(file named elib-1.0.tar.gz) from http://nixbit.com/cat/programming/libraries/elib/ and change to the directory elib is stored in
    $ tar -zxvf elib-1.0.tar.gz
    $ cd elib-1.0
    $ make # build it
    $ # edit Makefile, change "install: all installdirs install-info" to "install: all installdirs" (this is install target around line number 61) (install info fails)
    $ sudo make install # installing elib
    $ emacs --debug-init # verify if require for avltree bombs (if it does, that means site-lisp dir to which elib was installed is not in the load path). If not in the load path already, add (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/elib") as first line to ~/.emacs to make elib available to emacs.
    $ emacs --debug-init #this will show you the stack trace if something is wrong (i guess ~/.emacs.d/defunkt/erlang.el may pop errors, because of path issues, change those paths to your system's erlang installation path)
    $ emacs -q # to byte compile js2(javascript mode). JS2 is slow for big files when not compiled. Use "M-x byte-compile-file RET ~/.emacs.d/vendor/js2.el RET". This should generate js2.elc(which is the byte compliation output)(warnings can safely be ignored).
    $ # doing emacs --debug-init again should start without any errors
    $ emacs #and enjoy the setup
  change the directory locations to fit your taste.

-> How do i find out what went wrong when i tried to do THAT? : M-x 'toggle-debug-on-error' and it will show you what went wrong.

-> How often should i pull? : May be once in a while, i will keep adding/removing/modifying things to make them work better for me, you may like those modifications, so pulling once in a while may be something you want to do...)

-> Why have i not tried/added/enabled that cool addon called X? : Because i didn't know about it... please drop me a message on my github profile... :-)

-> Why is pymacs required? : I use ropemacs which is a terrific tool that takes emacs' python support to the next level(read about it -> http://rope.sourceforge.net/). You don't need it if you don't plan on hacking python code in emacs. However, the repo doesn't work without pymacs, so if you need to have it working without installing pymacs, drop me a mail so i can give you a little patch to fix it locally.
