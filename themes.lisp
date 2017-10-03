;; -*- mode: Lisp; eval: (stumpwm-mode 1); -*-
(in-package :stumpwm)
(load-module "swm-gaps")

;; According to lepisma:
;; Inner gaps run along all the 4 borders of a frame
(setf swm-gaps:*inner-gaps-size* 12)

;; Outer gaps add more padding to the outermost borders
;; (touching the screen border)
(setf swm-gaps:*outer-gaps-size* 24)
;; end qoute

;; Remove window borders:
(setf *normal-window-border* 0)
(setf *window-border* 0)
(setf *window-border-style* :none)


;; Call toggle-gaps
(run-commands "toggle-gaps")
(define-key *root-map* (kbd "1") "toggle-gaps")

;; Set popup window colors and font:
(load-module "ttf-fonts")
(set-font (make-instance
	   'xft:font
	   :family "Fira Mono"
	   :subfamily "Bold"
	   :size 9
	   :antialias t))
;; Thanks lepisma for your annotated init
(setf *colors* (list "#3c4c55"      ; 0 black
                     "#d18ec2"      ; 1 red
                     "#a8ce93"      ; 2 green
                     "#dada93"      ; 3 yellow
                     "#83afe5"      ; 4 blue
                     "#7fc1ca"      ; 6 cyan
                     "#9a93e1"      ; 5 magenta
                     "#899ba6"))    ; 7 white
(update-color-map (current-screen))
(set-fg-color "#899ba6")
(set-bg-color "#3c4c55")
(set-border-color "#3c4c55")

;; Set up frames
(restore-from-file "~/.stumpwm.d/data/framedump")
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "#scheme"))
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "#rust"))
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "#rust-beginners"))
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "#stratis-storage"))
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "irc.mozilla.org:6667"))
;(define-frame-preference "Default" (0 t nil nil nil :class "Emacs" :title "irc.freenode.org:6667"))
