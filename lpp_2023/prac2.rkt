
#lang racket
(require rackunit)
;EJERCICIO 1
(define (binario-a-decimal b3 b2 b1 b0)
  (+ (* b3 (expt 2 3)) (* b2 (expt 2 2)) (* b1 (expt 2 1)) (* b0 (expt 2 0))))
(check-equal? (binario-a-decimal 1 1 1 1) 15)
(check-equal? (binario-a-decimal 0 1 1 0) 6)
(check-equal? (binario-a-decimal 0 0 1 0) 2)

(define (binario-a-hexadecimal b3 b2 b1 b0)
  (convertir
   (binario-a-decimal b3 b2 b1 b0)))

(define (convertir n)
  (if ( < n 10)
      (integer->char (+ n 48))
      (integer->char (+ n 55))))

(check-equal? (binario-a-hexadecimal 1 1 1 1) #\F)
(check-equal? (binario-a-hexadecimal 0 1 1 0) #\6)
(check-equal? (binario-a-hexadecimal 0 0 1 0) #\2)

;EJERCICIO 2
(define (menor-de-tres n1 n2 n3)
  (if (< n1 n2)
      (if (< n1 n3)
          n1
          n3)
      n2))
(define (menor-de-tres-v2 n1 n2 n3)
  (menor (menor n1 n2) (menor n2 n3)))

(define (menor x y)
  (if (< x y)
      x
      y))
(check-equal? (menor-de-tres 2 8 1) 1)
(check-equal? (menor-de-tres-v2 3 0 3) 0)

;EJERCICIO 3
;orden aplicativo
;(g (f 3) 2)
;(g (cons 3 2) 2)
;(g '(3 . 2) 2)
;(cons '(3 .2) 2)
;'((3 . 2) . 2)
;;orden normal
;(g (cons (+ 2 1) 2) (+ 1 1))
;(cons (cons (+ 2 1) 2) (+ 1 1))
;'(((+ 2 1) . 2) . (+ 1 1))
;'((3 . 2) . 2)

;b
;orden aplicativo
;(func-2 0 (/ 10 0))
;error dividir entre 0
;
;;orden normal
;
;(func-2 0 (/ x 0))
;
;(if (= 0 0)
;    0
;    (/ x 0))
;(if (= 0 0)
;    0
;    (/ 10 0))



;EJERCICIO 4
(define (cadenas-mayores l1 l2)
  (append '()
   (if
    (>= (string-length (first l1)) (string-length (first l2)))
    (list(first l1)) (list(first l2)))
   (if
    (>= (string-length (second l1)) (string-length (second l2)))
    (list(second l1)) (list(second l2)))
   (if
    (>= (string-length (third l1)) (string-length (third l2)))
    (list(third l1)) (list(third l2)))
   ))
  (check-equal? (cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios")) '("hola" "que" "adios"))
(check-equal? (cadenas-mayores '("esto" "es" "lpp") '("hoy" "hay" "clase")) '("esto" "hay" "clase"))

;EJERCICIO 5
(define tres-de-picas '3♠)
(define as-de-corazones 'A♥)
(define jota-de-diamantes 'J♦)

(define (obten-palo palo)
  (if (equal? palo #\♠)
      'Picas
      (if (equal? palo #\♥)
          'Corazones
          (if (equal? palo #\♦) 
              'Diamantes
              (if (equal? palo #\♣)
                  'Tréboles
                  'Nada)))))
          
  (define (obten-valor carta)
    (cond
      ((equal? carta #\A) 1)
      ((equal? carta #\J) 10)
      ((equal? carta #\Q) 11)
      ((equal? carta #\K) 12)
      (else (- (char->integer carta) 48))))

(define (carta c)
  (cons (obten-valor (string-ref (symbol->string c) 0 ))
        (obten-palo (string-ref (symbol->string c) 1 ))))

(check-equal? (carta tres-de-picas) '(3 . Picas))
(check-equal? (carta as-de-corazones) '(1 . Corazones))
(check-equal? (carta 'K♣) '(12 . Tréboles))


;EJERCICIO 6
(define (jugada-mano carta1 carta2 carta3)
  (if (and (equal? (car (carta carta1)) (car (carta carta2)))
           (equal? (car (carta carta1)) (car (carta carta3))))
      (string-append "trío de " (number->string(car (carta carta1))))     
      (if (or (equal? (car (carta carta1)) (car (carta carta2)))
              (equal? (car (carta carta1)) (car (carta carta3))))
          (string-append "pareja de " (number->string(car (carta carta1))))
          (if (or (equal? (car (carta carta2)) (car (carta carta3)))
                  (equal? (car (carta carta2)) (car (carta carta1))))
              (string-append "pareja de " (number->string(car (carta carta1))))
              "nada"))))
(check-equal? (jugada-mano '3♥ '3♣ '3♥) "trío de 3")
(check-equal? (jugada-mano 'K♦ '7♠ 'K♥) "pareja de 12")
(check-equal? (jugada-mano '5♣ '4♣ '6♣)  "nada")