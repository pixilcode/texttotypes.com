#lang racket

(require pollen/core)
(require pollen/tag)
(require "../pollen.rkt")

(provide (all-defined-out))

(define (group name . content)
  (let ([class (string-append "group " (to-kebab-case name))]
        [title (list 'h1 name)])
    `(section
      ((class ,class))
      (details
          ((name "portfolio"))
          (summary () ,title)
          ,@content))))

(define (subgroup name . content)
  (let ([class (string-append "group " (to-kebab-case name))]
        [title (list 'h2 name)])
    `(section
      ((class ,class))
      ,title
      ,@content)))

(define items (default-tag-function 'ul #:class "items"))

(define (item
         #:title title
         #:completion-date completion-date
         #:tech tech
         #:url url
         . description)
  (let ([class (string-append "item " (to-kebab-case title))]
        [title (list 'h3 title)]
        [completion-date (when/splice completion-date `(p ((class "completion")) ,completion-date))]
        [tech `(ul ((class "tech"))
                   ,@(for/list ([t tech]) (list 'li t)))]
        [description `(p ((class "description")) ,@description)])
    (list 'li
          `((class ,class))
          (list 'a
                `((href ,url))
                title
                tech
                description
                completion-date))))
