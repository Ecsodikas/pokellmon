(in-package #:pokellmon)

(defun step-frame (base-uri &optional (amount 1))
  (write-line (concatenate 'string base-uri "/step?frames=" (write-to-string amount)))
  (drakma:http-request (concatenate 'string base-uri "/step?frames=" (write-to-string amount))))
