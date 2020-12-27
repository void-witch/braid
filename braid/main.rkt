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

(module+ braid
  (require openssl/md5)
  (require racket)

  (provide node
           p
           link
           linkreplace
           nodes)

  (define node-map (make-hash))

  (define (head)
    @~a{
      <head>
        <script>
          function linkReplace(el) {
            let linkreplaceDiv = el.parentElement;
            let linkreplaceAfter = linkreplaceDiv.getElementsByClassName("linkreplace-after")[0];
            el.style.display = "none";
            linkreplaceAfter.style.display = "initial";
          }
        </script>
        <style>
          .linkreplace-hide {
            display: none;
          }
        </style>
      </head>})

  (define (node name body)
    (let ([nodeval @~a{
                       @|(head)|
                       <body>
                         @|body|
                       </body>}])
      (hash-set! node-map
                 name
                 (list (md5 (open-input-string name)) nodeval))
      nodeval))

  (define (nodes) (hash-copy node-map))

  (define (p . body)
    @~a{<p>@|(string-join body "")|</p>})

  (define (link target-node [text target-node])
    (let ([location (car (hash-ref node-map target-node))])
      @~a{<a href="@|location|.html">@|text|</a>}))

  (define (linkreplace before after)
    @~a{
      <div class="linkreplace">
        <div class="linkreplace-before linkreplace-show" onclick="linkReplace(this)">
          @|before|
        </div>
        <div class="linkreplace-after linkreplace-hide">
          @|after|
        <div>
      </div>}))

#| (require 'braid)

(define mynode
  (node
   "my-node"
   (linkreplace
    (p "sim is typing...")
    (p "sim said a thing!" (linkreplace (p "whichcat is typing...") (p "whichcat said a thing!"))))))

(printf "~a" mynode) |#
