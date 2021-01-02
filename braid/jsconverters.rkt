#lang at-exp racket

(require data/gvector)

(provide hash->js)
(define (hash->js nativehash name) ; TODO: escape the key
  (let ([result (make-gvector)])
    (hash-map nativehash
              (lambda (k v) (gvector-add! result @~a{@|name|["@|k|"]="@|v|";})))
    result))
