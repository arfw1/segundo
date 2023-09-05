#lang racket
(require rackunit)
;ADAM ROY FREDERICK WILLIAM READING
;PRÁCTICA 1

;Ejercicio 1
;3; 3
;(+ 1 2); 3
;(+ 1 2 3 4) ;10
;(+) ; error MAL. DA 0
;(sqrt 25) ; 5
;(*(+ 2 3) 5); 25
;+ ; error MAL DA PRODCEDURE
;#\+ ; símbolo +
;"+";"+"
;"hola" ;"hola"
;(+ (- 4 (* 3 (/ 4 2) 4)) 3) ;-17
;(* (+ (+ 2 3) 4) (* (* 3 3) 2));162
;(* (+ 2 3 4 5) 3 (- 5 2 1));84
;(+ (- (+ (- (+ 2 3) 5) 1) 2) 3);2
;(- (sqrt (* 5 ( + 3 2))) (+ 1 1 1 1));1
;(> (* 3 (+ 2 (+ 3 1)) (+ 1 1)) (+ (* 2 2) 3));#t
;(= (* 3 2) (+ 1 (+ 2 2) 1));#t
;(not (> (+ 3 2) 5));#t
;(and (even? 2) (odd? (+ 3 2)))

;Ejercicio 2
;(cons 1 2); (1 . 2)	
;(car (cons 1 2)); 1	
;(cdr (cons 1 2)) ;(2)	MAL 2
;(cons (* 2 3) (/ 4 2));(6 . 2)	
;(cons (+ 2 1) (if (> 2 3) "2" "3"));(3 . "3")	
;(car (car (cons (cons 1 2) 3)));1
;(car (cons (cons 3 4) 2));(3 . 4)
;(cdr (cons (cons 3 4) 2));(2) MAL 2
;(cdr (cons 1 (cons 2 3)));(2 . 3)
;(cdr (car (cons (cons 1 2) 3)));(2) MAL 2

;Ejercicio 3
;(list 1 2 3 4)	;'(1 2 3 4)
;(rest (list 1 2 3 4)) ;(2 3 4)
;(first '(1 2 3 4));1
;(first (list #t 1 "Hola")); #t
;(first (rest (list 1 2 3 4)));2
;(rest (rest '(1 2 3 4)));'(3 4)	
;(first (rest (rest (list 1 2 3 4))));3	
;(list (* 2 2) (+ 1 2) (/ 4 2))	;'(4 3 2)
;(list (+ 2 3) (- 3 4)) ;'(5 -1)
;(cons 3 '(1 2 3)) ;(3 1 2 3)
;(rest (cons #t (cons "Hola" (list 1))));'("Hola" 1)
;(first (list (list 1 2) 1 2 3 4));'(1 2)
;(first (rest '((1 2) 1 2)));1
;(cons '(1 2 3) '(4 5 6));'((1 2 3) 4 5 6)
;(first (rest (list 1 2 3 4)));2
;(rest (rest (list 1 2 3 4)));'(3 4)
;(first (rest (rest (rest '(1 2 3 4)))));4
;(string-ref "hola" 3);"a" MAL #\a


;Ejercicio 4
;(first (rest (rest (list 1 2 3 4 5))))
;(rest (rest(rest(rest (list 1 2 3 4 5)))))
;(first (rest (rest(rest(rest (list 1 2 3 4 5))))))
;(first (rest (rest (list 1 (list 2 3) (list 4 5) 6))));'(4 5)
;(rest (rest '(1 (2 3) 4 5)));'(4 5)


;Ejercicio 4
;(equal? "hola" "hola"); #t	
;(string-ref "pepe" 1); #\e
;(substring "buenos dias" 1 4)	;"uen"
;;(= "hola" "hola");#t MAL DA ERROR
;(string-ref (substring "buenos dias" 2 5) 1);#\e MAL DA #\n	
;(define pi 3.14159)	
;pi	;3.14159
;"pi"	;nada
;(+ pi (+ pi pi));9.56
;(+ (* pi pi) (- 2 pi pi pi pi))	
;(+ (char->integer(integer->char 1200)) (char->integer #\A));1265
;(string-length (make-string 7 #\E));7
;(define a 3) (define b (+ a 1));
;(+ a b (* a b));19
;(= a b);#F
;(if (and (> a b) (< b (* a b))) b a);3
;(cond ((= a 4) 6)
;      ((= b 4) (+ 6 7 a))
;      (else 25));16
;(+ 2 (if (> b a) b a));6
;(* (cond ((> a b) a)
;         ((< a b) b)
;         (else -1))
;   (+ a 1));16
;((if (< a b) + -) a b);7

;Ejercico 6
;a
(define (distancia p1 p2)
  (sqrt (+(* (-(car p1)(car p2))(-(car p1)(car p2))) (* (-(cdr p1)(cdr p2))(-(cdr p1)(cdr p2))))))

(check-equal? (distancia (cons 0 0) (cons 0 10)) 10)
(check-equal? (distancia (cons 0 0) (cons 10 0)) 10)
(check-equal? (distancia (cons 0 0) (cons 10 10)) 14.142135623730951)

;b
(define (isosceles? p1 p2 p3)
  (and (not (= (distancia p1 p2) (distancia p1 p3) (distancia p2 p3)))
       (or (= (distancia p1 p2) (distancia p1 p3)) (= (distancia p1 p2) (distancia p2 p3)) (= (distancia p2 p3) (distancia p1 p3)))))
(check-true (isosceles? (cons 0 0) (cons 3 0) (cons 6 0)))
(check-true (isosceles? (cons 2 2) (cons 4 0) (cons 0 0)))
(check-false (isosceles? (cons 0 0) (cons 0 0) (cons 0 0)))
(check-false (isosceles? (cons 1 1) (cons 0 0) (cons 3 2)))









