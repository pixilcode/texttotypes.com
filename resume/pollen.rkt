#lang racket

(require pollen/tag)

(provide (all-defined-out))

; Helper Functions

(define (to-kebab-case str)
  (string-downcase
   (string-replace str " " "-")))

(define (iconed-tag tag icon class attrs elems)
  (let ([class (string-append "iconed " class)])
    (append (list tag (cons `(class ,class) attrs)) (cons icon elems))))

(define (list-with-header header-tag header list-tag attrs content)
  (let ([div-class (to-kebab-case header)])
    (list 'div
          (cons (list 'class div-class) attrs)
          (list header-tag header)
          (cons list-tag content))))

; Icons
(define phone-icon '(img ((class "icon") (src "images/phone.svg") (alt "A phone icon"))))
(define email-icon '(img ((class "icon") (src "images/email.svg") (alt "An email icon"))))
(define github-icon '(img ((class "icon") (src "images/github.svg") (alt "A GitHub icon"))))

; Simple Tags
(define side-bar (default-tag-function 'div #:class "side-bar"))
(define degree (default-tag-function 'p #:class "degree"))
(define edu-details (default-tag-function 'ul #:class "edu-details"))
(define experience (default-tag-function 'div #:class "experience"))
(define main-content (default-tag-function 'div #:class "main-content"))
(define graduation (default-tag-function 'p #:class "graduation"))
(define header (default-tag-function 'div #:class "resume-header"))
(define job-details (default-tag-function 'ul #:class "job-details"))
(define location (default-tag-function 'p #:class "location"))
(define minor (default-tag-function 'p #:class "minor"))
(define name (default-tag-function 'h1 #:class "name"))
(define organization (default-tag-function 'p #:class "organization"))
(define position (default-tag-function 'p #:class "position"))
(define root (default-tag-function 'div #:class "wrapper"))
(define school (default-tag-function 'p #:class "school"))
(define title (default-tag-function 'h2 #:class "title"))


; Iconed Tags
(define-tag-function (phone attrs elems)
  (iconed-tag 'p phone-icon "phone" attrs elems))
(define-tag-function (email attrs elems)
  (iconed-tag 'p email-icon "email" attrs elems))
(define-tag-function (github attrs elems)
  (iconed-tag 'p github-icon "github" attrs elems))

; Section Tags
(define (section name . content)
  (let ([class (to-kebab-case name)]
        [title (list 'h3 name)])
    (append
     (list 'section `((class ,class)) title)
     content)))

; Other Tags
(define-tag-function (key-skills attrs elems)
  (list-with-header 'h4 "Key Skills" 'ul attrs elems))
(define-tag-function (other-skills attrs elems)
  (list-with-header 'h4 "Other Skills" 'ul attrs elems))

(define (item #:hide [hide #f] #:class-name [class-name "item"] . content)
  (let ([class (string-append (if hide "hidden " "") class-name)])
    `(li ((class ,class)) ,@content)))

(define (edu-class-item #:hide [hide #f] class-name class-title)
  (item #:hide hide
        `(span ((class "class-name")) ,class-name)
        "–"
        `(span ((class "class-title")) ,class-title)))

(define (skill #:hide [hide #f] . content) (apply item #:hide hide #:class-name "skill" content))

(define (duration start end)
  (list 'p '((class "duration"))
        (string-append start "—" end)))