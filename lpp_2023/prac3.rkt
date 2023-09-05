#lang racket
(require rackunit)
(require "lpp.rkt")

;(caja-puntero '(1 . 2))
;(caja-puntero (cons 1 (cons 2 (cons 3 4))))
;(caja-puntero (list 1 2 3))
;(caja-puntero '((1 2) . 2))
;(caja-puntero '(1 (2 3) 4))

;Ejercicio 1

(define (menor x y)
  (if (< x y)
      x
      y))

(define (minimo lista)
  (if (null? (rest lista))
      (first lista)
      (menor (first lista) (minimo (rest lista)))))
;a2
;'(8 6 4 3)
;devuelve 3
;(menor 1 3)

(define (concatena lista)
  (if (null? (rest lista))
      (string (first lista))
      (string-append (string(first lista)) (concatena (rest lista)))))

(define (contiene? lista elem)
  (and (not (and (null? lista)))
  (or (equal? (first lista) elem) (contiene? (rest lista) elem))))

(define (str-contiene? cadena char)
  (contiene? (string->list cadena) char))

;EJERCICIO 2
(define (todos-iguales? lista)
  (or(null? lista) (null? (rest lista))
     (and (equal? (first lista) (first (rest lista))) (todos-iguales? (rest lista)))))
;b
(define (todos-distintos? lista)
  (or (null? (rest lista))
  (and (not (contiene? (rest lista) (first lista)))
      (todos-distintos? (rest lista)))))
;c



;EJERCICIO 3

(define p1 (list (cons "a" "b") "c" (list"d" "e")))

(cdr(first p1))
(first(last p1))

(define p2 (list (list (cons "a" (cons "b" "c")) (list "d" "e") "f") "g"))

(cdr(cdr(first (first p2))))
(last(second(first p2)))


;EJERCICIO 4

(define (contar-datos-iguales lista)
  (if (null? lista)
      0
      (if (equal? (car (first lista)) (cdr (first lista)))
          (+ 1 (contar-datos-iguales (rest lista)))
          (contar-datos-iguales (rest lista)))))

;EJERCICIO 4
(define (valor-carta carta)
    (cond
      ((equal? (string-ref (symbol->string carta) 0) #\A) 1)
      ((equal? (string-ref (symbol->string carta) 0) #\J) 10)
      ((equal? (string-ref (symbol->string carta) 0) #\Q) 11)
      ((equal? (string-ref (symbol->string carta) 0) #\K) 12)
      (else (- (char->integer(string-ref (symbol->string carta) 0)) (char->integer #\0)))))


(define (palo-carta carta)
  (cond
    ((equal? (string-ref(symbol->string carta) 1) #\♠) 'Picas)
    ((equal? (string-ref(symbol->string carta) 1) #\♣) 'Tréboles)
    ((equal? (string-ref(symbol->string carta) 1) #\♥) 'Corazones)
    ((equal? (string-ref(symbol->string carta) 1) #\♦) 'Diamantes)
    (else "no es un palo")))
     
(define(veces-palo lista palo)
  (if (null? lista) 0
     (+ (if (equal? (palo-carta (first lista)) palo) 1 0)
        (veces-palo (rest lista) palo))))

(define (color? lista)
  (equal? (length lista) (veces-palo lista (palo-carta (first lista)))))
  
(define (escalera? lista)
  (or (null? (rest lista))
      (and (equal? (valor-carta (first lista))
                   (-(valor-carta (first (rest lista))) 1))
           (escalera? (rest lista)))))
(define (escalera-color? lista)
  (and (escalera? lista)
       (color? lista)))


;EJERCICIO 6
(define (suma-izq pareja n)
  (cons (+ n (car pareja)) (cdr pareja)))
(define (suma-der pareja n)
  (cons (car pareja) (+ n (cdr pareja))))

(define (suma-impares-pares lista)
  (if (null? lista)
      '(0 . 0)
      (if (odd? (first lista))
          (suma-izq (suma-impares-pares (rest lista)) (first lista))
          (suma-der (suma-impares-pares (rest lista)) (first lista)))))

(define (cadena-mayor lista)
  (if (null? lista) (cons "" 0 )
      (if (>(string-length (first lista))
            (cdr (cadena-mayor (rest lista))))
          (cons (first lista) (string-length (first lista)))
          (cadena-mayor (rest lista)))))