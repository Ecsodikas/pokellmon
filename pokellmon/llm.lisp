(in-package #:pokellmon)


(defun send-prompt (prompt image)
  (let* ((prompt (remove #\newline (concatenate 'string "{
\"model\": \"llava-phi3\",
\"stream\": false,
\"temperature\": 0,
\"prompt\":\"" prompt "\",\"images\": [\"" image "\"]}\"")))
         (result (ignore-errors (string-replace "```json" (flexi-streams:octets-to-string
                                                           (drakma:http-request (concatenate 'string *llm-base-uri* "/api/generate")
                                                                                :method :post
                                                                                :content prompt
                                                                                :connection-timeout 180))
                                                ""))))
    (if result
        (list
         (gethash "action" (yason:parse (gethash "response" (yason:parse result))))
         (gethash "reason" (yason:parse (gethash "response" (yason:parse result)))))
        (progn
          (list (random-elt '("Right" "Left" "Top" "Bottom" "Start" "Select" "A" "B"))
                "Because I couldn't understand what I was looking at I chose a random action.")))))
