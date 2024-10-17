;;;; pokellmon.asd

(asdf:defsystem #:pokellmon
  :build-operation program-op
  :build-pathname "pokellmon"
  :entry-point "pokellmon:main"
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
               :drakma
               :cl-dotenv
               :spinneret
               :postmodern
               :yason)
  :components ((:file "package")
               (:file "database")
               (:file "emulator")
               (:file "llm")
               (:file "web")
               (:file "pokellmon")))
