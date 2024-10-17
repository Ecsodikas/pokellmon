;;;; pokellmon.lisp

(in-package #:pokellmon)

(defparameter *emulator-base-uri* nil)
(defparameter *database-uri* nil)
(defparameter *database-port* nil)
(defparameter *database-password* nil)
(defparameter *database-name* nil)
(defparameter *database-user* nil)
(defparameter *llm-base-uri* nil)
(defparameter *llm-name* nil)
(defparameter *prompt* "You are the main character in Pokemon Emerald player and you want to beat the game as fast as possible.
You are playing right now and here you have a screenshot of your current game.
What would be the best possible button press out of A, B, Left, Up, Down, Right, Start, Select be?
Answer only in JSON format in the form of the following example:
{\\\"action\\\": \\\"A\\\", \\\"reason\\\": \\\"This button was pressed because I need to know what Pokemon I have.\\\"}
You have to make the best decision to progress the game state.
Don't write any other text or symbols including the ```json in your response other than the valid json.")


(defun set-env ()
  (let ((env-hash (cl-dotenv:read-env ".env")))
    (setf *emulator-base-uri* (gethash "EMULATOR_BASE_URI" env-hash))
    (setf *database-uri* (gethash "DATABASE_URI" env-hash))
    (setf *database-port* (parse-integer (gethash "DATABASE_PORT" env-hash)))
    (setf *database-password* (gethash "DATABASE_PASSWORD" env-hash))
    (setf *database-name* (gethash "DATABASE_NAME" env-hash))
    (setf *database-user* (gethash "DATABASE_USER" env-hash))
    (setf *llm-base-uri* (gethash "LLM_BASE_URI" env-hash))
    (setf *llm-name* (gethash "LLM_NAME" env-hash))))


(defun step-f ()
  (step-frame)
  (sleep 0.1)
  (step-f))

(defun main ()
  (set-env)
  (postmodern:connect-toplevel *database-name* *database-user* *database-password* *database-uri* :port *database-port*)
  (migrate)
                                        ; Let emulator step forward 5 times per second.
  (sb-thread:make-thread
   (lambda () (step-f)))
                                        ; Start web server on port 6789
  (start-server 6789)
                                        ; Run logic loop
  (loop
    (let* ((screen (cl-base64:string-to-base64-string (get-screen)))
           (response (send-prompt *prompt* screen))
           (action (first response))
           (reason (second response)))
      (insert-entry *llm-name*
                    action
                    reason
                    (write-to-string (get-universal-time))
                    screen)
      (send-action action))))
