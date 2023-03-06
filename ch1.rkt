#lang racket
; (require minikanren)
; (require Racket-miniKanren/miniKanren/mk)
(require "trs2-impl.rkt") ; For 2nd Ed (e.g. conj2, ...etc)

; (define succeed (== #t #t))
; (define fail (== #t #f))
; (define else succeed)

;; The First Law -


;; The Second Law - If x is fresh, then (== v x) succeeds and
;;                  associates v with x, unless x occurs in v

(println "Chapter 1 - Playthings")

(println "p.17")
(run* (q) fail)           ; -> ()

(println "p.18")
(run* (q) (== 'pea 'pod)) ; -> ()
(run* (q) (== q 'pea))    ; -> (pea)
(run* (q) (== 'pea q))    ; -> (pea)

(println "p.19")
(run* (q) succeed)        ; -> (_.0) `fresh`

(println "p.20")
(run* (q) (== 'pea 'pea)) ; -> (_.0)
(run* (q) (== q q))       ; -> (_.0)
(run* (q)
      (fresh (x)
             (== 'pea q)))  ; -> (pea)
(run* (q)
      (fresh (x)
             (== 'pea x)))  ; -> (_.0)

(println "p.21")
(run* (q)
      (fresh (x)
             (== (cons x '()) q))) ; -> ((_.0))
(run* (q)
      (fresh (x)
             (== `(,x) q)))        ; -> ((_.0))
(run* (q)
      (fresh (x)
             (== x q)))            ; --> (_.0) `fuse`

(println "p.22")
(run* (q)
      (== '(((pea)) pod) '(((pea)) pod)))    ; -> (_.0)
(run* (q)
      (== '(((pea)) pod) `(((pea)) ,q)))     ; -> (pod)
(run* (q)
      (== `(((,q)) pod) '(((pea)) pod)))     ; -> (pea)
(run* (q)
      (fresh (x)
             (== `(((,q)) pod) `(((,x)) pod))))    ; -> (_.0)
(run* (q)
      (fresh (x)
             (== `(((,q)) ,x) `(((,x)) pod))))     ; -> (pod)
(run* (q)
      (fresh (x)
             (== `(,x ,x) q)))                     ; -> ((_.0 _.0))
(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,q ,y) `((,x ,y) ,x))))) ; -> ((_.0 _.0))

(println "p.23")
(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,x ,y) q))))  ; -> ((_.0 _.1))
(run* (s)
      (fresh (t)
             (fresh (u)
                    (== `(,t ,u) s))))  ; -> ((_.0 _.1))

(run* (q)
      (fresh (x)
             (fresh (y)
                    (== `(,x ,y ,x) q)))) ; -> ((_.0 _.1 _.0))

(run* (q)
      (fresh (x)
             (== `(,x) x))) ; -> ()

(println "p.24")
(run* (q)
      (conj2 succeed succeed))

(println "p.25")
(println "p.26")
(println "p.27")
