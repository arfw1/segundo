#lang racket
(require "lpp.rkt")
(require 2htdp/image)
(define dic (crea-diccionario))
(define (pascal-memo fila col dic)
  (cond
    ((= col 0) 1)
    ((= fila col) 1)
    ((not(equal? (get (cons fila col) dic) #f))
         (get (cons fila col) dic))
    (else (put (cons fila col)
               (+ (pascal-memo (- fila 1) (- col 1) dic)
                  (pascal-memo (- fila 1) col dic))
               dic))))

(define (koch nivel trazo)
  (if (= nivel 0)
      (line trazo 0 "black") 
      (beside/align "bottom"
       (koch (- nivel 1) (/ trazo 3))
       (rotate 60 (koch (- nivel 1) (/ trazo 3)))
       (rotate -60 (koch (- nivel 1) (/ trazo 3)))
       (koch (- nivel 1) (/ trazo 3)))))

(define (copo-nieve nivel trazo)
  (above (koch nivel trazo)
         (beside (rotate 120
                         (koch nivel trazo))
                 (rotate -120
                         (koch nivel trazo)))))


(define (alfombra-sierpinski tam)
  (if (< tam 20)
      (circle (/ tam 2) "outline" "blue")
      (above
       (beside
        (alfombra-sierpinski (/ tam 3))
        (alfombra-sierpinski (/ tam 3))
        (alfombra-sierpinski (/ tam 3)))
       (beside
        (alfombra-sierpinski (/ tam 3))
        (circle (/ tam 6) "solid" "blue")
        (alfombra-sierpinski (/ tam 3)))
       (beside
        (alfombra-sierpinski (/ tam 3))
        (alfombra-sierpinski (/ tam 3))
        (alfombra-sierpinski (/ tam 3))))))

        