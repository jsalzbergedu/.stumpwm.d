(print "%{c}%{F#899BA6}%{B#C03C4C55} Welcome! %{F-}%{B-}")
(import chicken scheme)
(use srfi-18)
(use posix)
(use s)
(use utils)

(define (getinput program args)
  (receive (in out pid) (process program args)
    (let ((input (read in)))
      (close-input-port in)
      (close-output-port out)
      input)))

(define (icon glyph)
  (let ((symbols
	 '(("emacs" . "ԑ")
	   ("poweroff" . "◯")
	   ("wifi-min" . "")
	   ("wifi-mid" . "")
	   ("wifi-max" . "")
	   ("batheavy" . "■")
	   ("batghostly" . "%{F#4d5d66}■%{F#899BA6}"))))
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

(define (wifi-str-maybe)
  (lambda (some none)
    (cond ((check-process "iw wlp4s0 link > /dev/null 2>&1")
	   (some (getinput "./wifi_str.sh" '("wlp4s0"))))
	  ((check-process "iw wlan0 link > /dev/null 2>&1")
	   (some (getinput "./wifi_str.sh" '("wlan0"))))
	  (else (none)))))

(define (wifi)
  ((wifi-str-maybe)
   (lambda (strn) (if (number? strn)
		 (cond ((>= strn -55)
			(icon "wifi-max"))
		       ((and (< strn -55) (>= strn -75))
			(icon "wifi-mid"))
		       (else
			(icon "wifi-min")))
		 " "))
   (lambda () " ")))

(define (ssid-maybe)
  (lambda (some none)
    (cond ((check-process "iw wlp4s0 link > /dev/null 2>&1")
	   (some (getinput "./network.sh" '("wlp4s0"))))
	  ((check-process "iw wlan0 link > /dev/null 2>&1")
	   (some (getinput "./network.sh" '("wlan0"))))
	  (else (none)))))

(define (ssid)
  ((ssid-maybe)
   (lambda (s) (if (string? s) s " "))
   (lambda () " ")))

(define (poweroff)
  (icon "poweroff"))

(define-syntax exn->maybe
  (syntax-rules ()
    ((_ genexn)
     (lambda (some none)
       (let ((exn-raised? (gensym 'exn-raised)))
       (let ((res (condition-case genexn [(exn) exn-raised?])))
	 (if (equal? res exn-raised?)
	     (none)
	     (some res))))))))

(define (unchomped-string-maybe->number-maybe op)
  (lambda (some none)
    (op (lambda (res) (let ((num (string->number (s-chomp res))))
		   (if num
		       (some num)
		       (none))))
	(lambda () (none)))))

(define (bat-maybe n)
  (lambda (some none)
    (let* ((n-as-str (number->string n))
	   (batteryn-energy-now (string-append "/sys/class/power_supply/BAT" n-as-str "/energy_now"))
	   (batteryn-energy-full (string-append "/sys/class/power_supply/BAT" n-as-str "/energy_full")))
      (let ((energy-now-string (exn->maybe (read-all batteryn-energy-now)))
	    (energy-full-string (exn->maybe (read-all batteryn-energy-full))))
	(let ((energy-now
	       (unchomped-string-maybe->number-maybe energy-now-string))
	      (energy-full (unchomped-string-maybe->number-maybe energy-full-string)))
	  (if (and energy-now energy-full)
	      (energy-now
	       (lambda (numerator)
		 (energy-full
		  (lambda (denominator) (* 100 (/ numerator denominator)))
		  (lambda () (none))))
	       (lambda () (none)))
	      (none)))))))

(define (bat0)
  ((bat-maybe 0) identity (lambda () 0)))

(define (bat1)
  ((bat-maybe 1) identity (lambda () 0)))

(define (round-nearest-whole n)
  (let ((smallest-wholn-gt-n (ceiling n)) (greatest-wholen-st-n (floor n)))
    (if (<= (- smallest-wholn-gt-n n) 0.5)
	smallest-wholn-gt-n
	greatest-wholen-st-n)))

(define (bat)
  (let ((num-full-bars (round-nearest-whole (/ (+ (bat0) (bat1)) 50))))
    (let for ((i 4) (acc ""))
      (if (= i 0)
	  acc
	  (if (> i (- 4 num-full-bars))
	      (for (- i 1) (string-append acc (icon "batheavy")))
	      (for (- i 1) (string-append acc (icon "batghostly"))))))))

(define (main)
  (display (string-append
	    "%{c}%{F#899BA6}%{B#C03C4C55} " (clock) " " (ssid) " " (wifi)
	    " %{A:emacs --daemon:}" (emacs) "%{A} " (bat) " %{A: systemctl poweroff:}" (poweroff) " %{A}%{F-}%{B-}\n"))
  (thread-sleep! 1)
  (main))

(main)
