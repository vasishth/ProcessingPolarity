;;#+:mcl(set-mac-default-directory #P"Macintosh HD:Users:shravanvasishth:NPI:model:german-npi-mcl:") 

(defvar *current* nil)

(defparameter *cond-a* "kein mann der einen bart hatte war jemals gluecklich *stop*")
(defparameter *cond-b* "ein mann der keinen bart hatte war jemals gluecklich *stop*")
(defparameter *cond-c* "ein mann der einen bart hatte war jemals gluecklich *stop*")
(defparameter *cond-d* "kein mann der einen  bart hatte war durchaus gluecklich *stop*")
(defparameter *cond-e* "ein mann der keinen bart hatte war durchaus gluecklich *stop*")
(defparameter *cond-f* "ein mann der einen  bart hatte war durchaus gluecklich *stop*")

(defparameter *pirat-a* "kein pirat der einen  braten gegessen hatte war jemals sparsam *stop*")
(defparameter *pirat-b* "ein pirat der keinen  braten gegessen hatte war jemals sparsam *stop*")
(defparameter *pirat-c* "ein pirat der einen  braten gegessen hatte war jemals sparsam *stop*")
(defparameter *pirat-d* "kein pirat der einen  braten gegessen hatte war durchaus sparsam *stop*")
(defparameter *pirat-e* "ein pirat der keinen  braten gegessen hatte war durchaus sparsam *stop*")
(defparameter *pirat-f* "ein pirat der einen  braten gegessen hatte war durchaus sparsam *stop*")



;(defun cond-a () (setf *current* *cond-a*) (present-whole-sentence *current* 15))      ;; a, should be faster than b
;(defun cond-b () (setf *current* *cond-b*) (present-whole-sentence *current* 15))      ;; b
;(defun cond-c () (setf *current* *cond-c*) (present-whole-sentence *current* 15))      ;; c
;(defun cond-d () (setf *current* *cond-d*) (present-whole-sentence *current* 15))      ;; d
;(defun cond-e () (setf *current* *cond-e*) (present-whole-sentence *current* 15))      ;; e
;(defun cond-f () (setf *current* *cond-f*) (present-whole-sentence *current* 15))      ;; f


(defun conds-a-f ()
  (dolist (s `((A ,*cond-a*) (B ,*cond-b*) (C ,*cond-c*) (D ,*cond-d*) (E ,*cond-e*) (F ,*cond-f*)))
    (format t "~%~s" s)))


(defun present-condition (condition)
  (case condition
    (a (setf *current* *cond-a*) 
       (present-whole-sentence *current* 15))
    (b (setf *current* *cond-b*)
       (present-whole-sentence *current* 15)) 
    (c (setf *current* *cond-c*)
       (present-whole-sentence *current* 15))
    (d (setf *current* *cond-d*) 
       (present-whole-sentence *current* 15))
    (e (setf *current* *cond-e*) 
       (present-whole-sentence *current* 15))
    (f (setf *current* *cond-f*) 
       (present-whole-sentence *current* 15))
    (pirat-a (setf *current* *pirat-a*)
           (present-whole-sentence *current* 15))
    (pirat-b (setf *current* *pirat-b*)
           (present-whole-sentence *current* 15))
    (pirat-c (setf *current* *pirat-c*)
           (present-whole-sentence *current* 15))
    (pirat-d (setf *current* *pirat-d*)
           (present-whole-sentence *current* 15))
    (pirat-e (setf *current* *pirat-e*)
           (present-whole-sentence *current* 15))
    (pirat-f (setf *current* *pirat-f*)
           (present-whole-sentence *current* 15))
    (otherwise 'ERROR)))



(defun pc (c) (present-condition c))


(defun present-x-times (x sentence time)
  (dotimes (counter x)
    (format t "~%~%~%############################################################### ~d~%~%~%" counter)
    (clear-all)
    (present-whole-sentence sentence time)
    ;;(dm +DPb)
))



(defun trace-to-file (sentence times time filename)
  ;;#+:mcl(set-mac-default-directory #P"Macintosh HD:Users:bruessow:NPI:R:abcdef:")
  ;(with-open-file (*standard-output* filename :direction :output  :if-exists :overwrite)
  (with-open-file (*standard-output* filename :direction :output)
    (dotimes (counter times)
      (clear-all)
      (present-whole-sentence sentence time))))


(defun tof-all (times)
  (sgp)
  (trace-to-file *cond-a* times 15 "./traces/trace.a")
  (format t "Condition A: Traces of ~D runs written - ~A~%" times *cond-a*) 

  (trace-to-file *cond-b* times 15 "./traces/trace.b")
  (format t "Condition B: Traces of ~D runs written - ~A~%" times *cond-b*) 
  
  (trace-to-file *cond-c* times 15 "./traces/trace.c")
  (format t "Condition C: Traces of ~D runs written - ~A~%" times *cond-c*) 

  (trace-to-file *cond-d* times 15 "./traces/trace.d")
  (format t "Condition D: Traces of ~D runs written - ~A~%" times *cond-d*) 

  (trace-to-file *cond-e* times 15 "./traces/trace.e")
  (format t "Condition E: Traces of ~D runs written - ~A~%" times *cond-e*) 

  (trace-to-file *cond-f* times 15 "./traces/trace.f")
  (format t "Condition F: Traces of ~D runs written - ~A~%" times *cond-f*))



(defun tof-pirat (times)
  (sgp)
  (trace-to-file *pirat-a* times 15 "./traces/trace.pirat-a")
  (format t "Condition PIRAT-A: Traces of ~D runs written - ~A~%" times *pirat-a*)
  (trace-to-file *pirat-b* times 15 "./traces/trace.pirat-b")
  (format t "Condition PIRAT-B: Traces of ~D runs written - ~A~%" times *pirat-b*)
  (trace-to-file *pirat-c* times 15 "./traces/trace.pirat-c")
  (format t "Condition PIRAT-C: Traces of ~D runs written - ~A~%" times *pirat-c*)
  (trace-to-file *pirat-d* times 15 "./traces/trace.pirat-d")
  (format t "Condition PIRAT-D: Traces of ~D runs written - ~A~%" times *pirat-d*)
  (trace-to-file *pirat-e* times 15 "./traces/trace.pirat-e")
  (format t "Condition PIRAT-E: Traces of ~D runs written - ~A~%" times *pirat-e*)
  (trace-to-file *pirat-f* times 15 "./traces/trace.pirat-f")
  (format t "Condition PIRAT-F: Traces of ~D runs written - ~A~%" times *pirat-f*)) 


