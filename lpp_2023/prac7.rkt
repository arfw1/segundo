#lang racket
(require "lpp.rkt")
(require rackunit)
(define arbol '(15 (4 (2) (3)) (8 (6)) (12 (9) (10) (11))))
(check-equal? (dato-arbol(second(hijos-arbol(third(hijos-arbol arbol))))) 10)

(define (suma-arbol arbol)
  (+ (dato-arbol arbol)
     (suma-bosque (hijos-arbol arbol))))
(define (suma-bosque arbol)
  (if (null? arbol)
      0
      (+ (suma-arbol (first arbol))
         (suma-bosque (rest arbol)))))

(define (suma-fos arbol)
  (foldr + (dato-arbol arbol)
         (map suma-fos (hijos-arbol arbol))))

(define arbolb '(40
                 (23 (5 () ()) (32 (29) ()))
                 (45 () (56))))

(check-equal? (dato-arbol(hijo-izq-arbolb(hijo-der-arbolb(hijo-izq-arbolb arbolb))))29)



(define (to-string-arbol arbol)
  (string-append (symbol->string(dato-arbol arbol))
                (to-string-bosque (hijos-arbol arbol))))
(define (to-string-bosque bosque)
  (if (null? bosque) ""
      (string-append (to-string-arbol (first bosque))
                     (to-string-bosque (rest bosque)))))

(define (to-string-fos arbol)
  (foldr string-append "" (cons(symbol->string(dato-arbol arbol))
         (map to-string-fos (hijos-arbol arbol)))))

(define (veces-arbol dato arbol)
  (+(if (equal? (dato-arbol arbol) dato) 1 0)
    (veces-bosque dato (hijos-arbol arbol))))
(define (veces-bosque dato bosque)
  (if (null? bosque) 0
      (+(veces-arbol dato (first bosque))
        (veces-bosque dato (rest bosque)))))

(define (veces-fos dato arbol)
  (foldr + (if(equal? (dato-arbol arbol) dato) 1 0) (map (lambda (x) (veces-fos dato x)) (hijos-arbol arbol))))


(define (hojas-cumplen pred arbol)
   (if (and (hoja-arbol? arbol) (pred (dato-arbol arbol))) (list(dato-arbol arbol))
              (hojas-bosque pred (hijos-arbol arbol))))
(define (hojas-bosque pred bosque)
  (if (null? bosque) '()
      (append (hojas-cumplen pred (first bosque))
              (hojas-bosque pred (rest bosque)))))


(define (hojas-cumplen-fos pred arbol)
  (foldr append (if (and (hoja-arbol? arbol) (pred (dato-arbol arbol)))  arbol  '()) (map (lambda (x) (hojas-cumplen-fos pred x)) (hijos-arbol arbol))))

(define (suma-raices-hijos arbol)
  (foldr + 0 (map dato-arbol (hijos-arbol arbol))))





