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
(clx-truetype:cache-fonts)
(set-font (make-instance 'xft:font
	   :family "Fira Mono"
	   :subfamily "Bold"
	   :size 12
	   :antialias t))

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

(define-key *root-map* (kbd "e") "exec emacsclient -c")
(define-key *root-map* (kbd "C-e") "exec emacsclient -c")
(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C-c") "exec kitty")

(run-shell-command "~/.swapcaps.sh")
(run-shell-command "compton")


(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :none
      *message-window-padding* 0
      *maxsize-border-width* 0
      *normal-border-width* 0
      *transient-border-width* 0
      stumpwm::*float-window-border* 2
      stumpwm::*float-window-title-height* 5
      *mouse-focus-policy* :click)

(set-fg-color "#4d4d4c")
(set-bg-color "#ffffff")
(set-border-color "#d9d9d9")
