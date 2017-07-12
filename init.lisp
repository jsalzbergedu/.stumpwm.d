;; -*- mode: Lisp; eval: (stumpwm-mode 1); -*-
;;; Init file for stumpwm

(in-package :stumpwm)

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

;; Load gaps, lepisma's module that adds interior and exterior gaps to the original gaps gist
;; (load-module "swm-gaps")

;; ;; According to lepisma:
;; ;; Inner gaps run along all the 4 borders of a frame
;; (setf swm-gaps:*inner-gaps-size* 12)

;; ;; Outer gaps add more padding to the outermost borders
;; ;; (touching the screen border)
;; (setf swm-gaps:*outer-gaps-size* 24)
;; ;; end qoute

;; ;; Remove window borders:
;; (setf *normal-window-border* 0)
;; (setf *window-border* 0)
;; (setf *window-border-style* :none)

;; ;; Set popup window colors and font:
;; (load-module "ttf-fonts")
;; (set-font (make-instance
;; 	   'xft:font
;; 	   :family "Fira Mono"
;; 	   :subfamily "Bold"
;; 	   :size 9
;; 	   :antialias t))
;; ;; Thanks lepisma for your annotated init
;; (setf *colors* (list "#3c4c55"      ; 0 black
;;                      "#d18ec2"      ; 1 red
;;                      "#ff6a6a"      ; 2 green
;;                      "#dada93"      ; 3 yellow
;;                      "#83afe5"      ; 4 blue
;;                      "#9a93e1"      ; 5 magenta
;;                      "#7fc1ca"      ; 6 cyan
;;                      "#899ba6"))    ; 7 white
;; (update-color-map (current-screen))
;; (set-fg-color "#899ba6")
;; (set-bg-color "#3c4c55")
;; (set-border-color "#3c4c55")
;; ;; Set up frames
;; (restore-from-file "~/.stumpwm.d/data/framedefault")

;; ;; Call toggle-gaps
;; (run-commands "toggle-gaps")
;; (define-key *root-map* (kbd "1") "toggle-gaps")

;; Load generic keybindings
(load "/home/jacob/.stumpwm.d/keybindings.lisp")


;; Do other initialization tasks
(run-shell-command "/usr/bin/bash ~/.stumpwm.d/stumpinit.sh")
