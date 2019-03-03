; Brandon George and Qiang Wang

; A student is represented like this below
; ((transcript (course grade) (course grade))
;  (plan course course course))

(setf Adam '((transcript (COS102 A-) (COS109 A) (COS120 B) (COS121 B+)
  (COS143 A-) (COS243 B+) (COS265 B) (COS284 B-) (MAT151 A-) (MAT240 D) (MAT210 B))
 (plan COS492 COS493 COS280 COS331 COS340 COS350 SYS214 SYS411 MAT215) )
)

; a degree requirements list should look like below
; ((major-hours 40)
;   (required course1 course2 ... (or course other-course))
;   (electives course3 course4 ... ))

(setf degree-reqs '((major-hours 64)
 (required COS102 COS120 COS121 COS143 COS243 COS265 COS284 COS492 COS493 MAT151 MAT215
           (OR COS311 COS321)
           (OR COS320 COS382 COS435)
           (OR COS393 COS394 COS450)
           (OR MAT210 MAT352))
 (electives COS104 COS109 COS130 COS170
            COS232 COS270 COS280
            COS310 COS323 COS331 COS333 COS340 COS343 COS350
            COS351 COS355 COS360 COS370 COS380 COS381
            COS411 COS421 COS424 COS425 COS432 COS433 COS436
            MAT230 MAT240 MAT245 MAT251
            SYS214 SYS352 SYS401 SYS402 SYS403 SYS411))
)

; A catalog is like below
; ((course hours) (course hours) ...)

(setf Catalog '((COS102 3) (COS104 2) (COS109 3) (COS120 4) (COS121 4) (COS130 3) (COS143 3) (COS170 3)
 (COS232 3) (COS243 3) (COS265 3) (COS270 3) (COS280 3) (COS284 3)
 (COS310 1) (COS311 3) (COS321 3) (COS320 3) (COS323 3) (COS333 3) (COS340 3) (COS343 3)
 (COS350 3) (COS351 3) (COS355 3) (COS360 3) (COS370 3) (COS380 3) (COS381 3) (COS382 3) (COS393 3) (COS394 3)
 (COS411 3) (COS421 3) (COS424 3) (COS425 3) (COS432 3) (COS433 3) (COS435 3) (COS436 3)
 (COS450 3) (COS492 3) (COS493 1)
 (MAT151 4) (MAT215 3) (MAT210 4) (MAT230 4) (MAT240 4) (MAT245 4) (MAT251 4) (MAT352 4)
 (SYS214 3) (SYS352 3) (SYS401 3) (SYS402 3) (SYS403 3) (SYS411 3) )
)

; Will go through the transcript and make a list of just the course identifier
(defun transcript-class (courses)
  (if (null courses)
    ()
    (if (member (cadar courses) '(a+ a a- b+ b b- c c-))
        (cons (caar courses) (transcript-class (cdr courses)))
        (transcript-class (cdr courses))
    )
  )
)

;Check if there is C- in the score
(defun check_bad(trans)
  ;(format t "chech1~%")
  (if (null (car trans))
      ; (format t "Person is empty ~%")
      (cond ((equal '(A+) (cdar trans))
             (progn
               ; (format t "A+ ~%")
               t
               ;(check_bad (cdr trans))
             ))
            ((equal '(A) (cdar trans))
             (progn
               ; (format t "A ~%")
               t
               ;(check_bad (cdr trans))
             ))
            ((equal '(A-) (cdar trans))
             (progn
               ; (format t "A- ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(B+) (cdar trans))
             (progn
               ; (format t "B+ ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(B) (cdar trans))
             (progn
               ; (format t "B ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(B-) (cdar trans))
             (progn
               ; (format t "B- ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(C+) (cdar trans))
             (progn
               ; (format t "C+ ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(C) (cdar trans))
             (progn
               ; (format t "C ~%")
               t
               ;(check_bad (cdr trans))
               ))
            ((equal '(C-) (cdar trans))
             (progn
                 ; (format t "C- ~%")
                 t
                 ;(check_bad (cdr trans))
                 ))
              (t nil)
         )
     )
  )

  ; for checking the grade
  ; (member grade '(A A- B+ B B-))

  ; This will return a list of the classes that a student has taken or is planning
  ; to take
  (defun classes (person)
  (append (transcript-class (cdar person)) (cdadr person))
  )

; This will take a course like and accumulate the give course hours in the catalog
(defun checkcatalog (takenclasses catalog)
  (let ((courseFound (member (car takenclasses) catalog :key #'car)))
    (if (null courseFound)
      0
      (+ (cadar courseFound) (checkcatalog (cdr takenclasses) catalog))
    )
  )
)

(defun check-required-classes (takenclasses required-courses)

)

(defun compare-degree (courses degree-requirements)
  (progn
    ; (format t "courses: ~A~%" courses)
    ; (format t "degree-requirements: ~A~%" degree-requirements)
    (format t "requirements: ~A~%" (cdadr degree-requirements))

  )
)

(defun grad-check (person degree-requirements catalog)
  (let ((personCourses (classes person)))
    (progn
      ; (format t "Person: ~A~%~%" person)
      ; (format t "degree-requirements: ~A~%~%" degree-requirements)
      ; (format t "catalog: ~A~%~%" catalog)
      ; (format t "personCourses: ~A~%~%" personCourses)
      ; (compare-degree personCourses degree-requirements)
      (checkcatalog personCourses catalog)
    )
    ; (if (completed? enough course, hours)
  )
)
