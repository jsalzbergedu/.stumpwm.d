(use jsetroot)
(use utils)
(use srfi-18)
(import foreign)

(define home (get-environment-variable "HOME"))

(define framedir (string-append home "/.stumpwm.d/data/frames/"))

(define frames
  (let for ((i 21) (acc '()))
	     (if (>= i 1)
		 (for (- i 1) (cons (string-append framedir (number->string i) ".png") acc))
		 acc)))

(get-display! (lambda (display)

		(define partial-set-background-image! (lambda (frame) (set-background-image! frame display)))
		
		(define frameprocs
		  (map (lambda (frame) (lambda () (partial-set-background-image! frame))) frames))

		(define (set-background-images! proclist)
		  (if (= (length proclist) 0)
		      #t
		      (begin
			((car proclist))
			(thread-sleep! 0.05)
			(set-background-images! (cdr proclist)))))
		
		(define (day)
		  (set-background-images! frameprocs))

		(define (night)
		  (set-background-images! (reverse frameprocs)))

		(define (getinput program args)
		  (receive (in out pid) (process program args)
		    (let ((input (read in)))
		      (close-input-port in)
		      (close-output-port out)
		      input)))

		(define init 0)
		(define dayl 1)
		(define nigh 2)

		(define (main mode)
		  (let ((current-time (getinput (string-append home "/.stumpwm.d/time.sh") '("")))
			(daylight-begins (getinput (string-append home "/.stumpwm.d/civs.sh") '("")))
			(daylight-ends (getinput (string-append home "/.stumpwm.d/cive.sh") '(""))))
		    (print "current time is: " current-time)
		    (print "daylight begins: " daylight-begins)
		    (print "daylight ends:  " daylight-ends)
		    (if (and (>= current-time daylight-begins) (<= current-time daylight-ends))
			;; if [condition] then (daylight outside) else (night outside)
			(if (or (= mode init) (= mode nigh))
			    (begin (print "switching to day mode")
				   (day)
				   (thread-sleep! 60)
				   (main dayl))
			    (begin (thread-sleep! 60)
				   (main dayl)))
			(begin
			  (if (or (= mode init) (= mode dayl))
			      (begin (print "switching to night mode")
				     (night)
				     (thread-sleep! 60)
				     (main night))
			      (begin (thread-sleep! 60)
				     (main night)))))))
		(main init)))
