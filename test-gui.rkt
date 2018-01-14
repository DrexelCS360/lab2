#lang racket
(require rackunit)
(require rackunit/text-ui)
(require rackunit/gui)
(require "mceval-tests.rkt")

(define lab2-tests
  (test-suite
   "Lab 2 Tests"
   prob2-tests
   prob3-tests
   prob4-tests))

(test/gui lab2-tests)
