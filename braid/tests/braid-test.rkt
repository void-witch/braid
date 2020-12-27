#lang at-exp racket/base

(module+ test
  (require rackunit
           (submod "../braid.rkt" braid)
           (only-in racket ~a))

  (check-equal? (p "foo " "bar" "baz") "<p>foo barbaz</p>"
                "paragraph with multiple body args")

  (test-begin
    (node "test node" "")
    (let ([location (car (hash-ref (nodes) "test node"))])
      (check-equal? (link "test node")
                    @~a{<a href="@|location|.html">test node</a>}
                    "link with default text")
      (check-equal? (link "test node" "some text")
                    @~a{<a href="@|location|.html">some text</a>}
                    "link with custom text"))))
