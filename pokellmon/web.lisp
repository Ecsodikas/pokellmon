(in-package #:pokellmon)

(defparameter *acceptor* nil)

(easy-routes:defroute index ("/" :method :get) ()
  (let* ((current-entry (first (get-latest-n-entry 1)))
         (action (third current-entry))
         (reason (fourth current-entry))
         (image (fifth current-entry)))
    (spinneret:with-html-string
        (:doctype)
      (:html
       (:head
        (:title "PokeLLMon")
        (:link :attrs (list :rel "stylesheet" :href "nes.css"))
        (:style (:raw "* { font-family: \"PressStartToPlay\"; }"))
        (:body
         (:section :class "nes-container is-centered with-title"
                   (:h3 :class "title" "Current Frame")
                   (:img :style "image-rendering: pixelated; width: 100%;" :src (concatenate 'string "data:image/png;base64, " image)))
         (:section :class "nes-container is-centered with-title"
                   (:h3 :class "title" "Button Press")
                   (:p action))
         (:section :class "nes-container is-centered with-title"
                   (:h3 :class "title" "Reasoning")
                   (:p reason))
         (:section :class "nes-container with-title"
                   (:h3 :class "title" "What is this?")
                   (:p "What you are seeing here is an example of a LLM used in a completely wrong way.
It gets fed the current screenshot of the game and gets prompted to play the game as efficiently as possible.
As you can see, this does not work exceptionally well. In fact, the LLM does not understand anything it is doing here.
This should be a reminder that not everything BIG AI is telling you should be taken at face value. LLMs are nice tools
for tasks that do not require understanding of the domain and perfect precision. For everything else they are risky at best
and a real danger for life and health at worst. And let's not get started on energy efficiency."))
         (:section :class "nes-container with-title"
                   (:h3 :class "title" "For nerds")
                   (:p "The emulator runs with 5 frames per second and the LLM is currently evaluating a request in about 20-30 seconds.
(Yes, I am not renting a full fleged GPU server for this project. I just let it run.)")
                   (:p "I store every frame in a database. That allows me to render a timelaps of the process after some time. I'll add the
timelapses to this page.")
                   (:ul
                    (:li "The LLM in use is the llava model with 7 billion parameters.")
                    (:li (:a :href "https://github.com/skylersaleh/SkyEmu" "SkyEmu") " is the emulator in use.")
                    (:li "Yes, I own a real copy of Pokemon Emerald.")
                    (:li "The project is written in " (:a :href "https://en.wikipedia.org/wiki/Common_Lisp" "Common Lisp.") "#lovetheparentheses")
                    (:li "There is a possibility that I lost all data by being a little derp. We have to go agane! (Smol WoW Hardcore reference.)")))))))))

(defun stop-server ()
  (when *acceptor*
    (hunchentoot:stop *acceptor*)))

(defun start-server (port)
  (stop-server)
  (hunchentoot:start (setf *acceptor*
                           (make-instance 'easy-routes:easy-routes-acceptor :port port
                                                                            :document-root #p"./assets/"))))
