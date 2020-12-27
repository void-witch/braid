# braid.rkt

a twine-style engine for interactive fiction, implemented as a racket library

## why a new engine?

i tried writing a twine game, and had to immediately drop into javascript [just to write an im chat](https://gist.github.com/c0ceef9e2d11b7233c8a5a355367224f). harlowe is extremely basic, and another story format had some subtle transphobic dogwhistles in the documentation (it also wasn't much better than harlowe). if i'm gonna have to drop into js constantly, i might as well make my own engine. loking at the story formats of twine, it seems incredibly complex and esoteric, and i figured it would probably be easier to just write something from the ground-up than constantly look for documentation for some obscure feature

### why racket specifically?

when writing the `renderConversation` function in the gist linked above, i realized it was really just a basic recursive function (one that would benefit greatly from pattern matching) and that i was really just building s-expressions (albeit s-expressions with a bad syntax). might as well wright it in a functional language that uses s-expressions, right?

racket was chosen specifically because it seemed like it was more powerful than common lisp. i have no idea how true that is, i don't really know lisp. it turned out to be the perfect language though; new "formats" (syntax) can be added extremely simply by just extending racket's `#lang` directive

since the engine is just a racket library, any extensions, additional functions, macros, etc. can be implemented in racket itself. no need to drop into javascript to do things at runtime (unless you want to), no need for a polyglot environment, no need to hook into a specific syntax to create new extensions or features, no need to create most of a ground-up engine to change syntax. everything Just Works™ (nothing bad ever happens when you say that, right?)

## installation

from github:

```bash
raco pkg install https://github.com/void-witch/braid
```

from a local repo:

```bash
git clone https://github.com/void-witch/braid
cd braid
raco pkg install braid
```

## usage

don't! this is pre-proof-of-concept software. the api is most likely going to *radically* change.
i guess you can use it if you're fine with that, but i wouldn't do it

TODO: write usage instructions here

## contributing

please read [the contributing guide](https://github.com/void-witch/braid/blob/HEAD/CODE_OF_CONDUCT.md) before doing any work

1. fork it (<https://github.com/void-witch/braid/fork>)
2. create your feature branch (`git checkout -b my-new-feature`)
3. commit your changes (`git commit -am 'Add some feature'`)
4. push to the branch (`git push origin my-new-feature`)
5. create a new pull request

## contributors

- [void-witch](https://github.com/void-witch) - creator and maintainer
