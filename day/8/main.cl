(defun input-src (fd)
  (with-open-file (h fd)
	(loop for line = (read-line h nil)
		  while line
		  collect line)))

(defun parse-ins (pc src)
  (let ((i (nth pc src)))
	(setf sp (position #\Space i))
	(if sp
	  (cons (subseq i 0 sp) (parse-integer (subseq i (+ sp 1))))
	  nil)))

(defun parse-src (fd)
  (let ((src (input-src fd)))
	(loop for pc from 0 to (length src)
		  for ins = (parse-ins pc src)
		  while ins
		  collect ins)))

(defun mod-acc (ins acc)
  (if (string= (car ins) "acc")
	(+ acc (cdr ins))
	acc))

(defun mod-pc (ins pc)
  (if (string= (car ins) "jmp")
	(+ pc (cdr ins))
	(+ pc 1)))

(defun run-src (src)
  (setf steps nil)
  (let ((acc 0) (pc 0) (status nil))
	(loop for ins = (nth pc src) 
		  while (not status) do 
		  (if (find pc steps)
			(setf status 1))
		  (if ins
			(progn
			  (push pc steps)
			  (setf acc (mod-acc ins acc))
			  (setf pc (mod-pc ins pc)))
			(setf status 2)))
	(list acc status steps)))

(defun fix-ins (pc src)
  (if (string= (car (nth pc src)) "jmp")
	(setf (car (nth pc src)) "nop")
	(if (string= (car (nth pc src)) "nop")
	  (setf (car (nth pc src)) "jmp"))))

(defun find-br (src)
  (loop for pc from 0 to (length src)
		for name = (car (nth pc src))
		when (or (string= name "jmp") (string= name "nop")) 
		collect pc))

(defun fix-src (fd)
  (let ((src (parse-src fd)))
	(setf steps (intersection (nth 2 (run-src src)) (find-br src)))
	(loop for pc in steps do
		  (fix-ins pc src)
		  (if (= (nth 1 (run-src src)) 2)
			(return (+ pc 1))
			(fix-ins pc src)))))

(format t "solution 1 ~d~%" (nth 0 (run-src (parse-src "inf.txt"))))
(format t "flip instruction ~d to fix loop~%" (fix-src "inf.txt"))
(format t "solution 2 ~d~%" (nth 0 (run-src (parse-src "fix.txt"))))

