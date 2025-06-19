#lang pollen

◊(define-meta title "Resume")
◊(define-meta stylesheets
    ("/resume/styles.css"
     "https://fonts.googleapis.com/css2?family=Roboto+Serif:ital,opsz,wght@0,8..144,100..900;1,8..144,100..900&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap"))

◊header{
	◊name{Brendon Bown}
	◊title{Software Engineer}
}

◊side-bar{
    ◊section["Contact"]{
        ◊; the 'start-text' spans are used to add in the beginning part of the text
        ◊; this helps to avoid bots scraping the email and phone number
        ◊phone{◊span[#:class "start-text"] ◊string->symbol{nbsp}655-1432}
        ◊email{◊span[#:class "start-text"] @gmail.com}
        ◊github{github.com/pixilcode}
    }

    ◊section["Education"]{
        ◊school{Brigham Young University}
        ◊location{Provo, UT}
        ◊graduation{Apr 2025}
        ◊degree{BS: Computer Science}
        ◊minor{Minor: Family Life}
        ◊edu-details{
            ◊item{GPA: 3.91}
            ◊item{Worked as a ◊strong{research assistant} studying ambiguous, left-recursive parsing}
            ◊item[#:hide #t]{Served as ◊strong{Vice President} for the Knights of the Y club for 2 years}
            ◊item[#:hide #t]{Served as ◊strong{French Officer} for Tunnel Singing club for 3 ½ years}
            ◊edu-class-item["CS 256"]{Introduction to Human-Computer Interaction}
            ◊edu-class-item["CS 260"]{Web Programming}
            ◊edu-class-item["CS 312" #:hide #t]{Algorithm Design and Analysis}
            ◊edu-class-item["CS 324" #:hide #t]{Systems Programming}
            ◊edu-class-item["CS 330" #:hide #t]{Concepts of Programming Languages}
            ◊edu-class-item["CS 340"]{Software Design}
            ◊edu-class-item["CS 401R" #:hide #t]{Software Foundations}
            ◊edu-class-item["CS 465"]{Computer Security}
            ◊edu-class-item["IS 567"]{Cybersecurity & Pen Testing}
            ◊edu-class-item["MATH 485" #:hide #t]{Mathematical Cryptography}
            ◊edu-class-item["WRTG 316"]{Technical Communication}

        }
    }

    ◊section["Skills"]{
        ◊key-skills{
            ◊skill{Rust}
            ◊skill[#:hide #t]{OCaml}
            ◊skill[#:hide #t]{C}
            ◊skill{TypeScript/JavaScript}
            ◊skill{HTML/CSS}
            ◊skill{Vue}
            ◊skill[#:hide #t]{Elm}
            ◊skill[#:hide #t]{Racket}
            ◊skill[#:hide #t]{Git/Github}
            ◊skill{Linux}
            ◊skill{Bash}
            ◊skill[#:hide #t]{Full-stack development}
            ◊skill[#:hide #t]{Programming language design}
            ◊skill[#:hide #t]{UI/UX design}
            ◊skill[#:hide #t]{Coq/theorem proofs}
            ◊skill{Cybersecurity}
        }

        ◊other-skills{
            ◊skill{Developed Tego programming language}
            ◊skill{Intermediate French}
            ◊skill{Amateur organ playing}
            ◊skill[#:hide #t]{Knitting/crocheting}
            ◊skill[#:hide #t]{Sewing}
            ◊skill[#:hide #t]{Cooking}
            ◊skill{Amateur interior design}
            ◊skill[#:hide #t]{Sword fighting}
        }
    }
}

◊main-content{
    ◊section["Experience"]{
        ◊experience{
            ◊organization{CareWeather}
            ◊position{Programming Language Designer}
            ◊duration["May 2025" "Present"]
            ◊location{Springville, UT}
            ◊job-details{
                ◊item{◊strong{Refactor the Python implementation of the Oneil programming language} in order to apply software engineering best practices}
                ◊item{◊strong{Reimplement the Oneil programming language in Rust} in order to improve performance and reliability}
                ◊item{◊strong{Design a VS Code extension for Oneil} in order to improve the developer experience}
                ◊item{◊strong{Advis on the syntax and design of the Oneil programming language} in order to improve usability and functionality}
            }
        }

        ◊experience{
            ◊organization{BYU CS Department}
            ◊position{Research Assistant}
            ◊duration["Sep 2024" "Apr 2025"]
            ◊location{Provo, UT}
            ◊job-details{
                ◊item{◊strong{Read and analyze academic articles about parsing} in order to gain an understanding of fixed-point parsing}
                ◊item{◊strong{Collaborated with advisor and other students} in order to deepen our understanding and discover new ideas}
                ◊item{◊strong{Presented in weekly meetings and in an annual research conference} in order to communicate findings}
            }
        }

        ◊experience[#:hide #t]{
            ◊organization{Lucid Software}
            ◊position{Software Engineer Intern}
            ◊duration["May 2024" "Sep 2024"]
            ◊location{South Jordan, UT}
            ◊job-details{
                ◊item{◊strong{Discovered and refactored technical debt} in order to reduce the cost of maintaining the codebase}
                ◊item{◊strong{Automated refactoring processes} in order to reduce time spent on routine tasks}
                ◊item{◊strong{Transitioned code to use encrypted data} in order to increase the security of customer data}
                ◊item[#:hide #t]{◊strong{Participated in Agile activities, such as sprints and standups,} in order to coordinate with my team}
            }
        }

        ◊experience{
            ◊organization{BYU Office of IT}
            ◊position{Computer Programmer}
            ◊duration["Jan 2022" "Apr 2024"]
            ◊location{Provo, UT}
            ◊job-details{
                ◊item{◊strong{Designed pages with Vue and TypeScript} in order to produce applications that meet client specifications}
                ◊item{◊strong{Developed APIs with TypeScript} in order to connect the front-end and back-end of applications}
                ◊item{◊strong{Maintained and updated APIs written in PHP} in order to adapt to new use cases and changing requirements}
                ◊item[#:hide #t]{◊strong{Maintained and updated Terraform scripts} in order to automate the deployment of applications to AWS}
                ◊item[#:hide #t]{◊strong{Transitioned authentication from CAS to SAML} in order to improve interoperability with other services}
                ◊item[#:hide #t]{◊strong{Modified the Apache configuration on a Linux server} in order to implement a new authentication scheme}
                ◊item{◊strong{Maintained code for a legacy web framework written in C} in order to improve security and robustness}
                ◊item[#:hide #t]{◊strong{Managed a team of 3-7 other programmers} in order to ensure that they were productive and happy}
                ◊item[#:hide #t]{◊strong{Guided a team of 3-7 other programmers} in order to help them learn the Linux shell and C}
                ◊item[#:hide #t]{◊strong{Met with a client representative weekly} in order to ensure that the product satisfied their requirements}
            }
        }
    }

    ◊section["Volunteer Experience"]{
        ◊experience{
            ◊organization{Knights of the Y}
            ◊position{Vice President}
            ◊duration["Apr 2023" "Apr 2025"]
            ◊location{Provo, UT}
            ◊job-details{
                ◊item{◊strong{Supervised weekly meetings of 40+ students} in order to ensure the safety and enjoyment of those involved}
                ◊item{◊strong{Organized club officers and members} in order to participate as a club in various campus activities}
                ◊item[#:hide #t]{◊strong{Managed club equipment and funds} in order to provide an opportunity for all members to participate}
            }
        }
    }
}
