#lang racket
(require rackunit)
(require "lpp.rkt")
;Ejercicio 1
;a
(define (aplica-veces f1 f2 n x)
  (if (= n 1) (f1(f2 x ))
      (aplica-veces f1 f2 (- n 1) (f1(f2 x)))))
;b
(define (inserta-segundo-cond dato pred lista)
  (if (pred (first lista))
      (cons (first lista)
            (cons dato (rest lista)))
      (cons dato lista)))

(define (mueve-al-principio-cond pred lista)
  (cond
    ((null? (rest lista)) lista)
    ((pred (first lista)) lista)
    (else (inserta-segundo-cond (first lista)
                                pred
                                (mueve-al-principio-cond pred (rest lista))))))
;c

(define(comprueba pred lista1 lista2)
  (cond
    ((or (null? lista1) (null? lista2)) '())
    ((pred (first lista1) (first lista2)) (cons(cons(first lista1) (first lista2)) (comprueba pred (rest lista1) (rest lista2))))
    (else (comprueba pred (rest lista1) (rest lista2)))))


;Ejercicio 2

(define (inserta-ordenada-generica menor-igual? n lista)
  (cond
    ((null? lista) (list n))
    ((menor-igual? n (first lista)) (cons n lista))
    (else (cons (first lista) (inserta-ordenada-generica menor-igual? n (rest lista))))))


(define (ordena-generica  lista menor-igual?)
  (if (null? lista) '()
      (inserta-ordenada-generica menor-igual? (first lista) (ordena-generica (rest lista) menor-igual?))))

(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya")
                               (lambda (x y) (<= (string-length x) (string-length  y))))
                               '("me" "Hola" "llamo" "Iñigo" "Montoya"))


(check-equal? (ordena-generica '("Hola" "me" "llamo" "Iñigo" "Montoya")
                               string<=? )
              '("Hola" "Iñigo" "Montoya" "llamo" "me"))

(check-equal? (ordena-generica '((2 . 2) (1 . 1) (3 . 0) (5 . 1))

                               (lambda (x y) (< (+(car x) (cdr x)) (+(car y) (cdr y))) ))


              '((1 . 1) (3 . 0) (2 . 2) (5 . 1)))


;Ejercicio 3
;'("1" "#t" "hola" "desconocido")
;'(barcelona madrid)
;"Holaquetal*"
;'(1 2 3 4 5 6 7 8)
;"unaparejaholaadiosab"
;(12 . 6)
;15
;3

;b
(define lista '((2 . 7) (3 . 5) (10 . 4) (5 . 5)))

(filter even? (map (lambda (x) (+ (car x) (cdr x))) lista))

(filter (lambda (x) (> (car x) (cdr x))) (map (lambda(x) (cons (cdr x) (car x))) lista))


(foldr (lambda(x resultado) (cons (car x) resultado)) '()
(filter (lambda (x) (even? (+ (car x) (cdr x)))) lista))

;c
(define (f1 x) (lambda (y z) (string-append y z x)))
(define g1 (f1 "a"))
(check-equal? (g1 "clase" "lpp") "claselppa")
(define (f2 x) (lambda (y z) (list y x z)))
(define g2 (f2 "lpp"))
(check-equal? (g2 "hola" "clase") (list "hola" "lpp" "clase"))

(define (f3 g3) (lambda(z x) (g3 z x)))
(check-equal? ((f3 cons) 3 4)  '(3 . 4))

;Ejercicio 4
(define (contar-datos-iguales-fos lista-parejas)
  (foldr + 0 (map (lambda(x) (if (equal? (car x)(cdr x)) 1 0)) lista-parejas)))

(define (expande-lista-fos lista-parejas)
  (foldr append '() (map expande-pareja lista-parejas)))

(define (expande-pareja x)
  (if (= (cdr x) 1)
      (list(car x))
      (cons (car x)(expande-pareja (cons (car x ) (- (cdr x) 1))))))

(define (comprueba-simbolos-fos lista-simbolos lista-num)
  (foldr append '() (map(lambda (x y) (if (=(string-length(symbol->string x)) y) (list(cons x y)) '())) lista-simbolos lista-num)))

;ejercicio 5
(define (suma-n-izq n lista-parejas)
  (map (lambda (x) (cons (+ (car x) n) (cdr x))) lista-parejas))

(define (aplica-2 func lista-parejas)
  (map (lambda (x) (func (car x) (cdr x))) lista-parejas))

;ejercicio 6















