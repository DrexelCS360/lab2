#lang racket
(require rackunit)
(require rackunit/text-ui)
(require "mceval-tests.rkt")

(provide main)

(define lab2-tests
  (test-suite
   "Lab 2 Tests"
   prob2-tests
   prob3-tests
   prob4-tests))

(define (main . argv)
  (when (not (eq? (run-tests lab2-tests) 0))
    (exit 1)))
