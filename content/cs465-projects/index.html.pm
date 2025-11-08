#lang pollen

◊(define-meta title "CS 465 Projects")
◊(define-meta stylesheets ("styles.css"))

◊; TODO: add links to the projects

◊h1{Computer Security Class Projects}

◊projects[
    ◊project[#:title "Hash Attack" #:url "02-hash-attack"]{
        Explores the effectiveness of collision and pre-image attacks
        on hashes.
    }

    ◊project[#:title "Password Cracking" #:url "07-password-cracking"]{
        Uses John the Ripper to crack passwords. This project shows the importance
        of choosing strong passwords.
    }

    ◊project[#:title "Extracting Secrets" #:url "08-extracting-secrets"]{
        Extracts secrets from a binary using GDB.
    }

    ◊project[#:title "Buffer Overflow" #:url "09-buffer-overflow"]{
        Demonstrates the danger of buffer overflow in a vulnerable
        program.
    }
]
