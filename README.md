# Are You the One Simulation

![alt text](mastermind.jpg)

    Basically mastermind, but the pegs are people.

## Rules of the Game:

    - A game starts with equal numbers of males and females (10 on the show).
    - Every turn, the player does two things:
        - guesses a single male/female pair, receives immediate yes/no
        - guesses a total lineup, recieves a number of matches
        - If the lineup is correct on or before the 10th turn, player wins

## Running the Simulation

    $ ruby run_simulation.rb

## Dependencies

    - Ruby
    - OpenStruct

## Example Output
```
-----------------------------------------------------------------
Turn 7: 
-----------------------------------------------------------------
Current Knowledge:

         .  .  .  .  .  .  .  .  .  . 
         o  .  .  .  .  .  .  o  .  . 
         .  .  .  .  .  .  .  o  .  . 
         .  .  .  .  .  .  .  .  .  . 
         .  .  .  o  .  o  .  .  .  . 
         o  .  .  .  .  .  .  .  .  . 
         .  .  .  .  .  .  .  .  .  . 
         .  .  .  .  .  .  .  .  .  . 
         .  .  .  .  .  .  .  .  .  . 
         .  .  .  .  .  .  .  .  .  . 

-----------------------------------------------------------------
GUESS:
        - start_state { Good: 0/10, Bad:  6/90 }
        - I found 94 pairs I could guess...
        - Guessing: (John + Colyseah)

FEEDBACK:
        - Guess was correct!
                - (John + Colyseah) set to YES
                - (John + Shanley) set to NO
                - (John + Paige) set to NO
                - (John + Kayla) set to NO
                - (John + Amber) set to NO
                - (John + Jessica) set to NO
                - (John + Jacy) set to NO
                - (John + Simone) set to NO
                - (John + Ashleigh) set to NO
                - (John + Brittany) set to NO
                - (Adam + Colyseah) set to NO
                - (Scali + Colyseah) set to NO
                - (Dre + Colyseah) set to NO
                - (Ryan + Colyseah) set to NO
                - (Ethan + Colyseah) set to NO
                - (Dillan + Colyseah) set to NO
                - (Chris_T + Colyseah) set to NO
                - (Wes + Colyseah) set to NO
                - (Joey + Colyseah) set to NO

LINEUP:
        - I'm picking my 1 known pairs
        - I'm adding 9 random ones

FEEDBACK:
        - I got 2 right!
-----------------------------------------------------------------
Turn 8: 
-----------------------------------------------------------------
Current Knowledge:

         .  .  .  .  .  .  .  .  o  . 
         o  .  .  .  .  .  .  o  o  . 
         .  .  .  .  .  .  .  o  o  . 
         .  .  .  .  .  .  .  .  o  . 
         .  .  .  o  .  o  .  .  o  . 
         o  .  .  .  .  .  .  .  o  . 
         .  .  .  .  .  .  .  .  o  . 
         o  o  o  o  o  o  o  o  X  o 
         .  .  .  .  .  .  .  .  o  . 
         .  .  .  .  .  .  .  .  o  . 

-----------------------------------------------------------------
GUESS:
        - start_state { Good: 1/10, Bad:  24/90 }
        - I found 75 pairs I could guess...
        - Guessing: (Chris_T + Jacy)

FEEDBACK:
        - Guess was incorrect!
                - (Chris_T + Jacy) set to NO

LINEUP:
        - I'm picking my 1 known pairs
        - I'm adding 9 random ones

FEEDBACK:
        - I got 2 right!
```