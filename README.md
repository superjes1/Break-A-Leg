# Break A Leg
Break A Leg adds a proper immobilisation system into Arma using the ACE medical framework.

What does this mean?

More or less, when you get shot in your legs enough, you won't be able to stand back up until you heal your wounds. 
Think of it as a more active ACE Unconscious state, you can still communicate and shoot back, but moving anywhere quickly is no longer an option.

## Features! 
* Incapacitation system that stops the player from moving after they take to much damage!
* Extensive CBA settings that gives you near complete control over just about everything this mod does!
* Built in support for Fractures, Pain, Bleeding Rate and Bloodloss!
* Built in system to tell your players why they cant move
* Built in support for open, bandaged and, for the especially cruel Zeuses, stitched wounds!
* Fully Customizable wound levels, without using disambigious thresholds, so you can decide exactly what wounds should and shouldn't incapacitate your players!
* Stacking Wound system, for those that feel that 1 large avulsion isn't enough, but 2 large avulsions should incapacitate! 
* Performance focused coding approach, so that even a potato can run the mod without much of an effect (I hope)
* Funny Ragdolls!
* The tears of your Players!

## What causes you to become Incapacitated?
A player will become incapacitated when they have taken sufficient damage in one or both of their legs, while also factoring in the players pain, bleed rate and blood loss to a lesser degree.

However, it isn't decided by a simple damage threshold.
Instead, it adjusts how wounded one leg needs to be in order to incapacitate the player based on how wounded the other leg is.
To do this, each leg is assigned one of 5 "damage states", which is based on the type, size, and to a lesser degree amount of untreated wounds that are on that leg.
In order of severity: None, Minor, Major, Critical, Catastrophic.

As an example, if one leg is wounded to a 'Catastrophic' degree, then it alone can be enough to incapacitate the player.
However, if that leg is only in a 'Critical' state instead, then the other leg only needs enough 'Minor' wounds in order for that player to become incapacitated.
Similarly, 'Major' wounds on both legs will incapacitate the player, but enough 'Major' wounds on one leg and enough 'Minor' wounds on the other will not.

This is further expanded when pain, bleed rate and blood loss are factored in.   
If the player is in enough pain, is bleeding too quickly and/or has lost too much blood, the player can be incapacitated even if the wounds on their legs would otherwise be insufficient to incapacitate them.   
These 3 factors are collectively referred to as the players "Body Wounds", as they represent wounds across the entire body, rather than just one limb.   
Body Wounds are also a requirement for the last of way that players can be incapacitated, which occurs when both legs have enough 'Minor' wounds as well as some 'Minor' Body Wounds.   

## How does it work?
When checking if a player should be incapacitated, BAL uses the list of wounds on each leg (As well as their Body Wounds) that the player sees in the ACE medical menu, rather than the amount of damage that those wounds represent.   
This allows the players to directly see what is causing them to be incapacitated, and gives much more control over what wound types are considered in the calculation, and how impactful they are.   
However, that list of wounds does need to be simplified in some way so that the mod doesnt need a super complex logic system that massively impacts the server performance.  

### Wound Levels
To solve this, we assign a "Wound Level" to each type and size of ACE Wound, via the CBA settings, and use the amount of each "Wound Level" rather than the wounds themselves. 
There are 5 Wound Levels within BAL: Ignored, Minor, Major, Critical, Catastrophic.  
The amount of wounds per "Wound Level" is then simplified further into a single value called the 'Leg Wound Level', which practically uses the same 5 levels as the 'Wound Levels'.   
This is done in one of two ways, depending on if "Stackable Wounds" is enabled in the CBA settings or not.   

If "Stackable Wounds" is disabled, then it simply finds the highest Wound Level that is present and sets the 'Leg State' to be that level, regardless of if there is more than one of any type.  
> The players left leg has 3 Medium Avulsions and 1 Large Avulsion.   
> A Medium Avulsions is set to be a "Minor" wound, while a Large Avulsion is set to be a "Major" wound.   
> Therefore, the players left 'Leg Wound Level' is considered to be "Major". 

For Body Wounds, we use the pre-existing threshold levels used by the ACE medical menu to determine the severity of the Wound.
This allows the player to see the current state of their Body Wounds via the ACE medical menu, which lets the mod feel consistant. 
For example, Pain is split into 4 levels: No Pain, Mild Pain, Moderate Pain, Severe Pain. 

### Incapacitation Logic
Now that the damage states of each leg and the body has been calculated, we can determine if the player should be incapacitated or not. 
To simplfy it, the more wounded one part of your body is, the less wounded the rest of your body needs to be in order to become incapacitated.
However, by default, both legs need to be wounded to atleast a Minor level in order for the player to become incapacitated, with one exception. 

If anything has been damaged to a "Catastrophic" level, the player will become incapacitated, regardless of how wounded they are elsewhere on their body.  
If one leg has been damaged to a "Critical" level, and the other has been damaged to atleast a "Minor" level, then player will become incapacitated.  
If the player still isnt incapacitated, then it checks to see if both legs have atleast "Major" damage done to them, and if so incapacitates them.  
If not, it will do one final check to see if both legs have taken "Minor" levels of damage, and there are alteast "Minor" Body Wounds present.   

It should be noted that damage levels do scale downwards, so a "Critical" wound on one leg and a "Major" on the other would satisfy both the second and third critera.   
Similarly, Body Wounds can be used as a subsitute for higher level leg wounds, however this only matters if you disable the requirement for both legs to be wounded.   

### Stackable Wounds  
The Stackable Wounds system makes it so that multiple Wounds of the same Wound Level, or higher, need to be stacked together in order to incapacitate the player.  
It counts how many wounds per Wound Level are present on the leg, including when there are multiple of the same size and type of wound.  
Then it checks if the amount of Critical Wounds is greater than or equal to the "Critical Wound Incapacitation Amount", and if there is 'Leg Wound Level' is considered to be "Critical".   
If there is not enough then it then repeats the process for Major PLUS Critical Wounds, and compares it "Major Wound Incapacitation Amount".  
Assuming there isnt enough, it will then check "Minor Wound Incapacitation Amount" against the sum of Minor, Major and Critial Wounds.  
> The players left leg has 3 Medium Avulsions and 1 Large Avulsion.   
> A Medium Avulsions is set to be a "Minor" wound, while a Large Avulsion is set to be a "Major" wound.   
> The player has 0 Critical Wounds and the "Critical Wound Incapacitation Amount" is set to 1, so their Major Wounds need to be checked.   
> The player has 1 Major Wound and the "Major Wound Incapacitation Amount" is set to 2, so their Minor Wounds need to be checked.   
> The player has 4 Minor Wounds and the "Minor Wound Incapacitation Amount" is set to 4.  
> Therefore, the players left 'Left Leg Wound Level' is considered to be "Minor".  

This system also works for Body Wounds, though with a few minor changes. 

### Credits 
Raoden/superjes1, the programmer behind this mod!  
The ACE team, for making a killer mod and documenting the hell out of it!  
Spartan & Forest, the creators of [AWR](https://steamcommunity.com/sharedfiles/filedetails/?id=2894821376) who inspired the creation of this mod  
BloodyMystik, for providing me with an invaluable source of knowledge which made this mod possible.   

Abstract, leader of WCF, for the idea behind the mod, commissioning the mod and for helping with this description.  
[WCF](https://discord.gg/DkzPWhNn8V), for thoroughly testing the mod and finding bugs that I wouldnt have found in a million years.    
And you, for scrolling all the way down here and actually reading the credits!
