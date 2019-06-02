#!/bin/sh
#|
exec sbcl --script "$0" "$@"
# |#
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
(ql:quickload :stumpwm)
(stumpwm:stumpwm)
