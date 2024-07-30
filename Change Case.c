// Start of file changecase.a

// MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron.

/*
   Question:
   Write a C function sentenceCase, which takes one argument
   of type char* (pointer to a string) and changes the case
   of all letters in the string so that the first character
   is capitalized (UPPERCASE) and all the remaining letters
   are lowercase.
   Do not refer to the variable "teststr".
*/
// Output format must be:
// "After 1999 came 2000 [square brackets]"

#include <stdio.h>  // For printf in C programs
#include <stdlib.h> // For exit() in C programs

//##############################################
//                                             //
//               text segment                  //
//                                             //
//##############################################

char anotherteststr[] = "aFtEr 1999 cAmE 2000 [Square Brackets]\n";
//char anotherteststr[] = " zebrA stRIPes @ ZEbra\n";

/* Any changes above this line will be discarded 
   . Put your answer between dashed lines. */
   //-------------- start cut -----------------------


#include <stdbool.h>

void sentenceCase(char* s)
{
    bool first = true;

    for (int i = 0; s[i] != '\0'; i++) { // Change '\n' to '\0' to handle entire string
        if (s[i] >= 'A' && s[i] <= 'Z') {
            if (first) {
                s[i] = s[i]; // First uppercase letter stays the same
                first = false;
            }
            else {
                s[i] = s[i] | 32; // Convert to lowercase
            }
        }
        else if (s[i] >= 'a' && s[i] <= 'z') {
            if (first) {
                s[i] = s[i] & ~32; // Convert to uppercase
                first = false;
            }
            else {
                s[i] = s[i]; // Lowercase letter stays the same
            }
        }
    }
}

/*
    j __start  // Nasty loop if MIPS program not exited
*/
//--------------  end cut  -----------------------
// Any changes below this line will be discarded by
// mipsmark. Put your answer between dashed lines.

//##############################################
//                                             //
//               data segment                  //
//                                             //
//##############################################

int main()
{
    sentenceCase(anotherteststr);
    puts(anotherteststr);
    return 0;
}

// End of file changecase.a
