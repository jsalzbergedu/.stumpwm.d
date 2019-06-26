;; An initfile
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

(set-module-dir
 (pathname-as-directory (concat (getenv "HOME") "/.stumpwm.d/stumpwm-contrib")))

;; Themeing
(setf *window-border-style* :none)
(load-module "ttf-fonts")
;; (set-font (make-instance 'xft:font
;;                          :family "SauceCodePro Nerd Font"
;;                          :subfamily "Regular"
;;                          :size 12))

;; Gaps
(load-module "swm-gaps")

(setf swm-gaps:*inner-gaps-size* 12)
(setf swm-gaps:*outer-gaps-size* 24)
(run-commands "toggle-gaps")


;; Keybindings

;; motion
(define-key *root-map* (kbd "h") "move-focus left")
(define-key *root-map* (kbd "l") "move-focus right")
(define-key *root-map* (kbd "k") "move-focus up")
(define-key *root-map* (kbd "j") "move-focus down")

(define-key *root-map* (kbd "d") "exec firefox")

(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C-c") "exec kitty")

(run-shell-command "~/.swapcaps.sh")
