#lang racket

(require pollen/tag)

(provide (all-defined-out))

; Simple tag functions
(define introduction (default-tag-function 'section #:class "introduction"))
(define p-section (default-tag-function 'span #:class "p-section"))
