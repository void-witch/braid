#lang at-exp racket/base

(module+ test
  (require rackunit
           braid
           (only-in racket ~a send))

  (check-equal? (p "foo " "bar" "baz") "<p>foo barbaz</p>"
                "paragraph with multiple body args")

  (test-begin
    (node "test node" "")
    (let ([location (send (hash-ref (nodes) "test node") get-hash)])
      (check-equal? (link "test node")
                    @~a{<a href="#@|location|">test node</a>}
                    "link with default text")
      (check-equal? (link "test node" "some text")
                    @~a{<a href="#@|location|">some text</a>}
                    "link with custom text"))))
