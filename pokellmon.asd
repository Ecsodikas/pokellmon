;;;; pokellmon.asd

(asdf:defsystem #:pokellmon
  :description "Describe pokellmon here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot
               :alexandria
               :serapeum
               :cl-base64
               :easy-routes
               :dexador
               :cl-dotenv
               :spinneret
               :postmodern)
  :components ((:file "package")
               (:file "emulator")
               (:file "database")
               (:file "web")
               (:file "pokellmon")))
