(in-package #:pokellmon)

(defun migrate ()
  (unless (postmodern:table-exists-p 'logs)
    (postmodern:query (:create-table 'logs
                                     ((id :type integer :primary-key t :identity-always t)
                                      (name :type string :check (:<> 'name ""))
                                      (action :type string :check (:<> 'action ""))
                                      (reasoning :type string)
                                      (screen :type string :check (:<> 'screen ""))
                                      (timestamp :type string))))))

(defun insert-entry (name action reasoning timestamp screen)
  (postmodern:query (:insert-into 'logs :set
                                  'name name
                                  'reasoning reasoning
                                  'action action
                                  'screen screen
                                  'timestamp timestamp)))

(defun get-latest-n-entry (n)
  (~> (postmodern:query (:limit (:order-by
                                 (:select :* :from 'logs)
                                 (:desc 'id))
                                n))))
