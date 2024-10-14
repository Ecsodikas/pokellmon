(in-package #:pokellmon)

(defparameter *acceptor* nil)

(easy-routes:defroute index ("/foo" :method :get)
    (&get w)
  (format nil "<h1>FOO arg1: ~a arg2: 2 3</h1>" w))

(defun stop-server ()
  (when *acceptor*
    (hunchentoot:stop *acceptor*)))

(defun start-server ()
  (stop-server)
  (hunchentoot:start (setf *acceptor*
                           (make-instance 'easy-routes:easy-routes-acceptor :port 8090))))
