#lang at-exp racket

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>
;;
;; Some users like to add a `private/` directory, place auxiliary files there,
;; and require them in `main.rkt`.
;;
;; See the current version of the racket style guide here:
;; http://docs.racket-lang.org/style/index.html

;; Code here

(require openssl/md5)
(require racket)
(require data/gvector)
(require "jsconverters.rkt")

(provide node
         p
         link
         linkreplace
         nodes
         head)
(provide (all-from-out "jsconverters.rkt"))

(define node%
  (class object%
    (init name content)

    (define self-name name)
    (define self-content content)
    (define self-hash (call-with-input-string name md5))

    (super-new)

    (define/public (get-name) self-name)
    (define/public (set-name new-name)
      (set! self-name new-name)
      (set! self-hash (call-with-input-string self-name md5)))

    (define/public (get-content) self-content)
    (define/public (set-content new-content)
      (set! self-content new-content))

    (define/public (get-hash) self-hash)

    (define/public (node->js)
      @~a{{name:@|self-name|, hash:@|self-hash|, content:@|self-content|}})))

(define node-map (make-hash))

(define (head [node-map node-map])
  @~a{
    <head>
      <script>
      function linkReplace(el) {
          let linkreplaceDiv = el.parentElement;
          let linkreplaceAfter = linkreplaceDiv.getElementsByClassName("linkreplace-after")[0];
          el.style.display = "none";
          linkreplaceAfter.style.display = "initial";
          }
      @|(format "~a" (gvector->list (hash->js node-map "nodes")))|
      </script>
      <style>
        .linkreplace-hide {
          display: none;
        }
      </style>
    </head>})

(define (node name . body)
  (letrec ([content (apply string-append body)] [nodeobj (new node% [name name] [content content])])
    (hash-set! node-map
               name
               nodeobj)
    nodeobj))

(define (nodes) (hash-copy node-map))

(define (p . body)
  @~a{<p>@|(string-join body "")|</p>})

(define (link target-name [text target-name])
  (let ([location (call-with-input-string target-name md5)])
    @~a{<a href="#@|location|">@|text|</a>}))

(define (linkreplace before after)
  @~a{
    <div class="linkreplace">
      <div class="linkreplace-before linkreplace-show" onclick="linkReplace(this)">
        @|before|
      </div>
      <div class="linkreplace-after linkreplace-hide">
        @|after|
      <div>
    </div>})

#| (require 'braid)

(define mynode
  (node
   "my-node"
   (linkreplace
    (p "sim is typing...")
    (p "sim said a thing!" (linkreplace (p "whichcat is typing...") (p "whichcat said a thing!"))))))

(printf "~a" mynode) |#
