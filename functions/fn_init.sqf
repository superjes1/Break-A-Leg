// Some of the events are local to the players client, so I cant just run everything on the server.
// What I should do is have the events on the players clients, send the data from those events to the server and process it, then send it back to the players client.
// But, That would take a long time to do, and I have tried to made the rest of the code light weight enough that it wont be nessesary.
//if  !(hasInterface && isServer) then {
//if (isDedicated || (hasInterface && isServer)) then {

    if (BAL_Debug_Toggle) then {
        diag_log "[BAL] Init Script Loaded";
    };

    #include "script_macros.hpp"

    //Checks if the unit is incapacitated, but not prone.
    //As much as I dont like it, this seems to be the only way to do it.
    //Detecting if the player presses a button to unprone is very difficult to do, for some fking reason.
    //There might be a way, but unless there is a noticable performance loss from this method, it isnt worth the time. 
    ["ace_medical_handleUnitVitals", {
        _unit = _this select 0;
        //Checks if the unit is a player. 
        if (BAL_Full_Toggle && (alive _unit && isPlayer _unit && _unit == player)) then {
            //The false here isnt checking if its false, its the default. 
            if ((_unit getVariable ["BAL_isIncapacitated", false]) && (vehicle _unit == _unit) && (!(stance _unit == "PRONE") && ((pose _unit) in ["Crouch","Combat","HandGunStand","Stand","HandGunCrouch","Weapon","BinocStand","Binoc","NoWeapon"]))) then {
                //This provides a backup check for things like blood or pain, which can change without it being caught by my event handlers.
                //The script it runs is very quick, so it will not have a noticable impact on performance, even if it is spammed. 
                _status = [_unit] call BAL_fnc_shouldIncapacitate;
                if (_status) then {

                    //This stops an edge case where people would be stuck unable to medic themselves while prone with a launcher out. 
                    if (!("" == secondaryWeapon _unit) && (currentWeapon _unit == secondaryWeapon _unit)) then {
                        _unit action ["SWITCHWEAPON",_unit,_unit,1];
                    };

                    if (BAL_Ragdoll_Toggle) then {
                        [_unit, true] call ACEFUNC(medical_engine,setUnconsciousAnim);
                        [{[_this, false] call ACEFUNC(medical_engine,setUnconsciousAnim)},_unit,2] call CBA_fnc_waitAndExecute;
                    };

                    [_unit] call ACEFUNC(common,setProne);
                    [_unit] remoteExec ["BAL_fnc_setTitle",_unit];

                } else {
                    _unit setVariable ["BAL_isIncapacitated", false];
                };
            };
        };
    }] call CBA_fnc_addEventHandler;

    //Use this event to cover all treatment methods, and then filter out which ones we want, instead of having 3-4 different events for each type of treatment. 
    //3-4 different event types is likely better for performance, but this is supposed to be temporary for workshoping/testing. 
    ["ace_treatmentSucceded",{
        //Checks if the unit is a player.
        _unit = _this select 1;
        if (BAL_Full_Toggle && (alive _unit && isPlayer _unit && _unit == player)) then {
            if (BAL_Debug_Toggle) then {
                diag_log format ["[BAL] Treatment Succeded | Wound Healed: %1",_this select 2];
            };
            _mainWound = toLower (_this select 2);
            
            //Gets the new state of the wounded leg, and the old state of the other
            _legStatus = [_unit,_mainWound] call BAL_fnc_getLegState;
            _legStatus params ["_leftStatus","_rightStatus"];

            //Checks if the unit should be incapacitated, and incapacitates them if so. 
            //Also gets the "body" state during this, as it isnt saved.
            _incapacitate = [_unit,_leftStatus,_rightStatus] call BAL_fnc_shouldIncapacitate;

            //Apply the incapacition state to the unit.
            //This is done in its own seperate file so it is easier for other modules to intergrate into this one.
            [_unit,_incapacitate] call BAL_fnc_applyIncapacitation;
        };
    }] call CBA_fnc_addEventHandler;

    //The exception to this is a full heal through Zues or a module.
    //It has to be handled seperately, as the "treatmentSucceded" event isnt fired.
    //This also means that any mods/modules that attempts to do a full heal without using the ACE command for it will be ignored.
    //This is an unfortunate, but acceptable, side effect. 
    ["ace_medical_treatment_fullHealLocalMod",{
        if (BAL_Full_Toggle) then {
            if (BAL_Debug_Toggle) then {
                diag_log "[BAL] Full Heal";
            };
            player setVariable ["BAL_leftStatus", 0];
            player setVariable ["BAL_rightStatus", 0];
            player setVariable ["BAL_isIncapacitated", false];
            player setVariable ["BAL_bodyStatus",[0,[0,0,0]]];
            player setVariable ["BAL_reason",0];
        };
    }] call CBA_fnc_addEventHandler;

    //For some reason, if a player dies a certain way, then the variables assigned to them wont be reset like normal.
    //This forces it to be reset no matter what, so that incapacitation wont carry over through death.
    //As this script is ran at Init, before the player as been initialised, we need to use a wait until and execute for it to work. 
    [{not isNull player},{
        [player, "Respawn", {
            if (BAL_Full_Toggle) then {
                player setVariable ["BAL_leftStatus", 0];
                player setVariable ["BAL_rightStatus", 0];
                player setVariable ["BAL_isIncapacitated", false];
                player setVariable ["BAL_bodyStatus",[0,[0,0,0]]];
                player setVariable ["BAL_reason",0];
            };
        }] call CBA_fnc_addBISEventHandler;
    }] call CBA_fnc_waitUntilAndExecute;

    //Detects when a wound is received
    [QACEVAR(medical,woundReceived), {
        //Checks if the unit is a player.
        _unit = _this select 0;
        if (BAL_Full_Toggle) then {
            if (isPlayer _unit && _unit == player) then {
                if (alive _unit) then {
                    _mainWound = "none";
                    _incapacitate = false;
                    _limbs = [];
                    {
                        //ignore structural damage, as it doesnt mean anything
                        if (_x select 1 == "#structural") then {continue;};
                        //If the amount of damage the limb took is 0, then there are no more wounded limbs to check, so stop checking.
                        if (_x select 0 == 0) then {break};
                        //Simplify my job so that the form is the same no matter what
                        _limb = toLower (_x select 1);
                        //Now we can get to the good bit. Check if the limb name has "leg" in it. 
                        if ("leg" in _limb) then {
                            //If so, then add it to the lists of limbs to check.
                            _limbs pushback _limb;
                        };
                    }foreach (_this select 1); //Does each limb

                    if (BAL_Debug_Toggle) then {
                        diag_log format ["[BAL] Wound Received | Wounded Limbs: %1",_limbs];
                    };

                    //Make sure that one of the limbs we care about was damaged before trying to check them.
                    if !(count _limbs == 0) then {
                        //If both limbs are wounded, set it so both limbs will be checked
                        if (count _limbs == 2) then {_mainWound = "all";} else {_mainWound = (_limbs select 0)};
                        //Gets the new state of the wounded leg, and the old state of the other
                        _legStatus = [_unit,_mainWound] call BAL_fnc_getLegState;
                        _legStatus params ["_leftStatus","_rightStatus"];

                        //Checks if the unit should be incapacitated, and incapacitates them if so. 
                        //Also gets the "body" state during this, as it isnt saved.
                        _incapacitate = [_unit,_leftStatus,_rightStatus] call BAL_fnc_shouldIncapacitate;
                    } else {
                        //We still need to check this incase the pain is enough to incapacitate them. 
                        //It will just use the last known leg state for both, without needing to check for it
                        _incapacitate = [_unit,-1,-1] call BAL_fnc_shouldIncapacitate;
                    };

                    //Apply the incapacition state to the unit.
                    //This is done in its own seperate file so it is easier for other modules to intergrate into this one.
                    [_unit,_incapacitate] call BAL_fnc_applyIncapacitation;
                } else {
                    _unit setVariable ["BAL_leftStatus", 0];
                    _unit setVariable ["BAL_rightStatus", 0];
                    _unit setVariable ["BAL_isIncapacitated", false];
                };
            };
        };
    }] call CBA_fnc_addEventHandler;

//};