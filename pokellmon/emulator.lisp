(in-package #:pokellmon)

(defun step-frame (&optional (amount 1))
  (drakma:http-request (concatenate 'string *emulator-base-uri* "/step?frames=" (write-to-string amount))))

(defun get-screen ()
  (flexi-streams:octets-to-string
   (drakma:http-request (concatenate 'string *emulator-base-uri* "/screen"))))

(defun send-action (action)
  (drakma:http-request (concatenate 'string *emulator-base-uri* "/input?" action "=0"))
  (sleep 0.2)
  (drakma:http-request (concatenate 'string *emulator-base-uri* "/input?" action "=1"))
  (sleep 0.2)
  (drakma:http-request (concatenate 'string *emulator-base-uri* "/input?" action "=0")))
