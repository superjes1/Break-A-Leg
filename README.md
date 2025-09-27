## Break A Leg
Break A Leg adds a proper immobilisation system into Arma using the ACE medical framework.

What does this mean?

More or less, when you get shot in your legs enough, you won't be able to stand back up until you heal your wounds. 
Think of it as a more active ACE Unconscious state, you can still communicate and shoot back, but moving anywhere quickly is no longer an option.

### Features! 
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

## How does it work? | The Medium Version
### The basics
*If something is in Italics, it means that there is a CBA setting to enable/disable it.*

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

### Wound Levels
Rather than use a threshold system like ACE, BAL relies on a 5 tiered "Wound Level" system in order to determine how wounded the player is.
Each type and size of ACE wound is assigned one of these 5 levels, through the CBA settings, which BAL uses to determine how wounded each leg is, and if the wounds are sufficent enough to incapacitate the player. 

### Stackable Wounds

### Body State

MOVE TO THE "LONG" EXPLANATION:
BAL uses two main systems in order to check if the player should be incapacitated, and to apply the incap
The first handles the players legs, and is only activated when one of the players legs are wounded or treated. This system is more performance intensive, so it is used sparingly so that we dont lag out the players/server.


### Credits 
Raoden/superjes1, the programmer behind this mod!  
The ACE team, for making a killer mod and documenting the hell out of it!  
Spartan & Forest, the creators of [AWR](https://steamcommunity.com/sharedfiles/filedetails/?id=2894821376) who inspired the creation of this mod  
BloodyMystik, for providing me with an invaluable source of knowledge which made this mod possible.   

Abstract, leader of WCF, for the idea behind the mod, commissioning the mod and for helping with this description.  
[WCF](https://discord.gg/DkzPWhNn8V), for thoroughly testing the mod and finding bugs that I wouldnt have found in a million years.   
Smokey__rr, for thinking of the name.   
And you, for scrolling all the way down here and actually reading the credits!
