#lang racket

(provide (all-defined-out))

(define (inline-code . content)
  `(code
    ((class "inline-code"))
    ,@content))

(define (code-block #:lang [lang #f] . content)
  (let ((block-class (if lang
                         (string-append "code-block " lang)
                         "code-block")))
    `(pre
      ((class ,block-class))
      (code
       ,@content))))

(define (projects . project-list)
    `(ul
        ((class "project-list"))
        ,@project-list))

(define (project #:title title #:url url . content)
    `(li
        ((class "project"))
        (a ((href ,url))
            (h2 ,title)
            (p ,@content))))
