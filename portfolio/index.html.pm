#lang pollen

◊(define-meta title "Portfolio")
◊(define-meta stylesheets ("/portfolio/styles.css"))

◊; TODO: use CSS to make tabs for each group
◊;{
Group: cybersecurity
- hash attack
- aes encryption implementation
- capture the flag explanations
- extracting secrets
- buffer overflow

Group: recipes (maybe in another page?)

Whatever else I decide to put here
}

◊group["Programming Language Design"]{
	◊items{
	    ◊item[
			#:title "Oneil Programming Language"
			#:completion-date "Ongoing"
			#:tech '("Rust")
			#:url "https://github.com/careweather/oneil"
		]{◊strong{A modeling language featuring dimensional units as types}. This language enables rapid prototyping of physical systems, such as satellites. This project is the main focus of my work at Care Weather.}

		◊item[
			#:title "Fixed-point Parser Framework"
			#:completion-date "March 2025"
			#:tech '("OCaml")
			#:url "https://github.com/pixilcode/fpp-personal-parsers"
		]{◊strong{A parser framework that handles left-recursion and ambiguity} using the mathematical concept of fixed points. This project was a part of research I did at BYU.}

		◊item[
			#:title "Tego Typechecker"
			#:completion-date "December 2024"
			#:tech '("Coq")
			#:url "https://github.com/pixilcode/tego-type-checker"
		]{◊strong{A typechecker for Tego} with proofs incorporated. This helped me to explore the idea of adding typechecking to Tego.}

		◊item[
			#:title "JS Subset Interpreter"
			#:completion-date "March 2024"
			#:tech '("OCaml")
			#:url "https://github.com/pixilcode/js-subset-interpreter"
		]{◊strong{An interpreter for a subset of JavaScript}.}

		◊item[
			#:title "Designing a Gradual Type System"
			#:completion-date "June 2023"
			#:tech '("Research")
			#:url "https://static.texttotypes.com/f9652ac4-2c5c-11f0-b5e0-3aa5a1c13538-gradual-typing.pdf"
		]{◊strong{A literature review on gradual typing}. This paper discusses implementation details of gradual typing, such as type enforcement and type errors.}

		◊item[
			#:title "Tego Language"
			#:completion-date "Ongoing"
			#:tech '("Rust")
			#:url "https://github.com/pixilcode/tego-lang"
		]{◊strong{A dynamically-typed functional programming language} with linked lists as first class members.}
	}
}

◊group["Web Design"]{
	◊items{
		◊item[
			#:title "Travel Menu"
			#:completion-date "April 2025"
			#:tech '("HTML/CSS")
			#:url "https://static.texttotypes.com/a5c01582-1edd-11f0-98f4-539897cdd130-mom-visit-2025-04/"
		]{◊strong{A menu showing meal options}, designed for my mom when she visited in April 2025. The menu lists meals and their ingredients.}

		◊item[
			#:title "Wedding Invitation"
			#:completion-date "June 2024"
			#:tech '("HTML/CSS" "JavaScript" "OCaml")
			#:url "https://wedding.texttotypes.com"
		]{◊strong{A wedding invitation website} that includes directions, RSVP, and a registry link. Note the ◊strong{responsive design} and the ability to ◊strong{print} an invitation in a standard 5x7 inch format.}

		◊item[
			#:title "New Testament Doctrines"
			#:completion-date "April 2023"
			#:tech '("HTML/CSS")
			#:url "https://ntdoctrines.texttotypes.com/"
		]{◊strong{A list of policies and doctrines from the New Testament}, organized by book. This project was a final project for a religion class.}
	}
}

◊group["Cybersecurity"]{
	◊items{
		◊item[
			#:title "RingZer0 Writeups"
			#:completion-date "December 2023"
			#:tech '("Assorted")
			#:url "/content/ringzer0-writeups"
		]{◊strong{A collection of writeups for RingZer0 CTF challenges}.}

		◊item[
			#:title "CS 465 Projects"
			#:completion-date "December 2023"
			#:tech '("Assorted")
			#:url "/content/cs465-projects"
		]{◊strong{A collection of projects from my CS 465 course}.}

		◊item[
			#:title "Secret Extraction with GDB"
			#:completion-date "November 2023"
			#:tech '("GDB")
			#:url "/content/cs465-projects/08-extracting-secrets"
		]{◊strong{A project that uses GDB to extract secrets} from a binary.}

		◊item[
			#:title "Password Cracking"
			#:completion-date "November 2023"
			#:tech '("John the Ripper")
			#:url "/content/cs465-projects/07-password-cracking"
		]{◊strong{An explanation of how to use John the Ripper} to crack passwords of varying difficulties.}

		◊item[
			#:title "Hash Attack"
			#:completion-date "September 2023"
			#:tech '("Rust", "R")
			#:url "/content/cs465-projects/02-hash-attack"
		]{◊strong{An analysis of the collision and pre-image attacks} on the SHA-1 hash function. This includes an implementation of each attack and a discussion of the results.}

		◊item[
			#:title "AES Encryption Implementation"
			#:completion-date "September 2023"
			#:tech '("Rust")
			#:url "https://github.com/pixilcode/aes-implementation-rs"
		]{◊strong{An implementation of the AES encryption algorithm} in Rust. The implementation is based on FIPS 197.}
	}
}
