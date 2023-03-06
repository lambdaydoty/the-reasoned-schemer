#lang racket
(require minikanren)
; (require Racket-miniKanren/miniKanren/mk)

(define my-append
  (λ (l s)
    (cond
      [(null? l) s]
      [else
        (cons (car l)
              (my-append (cdr l) s))])))

(my-append '(1 2 3) '(4 5 6 7))

(define my-appendo
  (λ (l s out)
    (conde
      [(== '() l) (== s out)]
      [(fresh (x y res)
              (== (cons x y) l)
              (== (cons x res) out)
              (my-appendo y s res))])))

(run* (q) (my-appendo '(1 2 3) '(4 5 6 7) q))
(run* (q) (my-appendo '(1 2 3) q '(1 2 3 4 5)))
(run* (q) (my-appendo '(1 2 3) q '()))
(run* (q) (my-appendo '(1 2 3) q '(1 2 3)))
(run* (q) (my-appendo q '(d e) '(a b c d e)))
(run* (q) (my-appendo q '(1 d e) '(a b c d e)))
; (run* (x y) (my-appendo x y '(a b c d e)))
; (run* (x y z) (my-appendo x y z))
