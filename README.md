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

This is further expanded when pain, bleed rate and blood loss are factored in. If the player is in enough pain, is bleeding too quickly and/or has lost too much blood, the player can be incapacitated even if the wounds on their legs would otherwise be insufficient to incapacitate them.
These 3 factors are commonly referred to as "Body Wounds", as they represent wounds across the entire body, rather than just one part/limb.
Body Wounds are also a requirement for the last of way that players can be incapacitated, which occurs when both legs have enough 'Minor' wounds as well as some 'Minor' Body Wounds.

## How does it work?
When checking if a player should be incapacitated, BAL uses the list of wounds on each leg (As well as their Body Wounds) that the player sees in the ACE medical menu, rather than the amount of damage that those wounds represent.   
This allows the players to directly see what is causing them to be incapacitated, and gives much more control over what wound types are considered in the calculation, and how impactful they are.   
However, that list of wounds does need to be simplified in some way so that the mod doesnt need a super complex logic system that massively impacts the server performance.  

### Wound Levels
To solve this, we assign a "Wound Level" to each type and size of ACE Wound, via the CBA settings, and use the amount of each "Wound Level" rather than the wounds themselves. There are 5 Wound Levels within BAL: Ignored, Minor, Major, Critical, Catastrophic.  
The amount of wounds per "Wound Level" is then simplified further into a single value called the 'Leg Wound Level', which practically uses the same 5 levels as the 'Wound Levels'.   
This is done in one of two ways, depending on if "Stackable Wounds" is enabled in the CBA settings or not.   

If "Stackable Wounds" is disabled, then it simply finds the highest Wound Level that is present and sets the 'Leg State' to be that level, regardless of if there is more than one of any type.  
> The players left leg has 3 Medium Avulsions and 1 Large Avulsion.   
> A Medium Avulsions is set to be a "Minor" wound, while a Large Avulsion is set to be a "Major" wound.   
> Therefore, the players left 'Leg Wound Level' is considered to be "Major". 

However, if "Stackable Wounds" is enabled, then the amount of Wound Level does actually matter. 
  
  
  
  
###------------- Text Graveyard   ---------------------
BALs internal logic uses 3 variables, one for each leg and one for the body, to decide if the player should be incapacitated or not. They represent the total serverity of the wounds in that area, and are called the 'Leg State' and 'Body State' respecitevly.  
As you can probably guess, these States are calculated using the 


### What are the Incapaciation Criteria? 
A player will be incapacitated when atleast one of 4 criteria are met. 



As previously mentioned, a player will become incapacitated when their leg wounds and/or body wounds are at high enough levels to satisy one of the 4 incapacitation critera. 


Whenever a player is wounded, BAL first checks if either, or both, of their legs have been wounded. 

If so, BAL will then create a list of all of the unbandaged *and bandgaed* ACE wounds on the leg that was wounded and assigns each wound with its corrasponding "Wound Level"
Each combination of size and type (Avulsion, Velocity Wound, Bruise ect.) of ACE wound is assigned one of 5 "Wound Levels" (Ignored, Minor, Major, Critical, Catastrophic) via the CBA settings.
E.G. A Small Avulsion can be set to "Ignored", a Mediunm Avulsion can be set to "Minor" wound and a Large Avulsion can be a "Major" wound. 
It then *finds the wound with the highest assigned "Wound Level" (Assuming "Stackable Wounds" isnt enabled, which needs its own section)* and then saves the "Leg State" of that leg to that Wound Level. 
E.G. If the left leg has a Large Avulsion, then its "Wound Level" is set to be "Major" regardless how many other "Major" (or below) wounds the leg has. 

It then gets the "Leg State" of each leg, using the saved one if one of the legs werent wounded, *as well as the "Body State"*.
as well as some factors that effect the entire body like pain, and then runs some logic to determine if the player should be incapacitated.

If they should be incapacitated, the player will then fall over, scream out in pain and will be unable to get back up until their wounds have been healed.  
If the player attempts to stand up before their wounds are healed, they will simply fall back down onto the ground. 

## Wound Levels
Break A Leg relies on a 5 tiered "Wound Level" system in order to determine how wounded the player is, rather than the somewhat arbitrary damage thresholds like the rest of ACE or AWR. 
Each combination of size and type (Avulsion, Velocity Wound, Bruise ect.) of ACE wound is assigned one of 5 "Wound Levels" (Ignored, Minor, Major, Critical, Catastrophic) via the CBA settings. which BAL uses to determine how wounded each leg is, and if the wounds are sufficent enough to incapacitate the player. 

MOVE TO THE "LONG" EXPLANATION:
BAL uses two main systems in order to check if the player should be incapacitated, and to apply the incap
The first handles the players legs, and is only activated when one of the players legs are wounded or treated. This system is more performance intensive, so it is used sparingly so that we dont lag out the players/server.
###----------------------------------

### Credits 
Raoden/superjes1, the programmer behind this mod!  
The ACE team, for making a killer mod and documenting the hell out of it!  
Spartan & Forest, the creators of [AWR](https://steamcommunity.com/sharedfiles/filedetails/?id=2894821376) who inspired the creation of this mod  
BloodyMystik, for providing me with an invaluable source of knowledge which made this mod possible.   

Abstract, leader of WCF, for the idea behind the mod, commissioning the mod and for helping with this description.  
[WCF](https://discord.gg/DkzPWhNn8V), for thoroughly testing the mod and finding bugs that I wouldnt have found in a million years.   
Smokey__rr, for thinking of the name.   
And you, for scrolling all the way down here and actually reading the credits!
