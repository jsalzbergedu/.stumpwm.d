;; -*- mode: Lisp; eval: (stumpwm-mode 1); -*-

(in-package :stumpwm)
(define-key *root-map* (kbd "d") "exec firefox")
(define-key *root-map* (kbd "c") "exec urxvtc")
(define-key *root-map* (kbd "C-c") "exec urxvtc")
(define-key *root-map* (kbd "e") "exec urxvtc -e emacsclient -nw")
(define-key *root-map* (kbd "C-e") "exec urxvtc -e emacsclient -nw")
