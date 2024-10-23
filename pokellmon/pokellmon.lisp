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
(defparameter *prompt* "You are controlling the main character in Pokemon Emerald and you want to beat the game as fast as possible.
You are playing right now and you can the  screenshot of your current game state.
What would be the best possible button press out of A, B, Left, Up, Down, Right, Start, Select be?
Up, Left, Down, Right move your character in the given direction.
A lets you interact with stuff you are facing.
B lets you abort actions.
Start opens and closes the menu.
Select does mostly nothing.
If you don't know what to do next, just explore and talk to NPCs and evaluate again.
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
  (sleep 0.2)
  (step-f))

(defun main ()
  (write-line "Init environment.")
  (set-env)
  (write-line "Migrate database if necessary.")
  (migrate)
                                        ; Let emulator step forward 5 times per second.
  (sb-thread:make-thread
   (lambda () (step-f)))
                                        ;Start web server on port 6789
  (write-line "Starting Hunchentoot server on port 6789.")
  (start-server 6789)
                                        ; Run logic loop
  (write-line "Starting main loop.")
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
      (ignore-errors
       (send-action action))
      (sleep 0.5))))
