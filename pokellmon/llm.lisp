(in-package #:pokellmon)


(defun send-prompt (prompt image)
  (let* ((prompt (remove #\newline (concatenate 'string "{
\"model\": \"llava-phi3\",
\"stream\": false,
\"temperature\": 0,
\"prompt\":\"" prompt "\",\"images\": [\"" image "\"]}\"")))
         (result (string-replace "```json" (flexi-streams:octets-to-string
                                            (drakma:http-request (concatenate 'string *llm-base-uri* "/api/generate")
                                                                 :method :post
                                                                 :content prompt))
                                 "")))
    (list
     (gethash "action" (yason:parse (gethash "response" (yason:parse result))))
     (gethash "reason" (yason:parse (gethash "response" (yason:parse result)))))))
