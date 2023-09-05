#lang racket
(require rackunit)
(require "lpp.rkt")
(define lista-a '((a b)
                  d
                  (c (e) (f g) h)))
(define lista-b1 '((2 (3)) (4 2) ((2) 3)))
(define lista-b2 '((b) (c (a)) d (a)))

(define (cuadrado-estruct lista)
  (cond ((null? lista) '())
        ((hoja? lista) (* lista lista ))
        (else (cons
             (cuadrado-estruct (first lista))
             (cuadrado-estruct (rest lista))))))
(define cuadrado '((4 (9)) (16 4) ((4) 9)))

(define (concatena lista)
  (cond
    ((null? lista) "")
    ((hoja? lista) (symbol->string lista))
    (else (string-append (concatena (first lista))
                         (concatena (rest lista))))))

(define (todos-positivos? lista)
  (cond
    ((null? lista) #t)
    ((hoja? lista) (> lista 0))
    (else (and (todos-positivos? (first lista))
               (todos-positivos? (rest lista))))))

(define (todos-positivos-fos? lista)
  (if (hoja? lista)
      (> lista 0)
      (for-all? (lambda (x) (equal? x #t)) (map todos-positivos-fos? lista))))

(define(cumplen-predicado pred lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (pred lista) (list lista) '()))
    (else (append (cumplen-predicado pred (first lista))
                  (cumplen-predicado pred (rest lista))))))


(define (cumplen-predicado-fos pred lista)
  (if (hoja? lista) (if (pred lista) (list lista) '())
      (foldr append '() (map (lambda (x) (cumplen-predicado-fos pred x)) lista))))



(define (busca-mayores n lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (< n lista) (list lista) '()))
    (else (append (busca-mayores n (first lista))
                  (busca-mayores n (rest lista))))))


(define (busca-mayores-fos n lista)
  (if (hoja? lista)
       (if (< n lista) (list lista) '())
       (foldr append '() (map (lambda (x) (busca-mayores-fos n x)) lista))))

(define (empieza-por char lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (equal? (string-ref (symbol->string lista) 0) char) (list lista) '()))
    (else
     (append (empieza-por char (first lista))
             (empieza-por char (rest lista))))))
                          
(define (empieza-por-fos char lista)
  (if (hoja? lista)
      (if (equal? (string-ref (symbol->string lista) 0) char) (list lista) '())
      (foldr append '() (map (lambda (x) (empieza-por-fos char x)) lista))))
                  

(define (sustituye-elem old new lista)
  (cond
    ((null? lista) '())
    ((hoja? lista) (if (equal? old lista) new lista))
    (else(cons (sustituye-elem old new (first lista))
               (sustituye-elem old new (rest lista))))))

(define (intersecta l1 l2)
  (cond
    ((or (null? l1) (null? l2)) '())
    ((and (hoja? l1) (hoja? l2)) (cons l1 l2))
    ((and (list? l1) (list? l2))
    (enlaza (intersecta (first l1) (first l2))
                  (intersecta (rest l1) (rest l2))))
    (else '())))

(define (enlaza l1 l2)
  (if (null? l1) l2
      (cons l1 l2)))

(define (mezclar l1 l2 n)
  (cond
    ((or (null? l1) (null l2)) '())
    ((hoja? l1) (if (> n 0) l1 l2))
    ((cons (mezclar (first l1) (first l2) (- n 1))
           (mezclar (rest l1) (rest l2) n)))))

(define (nivel-elemento lista)
  (cond
    ((null? lista) (cons 0 0))
    ((hoja? lista) 





      