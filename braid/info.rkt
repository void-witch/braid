#lang info
(define collection "braid")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/braid.scrbl" ())))
(define pkg-desc "a twine-style engine for interactive fiction, implemented as a racket library")
(define version "0.0")
(define pkg-authors '(void-witch))
