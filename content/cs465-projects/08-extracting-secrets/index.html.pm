#lang pollen

◊(define-meta title "Extracting Secrets")
◊(define-meta stylesheets ("/content/styles.css"))

◊h1{Extracting Secrets}

◊p[#:class "summary"]{
    ◊em{This project explores different methods for extracting secrets from a binary
    using the compiled C binary ◊a[#:href "assets/secret_treasure"]{secret_treasure} and
    the encrypted file ◊a[#:href "assets/treasures.enc"]{treasures.enc}.}
}

◊p{
    Often, software has secrets that it's trying to hide or data that it is refusing
    access to. For example, game companies want to keep players from copying their
    content; management software has API keys and sensitive data that could be
    dangerous for hackers to get their hands on.
}

◊p{
    An naive software developer may include those secrets directly in the code.
    Thus, if a hacker gets access to the code, they have access to the secrets
    directly. A more security-minded software developer might keep those secrets in
    a seperate file, possible encrypted. This could make it more difficult for a
    hacker to gain access to the secrets, since the files are usually not stored
    with the code.
}

◊p{
    However, in spite of this, it is still possible for a hacker to gain access to
    this data, even if it's encrypted, through the use of a debugger or code
    modification tools.
}

◊p{
    In this project, I am given a compiled C binary, ◊inline-code{secret_treasure}, and an
    encrypted file, ◊inline-code{treasures.enc}. When run, the program prompts for a secret key.
    It then checks the input secret key to see if it is valid. If it is, the program
    prints out a random hidden treasure (some sort of quote). If it isn't, the
    program prints out ◊inline-code{Who are you trying to fool?} (see Figure 1).
}

◊img[#:src "images/normal-run.png" #:alt "A normal run of the `secret_treasure` binary with an invalid password"]

◊p{
    Using this binary and its associated treasures, I will explore how the security
    measures implemented in this binary (password protection and secret encryption)
    can be circumvented with a debugger and with binary modification tools.
}


◊h2{Circumvention by Debugger}

◊p{
    First, I will circumvent the security measures with the GDB debugger. To begin,
    I open up the binary in ◊inline-code{gdb}:
}

◊code-block[#:lang "bash"]{
gdb secret_treasure
}

◊p{
    After setting the layout to display the assembly code with ◊inline-code{layout asm}, I set a
    breakpoint at the beginning of the ◊inline-code{main} function with ◊inline-code{break main}. Then, I
    run the program with ◊inline-code{treasures.enc} as an argument, with all input read from
    ◊inline-code{input.txt}, and with all output written to ◊inline-code{output.txt} (so as not to mess with
    the debugger display). I do this with ◊inline-code{run treasures.enc < input.txt > output.txt}. ◊inline-code{input.txt} has the string ◊inline-code{not_a_password}, which is not the
    correct password.
}

◊p{
    After that, I step through the code with ◊inline-code{next} until I step over the
    instruction that calls ◊inline-code{checkKey}. This leaves me on a ◊inline-code{cmpl} instruction, which
    is the check that causes the program to exit early if the password is not valid.
    In order to determine which variable I should modify, I print the variables with
    ◊inline-code{info locals}. Seeing that there is a variable labeled ◊inline-code{isValidKey}, I set it to
    true (or ◊inline-code{1}) with ◊inline-code{set isValidKey = 1}. Finally, I let the program run to
    completion with ◊inline-code{continue}.
}

◊p{
    Once the program has completed, I am able to find one of the treasures printed
    out in ◊inline-code{output.txt}.
}

◊p{
    My complete GDB session is as follows:
}

◊code-block[#:lang "gdb"]{
layout asm
break main

run treasures.enc < input.txt > output.txt

next
# ... repeat until I reach the `cmpl` instruction

info locals
set isValidKey = 1
continue
}

◊img[#:src "images/gdb-modify-variable.png" #:alt "A GDB session where I have just set `isValidKey` to `1`"]


◊h2{Circumvention by Modifying the Binary}

◊p{
    Another way that I could get around the check is to modify it to accept both
    ◊inline-code{true} ◊em{and} ◊inline-code{false}. I could do this by modifying the jump instruction. As I
    was running the circumvention with the debugger, I encountered the ◊inline-code{cmpl} and
    ◊inline-code{jne} instruction, which says that if the value is not equal to 0, jump ahead.
    This means that if the value is ◊inline-code{true} it jumps to the code that decrypts the
    treasure, while if the value is ◊inline-code{false}, it doesn't jump, and it proceeds to
    exit the program. These instructions are shown in Figure 3.
}

◊img[#:src "images/jump-instruction.png" #:alt "The jump instructions that decide whether or not to exit the program"]

◊p{
    Instead of having to modify the ◊inline-code{isValidKey} variable each time I run the
    program in GDB, I can just modify the jump instruction to allow me to access it
    no matter what.
}

◊p{
    My initial thought was to switch the ◊inline-code{jne} (Jump Not Equal) instruction to a
    ◊inline-code{jge} (Jump Greater or Equal) instruction, since both ◊inline-code{0} and ◊inline-code{1} are greater
    than or equal to ◊inline-code{0}. However, I don't actually know for sure what ◊inline-code{isValidKey}
    returns, other than the fact that a ◊inline-code{0} indicates that the program should quit.
    ◊inline-code{isValidKey} could return ◊inline-code{-1} to indicate ◊inline-code{true}, in which case the program
    would still exit, since ◊inline-code{-1} is not greater than or equal to ◊inline-code{0}. I could step
    through ◊inline-code{isValidKey}, but I'm not sure how long or complex ◊inline-code{isValidKey} is, and
    I don't feel like taking the time to find out.
}

◊p{
    So, instead of switching it to ◊inline-code{jge} (Jump Greater or Equal), I decide to switch
    it to ◊inline-code{jmp} (Unconditional Jump). This way, no matter what value ◊inline-code{isValidKey}
    has, the program will always jump past the exit instructions.
}

◊p{
    So, I find the machine code associated with the instruction with ◊inline-code{objdump}. I
    open the ◊inline-code{secret_treasure} binary with ◊inline-code{objdump} and feed the output to ◊inline-code{less}
    for easier viewing and searching. The argument ◊inline-code{-M intel} describes what dialect
    of machine code to display, and the argument ◊inline-code{-d} indicates that the executable
    sections should be disassembled and displayed.
}

◊code-block[#:lang "bash"]{
objdump -M intel -d secret_treasure | less
}

◊p{
    Then, I find the instructions for ◊inline-code{main} in the output, after which I find the
    specific ◊inline-code{jne} instruction that I'd noticed earlier.
}

◊img[#:src "images/program-instructions.png" #:alt "The section of the binary with the `jne` instruction"]

◊p{
    Next, I open up the binary in ◊inline-code{vim}. The ◊inline-code{-b} flag allows for easier
    modification of binary files.
}

◊code-block[#:lang "bash"]{
vim -b secret_treasure
}

◊p{
    Once it is open, I convert it to a human-readable hexadecimal encoding with ◊inline-code{:%! xxd}.
    Then, I search for the sequence of hexadecimal characters for the ◊inline-code{jne}
    instruction. Once I find the correct bytes. I switch the ◊inline-code{jne} byte, ◊inline-code{75}, to a
    ◊inline-code{jmp} byte, ◊inline-code{eb}. Finally, I convert back to bytes with ◊inline-code{:%! xxd -r} and save
    it.
}

◊p{
    I then print out the instruction dump again to verify that the instruction has
    changed.
}

◊img[#:src "images/program-instructions-modified.png" #:alt "The section of the binary with the modified `jmp` instruction"]

◊p{
    After this, I run the program a couple times to verify that it accepts any password.
}

◊img[#:src "images/successful-runs.png" #:alt "A series of successful runs with different passwords"]


◊h2{Finding ◊em{All} the Treasures!}

◊p{
    So, I can get random treasures from the encoded file. However, I've been
    informed that there are some treasures that will never be printed. So I need to
    find another way to get ◊em{all} the treasures.
}

◊p{
    In order to get ◊em{all} the treasures, I am going to print out the value of the
    string that is decrypted from the file. As I was debugging, I noticed that there
    is a ◊inline-code{readQuotes} function. I look into that function further in the instruction
    dump, and I find that there's a section a call to ◊inline-code{decryptCipher} and a call to
    ◊inline-code{strstr}, which I suspect is where the treasures are split up into individual
    strings. So I can print the output of ◊inline-code{decryptCipher} to find the string with
    all of the treasures.
}

◊img[#:src "images/vulnerable-section.png" #:alt "The instructions between the call to `decryptCipher` and `strstr`"]

◊p{
    So, I fire up GDB and run ◊inline-code{layout asm}. I set a break point inside of
    ◊inline-code{readQuotes} with ◊inline-code{break readQuotes}. Then I run the program with `run
    treasures.enc < input.txt > output.txt`, like before.
}

◊p{
    Once it hits the breakpoint in ◊inline-code{readQuotes}, I step through the instructions
    with ◊inline-code{next} until it passes the ◊inline-code{decryptCipher} call. Then, listing the local
    variables with ◊inline-code{info locals}, I see a variable labeled ◊inline-code{plaintext}. I run ◊inline-code{call
    printf("%s", plaintext)} so that all the treasures are printed to the output
    file. Finally, I run ◊inline-code{continue} to finish the program and flush ◊inline-code{stdout}.
}

◊p{
    Once this is complete, I check output file and find a series of ◊inline-code{-&&&-}
    delimited treasures, plus a little garbled text at the end (which I assume is
    because this string is not null-terminated). Thus, the treasures that I found were as follows:
}

◊code-block{
-&&&-
"A wizard cannot do everything; a fact most magicians are reticent to admit,
let alone discuss with prospective clients.  Still, the fact remains that
there are certain objects, and people, that are, for one reason or another,
completely immune to any direct magical spell.  It is for this group of
beings that the magician learns the subtleties of using indirect spells.
It also does no harm, in dealing with these matters, to carry a large club
near your person at all times."
                -- The Teachings of Ebenezum, Volume VIII
-&&&-
"Do not meddle in the affairs of wizards, for you are crunchy and good
with ketchup."
-&&&-
Rincewind had generally been considered by his tutors to be a natural wizard
in the same way that fish are natural mountaineers.  He probably would have
been thrown out of Unseen University anyway--he couldn't remember spells and
smoking made him feel ill.
                -- Terry Pratchett, "The Light Fantastic"


                 ___          ______           Frobtech, Inc.
                /__/\     ___/_____/\
                \  \ \   /         /\\
                 \  \ \_/__       /  \         "If you've got the job,
                 _\  \ \  /\_____/___ \         we've got the frob."
                // \__\/ /  \       /\ \
        _______//_______/    \     / _\/______
       /      / \       \    /    / /        /\
    __/      /   \       \  /    / /        / _\__
   / /      /     \_______\/    / /        / /   /\
  /_/______/___________________/ /________/ /___/  \
  \ \      \    ___________    \ \        \ \   \  /
   \_\      \  /          /\    \ \        \ \___\/
      \      \/          /  \    \ \        \  /
       \_____/          /    \    \ \________\/
            /__________/      \    \  /
            \   _____  \      /_____\/
             \ /    /\  \    / \  \ \
              /____/  \  \  /   \  \ \
              \    \  /___\/     \  \ \
               \____\/            \__\/
-&&&-
Win98 error 001: Unexpected condition: booted without crashing.
-&&&-
Win98 error 002: Insufficient diskspace. You need at least 300 GB free memory.
-&&&-
Win98 error 003: Illegal ASM instruction. If your modem worked properly, the
FBI would have been called.
-&&&-
Win NT error 001: Error recording error codes. All further errors not
displayed.
-&&&-
Win98 error 004: Virus activated from DOS Prompt - but the virus requires
Windows. Your system will be rebooted for the Virus to take effect. [ OK ]
-&&&-
Win98 error 005: Mouse not found. Click left mouse button on ok to continue.
-&&&-
Win98 error 006: Keyboard not found. Press F1 to continue.
-&&&-
(1)     Office employees will daily sweep the floors, dust the
        furniture, shelves, and showcases.
(2)     Each day fill lamps, clean chimneys, and trim wicks.
        Wash the windows once a week.
(3)     Each clerk will bring a bucket of water and a scuttle of
        coal for the day's business.
(4)     Make your pens carefully.  You may whittle nibs to your
        individual taste.
(5)     This office will open at 7 a.m. and close at 8 p.m. except
        on the Sabbath, on which day we will remain closed.  Each
        employee is expected to spend the Sabbath by attending
        church and contributing liberally to the cause of the Lord.
                -- "Office Worker's Guide", New England Carriage
                    Works, 1872
-&&&-
A Thaum is the basic unit of magical strength.  It has been universally
established as the amount of magic needed to create one small white pigeon
or three normal sized billiard balls.
                -- Terry Pratchett, "The Light Fantastic"
-&&&-
-&&&-
}

◊p{
    And thus I have acquired ◊em{all} the treasures! (Assuming the plaintext is the
    only place where treasures exist)
}
