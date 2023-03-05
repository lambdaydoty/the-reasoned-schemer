#lang racket
(require minikanren)
; (require Racket-miniKanren/miniKanren/mk)
(define succeed (== #t #t))
(define fail (== #t #f))
(define else succeed)

; Your code here ...

; (run 1 (x) (== x 6))

(println "Chapter 1 - Playthings")

; p.17
(run* (q) fail) ; '()
(== 'pea 'pod)

; p.18
(run* (q) (== 'pea 'pod))
(run* (q) (== q 'pea))
(run* (q) (== 'pea q))

; p.19
(run* (q) (== 'pea q))
(run* (q) succeed) ; `fresh`

; p.20
(run* (q) (== 'pea 'pea))  ; -> (_.0)
(run* (q) (== q q))        ; -> (_.0)
(run* (q)
      (fresh (x)
             (== 'pea q))) ; -> (pea)
(run* (q)
      (fresh (x)
             (== 'pea x))) ; -> (_.0)

; p.21
(run* (q)
      (fresh (x)
             (== (cons x '()) q))) ; -> ((_.0))
(run* (q)
      (fresh (x)
             (== `(,x) q)))        ; -> ((_.0))
(run* (q)
      (fresh (x)
             (== x q)))            ; `fuse` --> (_.0)

; p.22
(run* (q)
      (== '(((pea)) pod) '(((pea)) pod)))
(run* (q)
      (== '(((pea)) pod) `(((pea)) ,q)))
(run* (q)
      (== `(((,q)) pod) '(((pea)) pod)))
(run* (q)
      (fresh (x)
             (== `(((,q)) pod) `(((,x)) pod))))
(run* (q)
      (fresh (x)
             (== `(((,q)) ,x) `(((,x)) pod))))
(run* (q)
      (fresh (x)
             (== `(,x ,x) q)))
(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,q ,y) `((,x ,y) ,x)))))

; p.23 `different`
(run* (q)
      (fresh (x)
             (== 'pea q)))
(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,x ,y) q))))
