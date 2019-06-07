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
