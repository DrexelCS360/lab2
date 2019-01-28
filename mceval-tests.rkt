#lang racket
(require rackunit)
(require "mceval.rkt")

(provide prob2-tests
         prob3-tests
         prob4-tests)

(define (test-mceval exp)
  (with-handlers ([exn:fail? (lambda (exn) exn)])
    (mceval exp (setup-environment))))

(define (test-mceval-exception exp)
  (mceval exp (setup-environment)))

(define prob2-tests
  (test-suite
   "Problem 2: Adding primitives"
   (test-case "Implement +"     (check-equal? (test-mceval '(+ 4 5)) 9))
   (test-case "Implement -"     (check-equal? (test-mceval '(- 4 5)) -1))
   (test-case "Implement *"     (check-equal? (test-mceval '(* 4 5)) 20))
   (test-case "Implement /"     (check-equal? (test-mceval '(/ 8 4)) 2))
   (test-case "Implement <"     (check-equal? (test-mceval '(< 4 4)) #f))
   (test-case "Implement <="    (check-equal? (test-mceval '(<= 4 4)) #t))
   (test-case "Implement ="     (check-equal? (test-mceval '(= 4 4)) #t))
   (test-case "Implement >="    (check-equal? (test-mceval '(>= 4 4)) #t))
   (test-case "Implement >"     (check-equal? (test-mceval '(> 4 4)) #f))
   (test-case "Implement error" (check-exn (regexp "^Metacircular Interpreter Aborted$")
                                           (lambda () (test-mceval-exception '(error)))))))

(define prob3-tests
  (test-suite
   "Problem 3: Implementing and and or"
   (test-suite
    "and"
    (test-case "(and (= 2 2) (> 2 1))"
               (check-equal? (test-mceval '(and (= 2 2) (> 2 1))) #t))
    (test-case "(= 2 2) (< 2 1))"
               (check-equal? (test-mceval '(and (= 2 2) (< 2 1))) #f))
    (test-case "(and 1 2 'c '(f g)))"
               (check-equal? (test-mceval '(and 1 2 'c '(f g))) '(f g)))
    (test-case "(and false (error))"
               (check-equal? (test-mceval '(and false (error))) #f))
    (test-case "(and)"
               (check-equal? (test-mceval '(and)) #t)))
   
   (test-suite
    "or"
    (test-case "(or (= 2 2) (> 2 1))"
               (check-equal? (test-mceval '(or (= 2 2) (> 2 1))) #t))
    (test-case "(or (= 2 2) (< 2 1))"
               (check-equal? (test-mceval '(or (= 2 2) (< 2 1))) #t))
    (test-case "(or false false false)"
               (check-equal? (test-mceval '(or false false false)) #f))
    (test-case "(or true (error))"
               (check-equal? (test-mceval '(or true (error))) #t))
    (test-case "(or)"
               (check-equal? (test-mceval '(or)) #f)))))

(define prob4-tests
  (test-suite
   "Problem 4: Implementing let"
   (test-case "(let ((x 1) (y 2)) (+ x y))"
              (check-equal? (test-mceval '(let ((x 1) (y 2)) (+ x y))) 3))
   (test-case "(let ((x 1) (y 2)) (set! x 2) (+ x y))"
              (check-equal? (test-mceval '(let ((x 1) (y 2)) (set! x 2) (+ x y))) 4))))
