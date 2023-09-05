#lang racket
(require "lpp.rkt")
;ejercicio 1
;a
(define (contiene-prefijo prefijo lista)
  (if (null? lista)
      '()
      (cons (es-prefijo? prefijo (first lista))
            (contiene-prefijo prefijo (rest lista)))))

(define (es-prefijo? pal1 pal2)
  (equal? (substring pal2 0 (string-length pal1)) pal1))

;b
(define (cadenas-mayores l1 l2)
  (cond
    ((null? l1) l2)
    ((null? l2) l1)
    ((> (string-length (first l2)) (string-length (first l1)))
     (cons (first l2) (cadenas-mayores (rest l1) (rest l2))))
    (else
     (cons (first l1) (cadenas-mayores (rest l1) (rest l2))))))

;ejercicio 2
;a
(define (inserta-pos dato pos lista)
  (if (= pos 0)
      (cons dato lista)
      (cons (first lista) (inserta-pos dato (- pos 1) (rest lista)))))

;b
(define (inserta-ordenada n lista)
  (if (null? lista) (list n)
      (if (null? (rest lista))
          (list(first lista))
          (if( < n (first lista))
             (cons n lista)
             (if (and (> n (first lista)) (< n (second lista)))
                 (cons (first lista) (cons n (rest lista)))
                 (cons (first lista) (inserta-ordenada n (rest lista))))))))
;c
(define (ordena lista)
  (if (null? lista)
      '()
      (inserta-ordenada (first lista) (ordena (rest lista)))))
;Ejercicio 3
;a
(define (quitar-elem lista elem)
  (if (equal? (first lista) elem)
              (rest lista)
              (cons (first lista) (quitar-elem (rest lista) elem))))
 (define (mueve-al-principio lista elem)
   (cons elem (quitar-elem lista elem)))

;b
(define (comprueba-simbolos simbolos nums)
  (if (or (null? simbolos) (null? nums))
      '()
      (if (= (string-length (symbol->string(first simbolos))) (first nums))
          (cons (cons (first simbolos) (first nums))
                (comprueba-simbolos (rest simbolos) (rest nums)))
          (comprueba-simbolos (rest simbolos) (rest nums)))))
;Ejercicio 4

(define (expande-pareja pareja)
  (if (=(cdr pareja) 0)
      '()
      (cons (car pareja) (expande-pareja (cons (car pareja) (- (cdr pareja) 1))))))


(define (expande-lista lista)
  (if (null? lista) '()
      (append (expande-pareja (first lista)) (expande-lista (rest lista)))))


;Ejercicio 5
;9
;10
;30
;error
;#t
;"***HolaAdios***"

(define suma-3
         (lambda(x) (+ x 3)))

(define factorial
  (lambda (x)
    (if (= x 0)
        1
        (* x (factorial (- x 1))))))
;Error
;Error
;Error
;"***HolaAdios"
;Error
;"HolaAdios"
;'error

(cartas 10)

  