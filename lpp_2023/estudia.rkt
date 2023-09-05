#lang racket
(require "lpp.rkt")

(define (concat lista)
  (concat-iter lista ""))

(define (concat-iter lista res)
  (if (null? lista)
      res
      (concat-iter  (rest lista) (string-append res (first lista)))))



