#lang pollen

◊(define-meta title "Password Cracking")
◊(define-meta stylesheets ("/content/cs465-projects/styles.css"))

◊h1{Password Cracking}

◊p[#:class "summary"]{
    ◊em{In this project, I explore how an open source tool known as
    ◊a[#:href "https://www.openwall.com/john/"]{John the Ripper} can be used
    to break passwords, and I demonstrate the importance of choosing strong
    passwords.}
}

◊p{
    Passwords are used all over the place in order to ensure that users are who they
    say they are. In theory, only the user should know the specific password that
    they chose. Therefore, a user can be authenticated by requiring them to provide
    the password that they originally chose.
}

◊p{
    This requires that the service be able to verify that the password is correct.
    While the simplest way to do this would be to store the user's password in
    plaintext, this would be insecure, since a hacker that has access to the service
    would be able to use those passwords in order to authenticate as any user.
    Therefore, password security is created by using a hashing function.
}

◊p{
    Instead of storing the password itself, the service stores the hash of the
    password. In addition, sometimes a ◊em{salt} (a random set of bits) is incorporated
    into the hash in order to add a source of randomness as an extra layer of
    protection.
}

◊p{
    Because of the nature of cryptographic hash functions, the only way to determine
    a user's password is to continually guess passwords and compute their hashes
    until you find one that matches the hash. If passwords were randomly generated,
    this means that the best solution is to brute-force guess passwords. However,
    the passwords are usually created by humans who need some way to remember the
    password.
}

◊p{
    The result of this is that passwords can often be guessed based on a list of
    words. Rather than just guessing random permutations of characters, hackers can
    instead guess modified versions of words in the wordlist. This makes cracking
    passwords a lot faster.
}

◊h2{Simple Passwords}

◊p{
    In this project, I use John the Ripper in order to crack the following five
    passwords:
}

◊code-block{
frank:9f9d51bc70ef21ca5c14f307980a29d8
albert:b8b6718e7b997beaef8354ee1a1375a9
susan:1f0d628aff498776c391d147d3f8d605
shaniqua:a54eb809d56e632a229a27507664b3bd
lafawnda:8b6e10530f75d23c0a0eca4d5671db7d
}

◊p{
    John the Ripper is a password-cracking tool that guesses passwords by hashing
    different strings until it finds a hash that matches the password's hash. It has
    some preset defaults that can be used with the following command (assuming the
    password hashes are found in the file ◊inline-code{passwords.txt}):
}

◊code-block[#:lang "bash"]{
john --format=raw-md5 passwords.txt
}

◊p{
    This command first runs an attack using a predefined wordlist. With this
    wordlist, it quickly finds the passwords for ◊inline-code{frank} and ◊inline-code{susan}, which are
    ◊inline-code{bob} and ◊inline-code{spiderman4}. Likely, ◊inline-code{bob} is directly on the wordlist, and
    ◊inline-code{spiderman4} is a concatenation of ◊inline-code{spider}, ◊inline-code{man}, and the number ◊inline-code{4} added at
    the end.
}

◊p{
    It then proceeds to use an incremental attack, going through every possible
    combination of ASCII characters to see if its hash matches the password hash.
    Doing this, it finds ◊inline-code{lafawnda}'s password, ◊inline-code{drstrange}, after about 5 minutes.
}

◊p{
    When I ran this command, I left the process running in the background on one
    core for about four hours in order to see if it would break any of the other
    passwords. However, it was unable to break the two remaining passwords.
}

◊p{
    My next attack on the passwords involved the following custom wordlist,
    ◊inline-code{wordlist.lst} (based on the topic of 'superheros', which I've been told is the
    general topic of the websites these passwords are for):
}

◊code-block{
avengers
assemble
batman
drstrange
ironman
spiderman
superman
thor
wonderwoman
}

◊p{
    In addition, I use a custom set of rules in order to test different mangled
    versions of the passwords. This is based on the wordlist rules syntax found at
    ◊a[#:href "https://www.openwall.com/john/doc/RULES.shtml"]{https://www.openwall.com/john/doc/RULES.shtml}.
    The rules that I chose were:
}

◊code-block{
[List.Rules:Custom]
# do nothing
:

# uppercase all letters
u

# capitalize first letter and lowercase rest
c

# duplicate word
d

# try out common substitutions
ss$ sa@ sl1 se3 sH#

# add numbers to beginning and end
A0"[0-9]"
A0"[0-9]" A0"[0-9]"
Az"[0-9]"
Az"[0-9]" Az"[0-9]"
A0"[0-9]" Az"[0-9]"

# try different combinations of the above rules
u ss$ sa@ sl1 se3 sH#
c ss$ sa@ sl1 se3 sH#
d ss$ sa@ sl1 se3 sH#
u A0"[0-9]"
u A0"[0-9]" A0"[0-9]"
u Az"[0-9]"
u Az"[0-9]" Az"[0-9]"
u A0"[0-9]" Az"[0-9]"
c A0"[0-9]"
c A0"[0-9]" A0"[0-9]"
c Az"[0-9]"
c Az"[0-9]" Az"[0-9]"
c A0"[0-9]" Az"[0-9]"
d A0"[0-9]"
d A0"[0-9]" A0"[0-9]"
d Az"[0-9]"
d Az"[0-9]" Az"[0-9]"
d A0"[0-9]" Az"[0-9]"
u A0"[0-9]" ss$ sa@ sl1 se3 sH#
u A0"[0-9]" A0"[0-9]" ss$ sa@ sl1 se3 sH#
u Az"[0-9]" ss$ sa@ sl1 se3 sH#
u Az"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
u A0"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
c A0"[0-9]" ss$ sa@ sl1 se3 sH#
c A0"[0-9]" A0"[0-9]" ss$ sa@ sl1 se3 sH#
c Az"[0-9]" ss$ sa@ sl1 se3 sH#
c Az"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
c A0"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
d A0"[0-9]" ss$ sa@ sl1 se3 sH#
d A0"[0-9]" A0"[0-9]" ss$ sa@ sl1 se3 sH#
d Az"[0-9]" ss$ sa@ sl1 se3 sH#
d Az"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
d A0"[0-9]" Az"[0-9]" ss$ sa@ sl1 se3 sH#
}

◊p{
    These rules were placed in a custom config file, ◊inline-code{custom.conf} (based on the
    configuration found in ◊inline-code{/etc/john/john.conf}. Finally, I ran John with the
    custom wordlist and custom config with the following command:
}

◊code-block{
john passwords.txt \
  --format=raw-md5 \
  --config=john.conf \
  --wordlist=wordlist.lst \
  --rules:Custom
}

◊p{
    Running John with this custom wordlist and ruleset, I was able to find 4 of the
    5 passwords in less than a second. The only one I was unable to find was
    ◊inline-code{frank}, since his password, ◊inline-code{bob}, was not generated by the combination of
    wordlist and ruleset. However, I'd found his in my previous attempt, so this
    wasn't a problem.
}

◊p{
    The resulting passwords that I found are:
}

◊code-block{
frank:bob
albert:Assemble
susan:spiderman4
shaniqua:Wonderwoman1
lafawnda:drstrange
}


◊h2{Different Password Strengths}

◊p{
    In addition to trying to crack simple hashed passwords, I attempted a similar
    attempt on passwords that were hashed ◊em{and} incorporated a salt into the
    hashing. These passwords are assumed to be for a fishing website.
}

◊h3{Picking Passwords}

◊p{
    I chose four passwords of varying difficulty:
}

◊ul{
  ◊li{◊strong{Easy}: ◊inline-code{catfish}}

  ◊li{◊strong{Average}: ◊inline-code{s@lm0ns!}}

  ◊li{◊strong{Hard}: ◊inline-code{fI$hIng4d@Ys}}

  ◊li{◊strong{Random 16-character sequence}: ◊inline-code{ugPPdz0vpLJcevOi}}
}

◊p{
    I expected that the easy password would be broken almost immediately, since it's
    just a word (and a compound word nonetheless).
}

◊p{
    I also expected that the average password would be broken pretty quickly since
    it was just a mangling of ◊inline-code{salmon} with common substitutions. However, it does
    have an ◊inline-code{s} at the end, and 'salmon' is not usually pluralized in that way. It
    also has ◊inline-code{!} at the end, though that could easily be guessed.
}

◊p{
    The hard password would likely be somewhat more difficult with a number in
    between two words, as well as common substitutions and vowel capitalization.
}

◊p{
    The random password would likely be impossible to crack since the only way to
    guess it is incrementally, and guessing all permutations of a 16-character
    sequence takes an extremely long time.
}

◊p{
    These are the expected difficulties of each password on its own. Adding in a
    salt increases the difficulty, since each guess would have to tried with each
    unique salt.
}


◊h3{Hashing Passwords}

◊p{
    After picking the passwords that I was going to use, I generated a salted hash
    twice for each password with the following command:
}

◊code-block[#:lang "bash"]{
mkpasswd --method=MD5 '<PASSWORD>' >> password-hash.txt
}

◊p{
    This resulted in the following salted hashes:
}

◊code-block{
$1$f0RegMmL$nvbPx5GgBFsaClrM/twTS1
$1$/8LtbXgM$ce1tKxnMsgrVnlUmJhLD90
$1$bMGRoNNE$A1yxwXqFw6sFG5apqVLyD1
$1$RRtthvZ5$YONokWI0LCkmmhAhCVkyC1
$1$Atp8HQt.$ENSvI3/W27y3kzZo8uzki1
$1$CRql5mjd$gdPM3theQO/0WaQj2yfEV.
$1$U/ulEbUe$wTmYstM2qqzkYs0CxFxn80
$1$osjKWLYy$CGOqGsvk2Zmfr5OxUYWVx0
}


◊h3{Breaking the Passwords}

◊p{
    To begin breaking the passwords, I decided to use John's builtin wordlist to see
    if it could find anything. This is done with the following command:
}

◊code-block[#:lang "bash"]{
john passwords-hash.txt
}

◊p{
    This ran quickly, but it only found the easy ◊inline-code{catfish} passwords. So the next
    option that I tried was to use a wordlist. I generated this wordlist by asking
    ChatGPT to provide me 50 common words, 50 words related to fishing, and as many
    species of fish as it could think of. After touching these up, I put them in a
    wordlist file, ◊inline-code{wordlist.lst}. Then, I ran John with the wordlist and its
    built-in ◊inline-code{Jumbo} word-mangling ruleset.
}

◊code-block[#:lang "bash"]{
john password-hash.txt \
  --rules:Jumbo \
  --wordlist=wordlist.lst
}

◊p{
    However, using this word list, it still was unable to crack any of the passwords
    except the plaintext ◊inline-code{catfish}. I didn't expect it to crack the hard password,
    since ◊inline-code{days} was not in the wordlist. However, I was surprised to find that it
    didn't find the average password, even though ◊inline-code{salmon} was on the wordlist.
}

◊p{
    I made two more attempts to break the password, once using the ◊inline-code{All} ruleset,
    which included popular custom rulesets, and once adding ◊inline-code{day} to the wordlist.
    The ◊inline-code{All} ruleset seemed a lot more in depth, and it was still running after 5
    minutes, though it hadn't found anything new. Adding ◊inline-code{day} to the wordlist
    didn't help John to find the hard password.
}

◊p{
    I also attempted to break the random 16-character alphanumeric password by
    configuring John to search that space only.
}

◊code-block{
john password-hash.txt \
  --length=16 \
  --incremental=Alnum
}

◊p{
    However, this resulted in an error:
}

◊code-block{
Can't set max length larger than 15 for md5crypt format
}

◊p{
    Thus, of all the passwords that I chose earlier, only the easiest, ◊inline-code{catfish},
    was able to be quickly broken. This is only taking into account the first 5
    minutes of the ◊inline-code{All} ruleset, though. It is possible that others could be broken
    if more time was allocated to completely run the ◊inline-code{All} ruleset.
}


◊h2{Questions}

◊ol{
    ◊li{
        ◊p{◊strong{Did you use John the Ripper, Hashcat, or both?}}

        ◊p{I used John the Ripper.}
    }

    ◊li{
        ◊p{◊strong{What are the 5 passwords you found?}}

        ◊code-block{
        frank:bob
        albert:Assemble
        susan:spiderman4
        shaniqua:Wonderwoman1
        lafawnda:drstrange
        }
    }

    ◊li{
        ◊p{
            ◊strong{Assuming that you used your setup for this lab alone, how long do you
            calculate that it would take to crack a 6-character alphanumeric
            password? 8-characters? 10-characters? 12-characters? (use the c/s or H/s
            measurement from your experiments).}
        }

        ◊p{
            On average, my setup was running about 75,000 hashes per second. There
            are 26 lowercase letters, 26 uppercase letters, and 10 numbers, which
            means that there are 62 possible different characters. Thus, the
            calculation of time would be as follows:
        }

        ◊ul{
            ◊li{
                ◊em{6 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 6 = 56800235584}}
                    ◊li{◊inline-code{max_time = 56800235584 / 75000 = 757336}}
                    ◊li{◊inline-code{average_time = 757336 / 2 = 378668}}
                }
            }

            ◊li{
                ◊em{8 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 8 = 218340105584896}}
                    ◊li{◊inline-code{max_time = 218340105584896 / 75000 = 2911201407.7986135}}
                    ◊li{◊inline-code{average_time = 2911201407 / 2 = 1455600703}}
                }
            }

            ◊li{
                ◊em{10 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 10 = 839299365868340200}}
                    ◊li{◊inline-code{max_time = 839299365868340200 / 75000 = 11190658211577}}
                    ◊li{◊inline-code{average_time = 11190658211577 / 2 = 5595329105788}}
                }
            }

            ◊li{
                ◊em{12 characters}
                ◊ul{
                    ◊em{◊inline-code{num_possible = 62 ^ 12 = 3.226e+21}}
                    ◊em{◊inline-code{max_time = 3.226e+21 / 75000 = 43016890165305330}}
                    ◊em{◊inline-code{average_time = 43016890165305330 / 2 = 21508445082652664}}
                }
            }
        }
    }

    ◊li{

        ◊p{
            ◊strong{Recently, high-end GPUs have revolutionized password cracking. Hashcat
            used 8 Nvidia RTX 4090s to reportedly achieve 300 billion hashes per
            second. Consider your calculations in question #1, and redo them assuming
            you had access to a system with 8 Nvidia RTX 4090s. Do your answers for
            question #2 change?}
        }

        ◊p{
            ◊em{NOTE: I was unsure of what questions #1 and #2 were, so I simply redid
            the calculations}
        }

        ◊p{
            At a rate of 300 billion hashes per second, the calculations would be as
            follows:
        }

        ◊ul{
            ◊li{
                ◊em{6 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 6 = 56800235584}}
                    ◊li{◊inline-code{max_time = 56800235584 / 300000000000 = 0.189 seconds}}
                    ◊li{◊inline-code{average_time = 0.189 / 2 = 0.094 seconds}}
                }
            }

            ◊li{
                ◊em{8 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 8 = 218340105584896}}
                    ◊li{◊inline-code{max_time = 218340105584896 / 300000000000 = 727.800 seconds}}
                    ◊li{◊inline-code{average_time = 727.800 / 2 = 363.900 seconds}}
                }
            }

            ◊li{
                ◊em{10 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 10 = 839299365868340200}}
                    ◊li{◊inline-code{max_time = 839299365868340200 / 300000000000 = 2797664.552 seconds}}
                    ◊li{◊inline-code{average_time = 2797664.552 / 2 = 1398832.276 seconds}}
                }
            }

            ◊li{
                ◊em{12 characters}
                ◊ul{
                    ◊li{◊inline-code{num_possible = 62 ^ 12 = 3.226e+21}}
                    ◊li{◊inline-code{max_time = 3.226e+21 / 300000000000 = 10754222541.326 seconds}}
                    ◊li{◊inline-code{average_time = 10754222541.326 / 2 = 5377111270.663 seconds}}
                }
            }
        }
    }

    ◊li{
        ◊p{
            ◊strong{Does the use of a salt increase password security? Why or why not?}
        }

        ◊p{
            The salt does increase password security. It adds randomness to the hash
            so that two passwords that are the exact same don't have the exact same
            hash. In addition, it defeats pre-generated hashes, since it's impossible
            to pre-generate a hash if the salt isn't known beforehand. And if each
            user has their own individual hash, hackers must attack one password at a
            time since the likelihood of a salt being in two different passwords is
            extremely low.
        }
    }

    ◊li{
        ◊p{
            ◊strong{Modern Linux distributions use a SHA-512 (rather than MD5) for hashing
            passwords. Does the use of this hashing algorithm improve password
            security in some way? Why or why not?}
        }

        ◊p{
            Using the SHA-512 algorithm improves the security over MD5 since it is
            relatively easy in today's world to produce a collision for MD5. SHA-512,
            on the other hand, is much more difficult to find collisions for. In
            addition, SHA-512 is slower than MD5. It's not noticeable enough for a
            single password, but it reduces the amount of hashes per second that can
            be computed.
        }
    }

    ◊li{
        ◊p{
            ◊strong{Against any competent system, an online attack of this nature would not
            be possible due to network lag, timeouts, and throttling by the system
            administrator. Does this knowledge lessen the importance of offline
            password attack protection?}
        }

        ◊p{
            No. If a hacker is able to gain access to the password hashes and salts
            directly, it should still be difficult to break them, since a hacker
            could have access to powerful resources.
        }
    }
}
