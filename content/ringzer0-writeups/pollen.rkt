#lang racket

(provide (all-defined-out))

; TODO: this is basically the same as "projects-list" in cs465-projects
;       - unify both racket and CSS
(define (writeups . writeup-list)
    `(ul
        ((class "writeup-list"))
        ,@writeup-list))

(define (writeup #:title title #:url url . content)
    `(li
        ((class "writeup"))
        (a ((href ,url))
            (h2 ,title)
            (p ,@content))))
