;; -*- mode: Lisp; eval: (stumpwm-mode 1); -*-

(in-package :stumpwm)
(defcommand winfirefox () () (sb-thread:make-thread (lambda () (sb-ext:run-program "/home/jacob/winfirefox.sh" '("")))))
(define-key *root-map* (kbd "d") "exec firefox")
(define-key *root-map* (kbd "c") "exec urxvtc")
(define-key *root-map* (kbd "C-c") "exec urxvtc")
(define-key *root-map* (kbd "e") "exec urxvtc -e emacsclient -nw")
(define-key *root-map* (kbd "C-e") "exec emacsclient -c")
(define-key *root-map* (kbd "C-M-d") "exec systemctl poweroff")
;;TODO rebind redisplay, help-map, info
(define-key *root-map* (kbd "l") "move-focus right")
(define-key *root-map* (kbd "h") "move-focus left")
(define-key *root-map* (kbd "j") "move-focus down")
(define-key *root-map* (kbd "k") "move-focus up")
(define-key *root-map* (kbd "C-M-f") "toggle-gachromapnmasdfs")
(if nil (sb-ext:run-program "wine" '("/home/jacob/Downloads/ffx_installer.exe")) '())
