(print "%{c}%{F#899BA6}%{B#C03C4C55} Welcome! %{F-}%{B-}")
(import chicken scheme)
(use srfi-18)
(use posix)

(define (getinput program args)
  (receive (in out pid) (process program args) (let ((input (read in)))
						 (close-input-port in)
						 (close-output-port out)
						 input)))

(define (icon glyph)
  (let ((symbols
	 '(("emacs" . "ԑ")
	   ("poweroff" . "◯")
	   ("wifi-min" . "")
	   ("wifi-mid" . "")
	   ("wifi-max" . ""))))
    (cdr (assoc glyph symbols))))

(define (emacs)
  (let ((emacs-up (if (= (system "emacsclient -e '(identity t)' > /dev/null 2>&1") 0)
		      #t #f)))
    (if emacs-up (icon "emacs") (string-append (icon "emacs") "!"))))

(define (clock)
  (getinput "./clock.sh" '("")))

(define (check-process process)
  (if (= 0 (system process))
      #t #f))

(define (wifi-str)
  (cond ((check-process "iw wlp4s0 link > /dev/null 2>&1")
	 (cons (getinput "./wifi_str.sh" '("wlp4s0")) #t)); return (wifi str . #t) of wlp4s0
	((check-process "iw wlan0 link > /dev/null 2>&1")
	 (cons (getinput "./wifi_str.sh" '("wlan0")) #t))
	(else
	 '(0 . #f)))) 

(define (wifi)
  (let* ((str (wifi-str)) (strn (car (wifi-str))) (strt (cdr (wifi-str))))
    (if (and strt (number? strn))
	(cond ((>= strn -55)
	       (icon "wifi-max"))
	      ((and (< strn -55) (>= strn -75))
	       (icon "wifi-mid"))
	      (else
	       (icon "wifi-min")))
	" ")))

(define (ssid-maybe)
  (lambda (some none)
    (cond ((check-process "iw wlp4s0 link > /dev/null 2>&1")
	   (some (getinput "./network.sh" '("wlp4s0")))); return (wifi str . #t) of wlp4s0
	  ((check-process "iw wlan0 link > /dev/null 2>&1")
	   (some (getinput "./network.sh" '("wlan0"))))
	  (else (none)))))

(define (ssid)
  ((ssid-maybe)
   (lambda (s) (if (string? s) s " "))
   (lambda () " ")))

(define (poweroff)
  (icon "poweroff"))

(define (main)
  (display (string-append
	    "%{c}%{F#899BA6}%{B#C03C4C55} " (clock) " " (ssid) " " (wifi)
	    " %{A:emacs --daemon:}" (emacs) "%{A} " "%{A: systemctl poweroff:}" (poweroff) " %{A}%{F-}%{B-}\n"))
  (thread-sleep! 1)
  (main))

(main)
