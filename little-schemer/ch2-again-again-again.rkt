#lang racket

(define atom? 
  (lambda (x) 
    (and (not (pair? x)) (not (null? x)))))
;; (define car? (lambda (x) ()))


;; again when should we quote??
(define lat (lambda (x) x))
;; it seems quotes are only excepted on the 2nd
;; argument of lambda.. 
(lat 'd) ;=> #("halt")
;; ^^ if lambda has atom for 1st arg


;; attempt to get cond working w/ lambda define
;; (define lat (lambda (x) 
;;        (cond #t 'd 'w)))


;; used for first recursive example
(define lat? 
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
;; ^^ need to understand what args conds takes
;; (cond (if then) (if then) (else then) )
;; ^^  how does  ((null? l) #t) eval??
;; ^^ this has to do with how cond is defined
;; cond evaluates the next (if then) if 
;; (null? l) => #f, else the lat? func evals #t
(lat? '(() f d s)) ;=> #f
;; why!!!?


;; (cond ...) asks questions
;; (lambda ...) creates a function
;; (define ...) gives it a name

;; ex: of cond, just ("if" "then"), car of each
;; argument must return #t OR #f
(cond (#f 'a)(#f 'b)(#t 'c)) ; => c 
(cond (#f 'a)(#f 'b)(#f 'c)(#f 'd)(else 'f)) ;=> f


;; used for a group of Qs 
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (member? a (cdr lat)))))))
;; ^^ allways test null 1st.. 
;; aka, end of the list, if cdr-ing the list every recur
;; like iterating through the s-exp of the list..

;; returns 1st arg if #t or any s-exp
;; if 1st arg is #f, return 2nd arg
(or #t 'a) ;=> #t
(or 'a 'b) ;=> a   
(or 'b 'c) ;=> b   
(or '(d s) 'c) ;=> (d s)
(or #f 'a) ;=> a
;; ^^ returns 2nd because 1st arg is #f

;; trying to write the opposite of the member? func
(define nonmember?
  (lambda (a lat)
    (cond
      ((null? lat) #t)
      ((not (eq? (car lat) a)) 
       (nonmember? a (cdr lat))) 
      (else #f))))
(nonmember? 'f '(a b c)) ;=> #t   
(nonmember? 'a '(a b c)) ;=> #f



;; trying a 'contains' func
(define contains? 
  (lambda (a lat)
    (cond 
      ;; check if the end..
      ((null? lat) #f)
      ((null? a) #t)

      ;; check if we should recur a again??
      ((eq? (car a) (car lat)) 
              (contains? (cdr a) (cdr lat)))
        
      ;; recur lat again
      (else (cons car lat (contains? a (cdr lat))))
    )))
;; ^^ how do we "iterate" through all of the 
;; s-exp of a to determine if a is in lat??
;; ^^ how do I pass data through the recurrences??

((lambda (x) (car x)) '(d f g)) ;=> d
;; ^^ what's after a lambda will be applied to it!!

;; finished contains func
(define contains2? 
  (lambda (a lat)
    (cond 
      ;; check if the end..
      ((and (null? lat) (null? a)) #t)
      ;; or ((eq? lat a) #t)
      ((null? a) #t)
      ((null? lat) #f)
  
      ;; check if we should recur a again??
      ((eq? (car a) (car lat)) 
            (contains2? (cdr a) (cdr lat)))
        
      ;; recur lat again
      (else (contains2? a (cdr lat)))
    )))
(contains2? '(a c) '(a b c)) ;=> #t   
(contains2? '(c a) '(a b c)) ;=> #f   
(contains2? '(b c) '(a b c)) ;=> #t
(contains2? '(a c c d) '(d f a c j k c l d)) ;=> #t
;; this contains func checks ordered contains..
;; so as long as the s-exp a appears in that order in lat then it is #t
(contains2? '(a b c) '(a b a b c))

;; contains idea..
(contains3? 
  (lambda (a lat aog latog) ;; og means "original"
    )) ;; the idea is to have the og vars not change

