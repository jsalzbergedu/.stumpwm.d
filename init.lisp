;; -*- mode: Lisp; eval: (stumpwm-mode 1); -*-
;;; Init file for stumpwm

(in-package :stumpwm)
;; Make stumpm handle errors better
(setf stumpwm:*top-level-error-action* :break)

;; Start swank on 4004 to interact with stumpwm from slime
(require :swank)
(swank-loader:init)
(swank:create-server
 :port 4004
 :style swank:*communication-style*
 :dont-close t)

;; Set directory for modules
(set-module-dir
 (pathname-as-directory (concat (getenv "HOME") "/.stumpwm.d/stumpwm-contrib/")))


;; Load aesthetic things
(load "~/.stumpwm.d/themes.lisp")


;;;; Load miscellaneous plugins
;;(load "/home/jacob/.stumpwm.d/plugins.lisp")


;; Load miscellaneous keybindings
(load "/home/jacob/.stumpwm.d/keybindings.lisp")


;; Do other initialization tasks
(run-shell-command "/usr/bin/bash ~/.stumpwm.d/stumpinit.sh")
