["BAL_Full_Toggle", "CHECKBOX", ["Enable BAL", "Completely turn disable/enable BAL. This overrides literally everything."], "Break A Leg", true, 1] call CBA_fnc_addSetting;
["BAL_Ragdoll_Toggle", "CHECKBOX", ["Secondary Ragdoll Toggle", "Toggles if the player should be ragdolled when they attempt to get up while incapacitated"], "Break A Leg", true, 1] call CBA_fnc_addSetting;

//Clientsides
["BAL_IncapacitationTitle_Toggle", "CHECKBOX", ["Enable Incapacitation Title", "Enables a massive text that comes up in the middle of your screen if you try to get up while incapacitated"], ["Break A Leg","Clientside"], false] call CBA_fnc_addSetting;
["BAL_IncapacitationTitle_Cooldown", "TIME",     ["Incapacitation Alert Cooldown","The cooldown in seconds for the alert when you try to get up while Incapacitated."], ["Break A Leg","Clientside"], [1, 10, 3]] call CBA_fnc_addSetting;
["BAL_IncapacitationTitle_Reason", "LIST", ["Incapacitation Reason", "Sets how much information the player should be given when they are incapacitated"], ["Break A Leg","Clientside"], [[0, 1, 2], ["None","Simple","Complex"], 1]] call CBA_fnc_addSetting;

//"Global" Logic 
["BAL_BothLegsWounded_Toggle", "CHECKBOX", ["Require Both Legs to be wounded?", "Toggle if both legs have to be wounded for an incapacitation to occur?"], ["Break A Leg","Logic"], true, 1] call CBA_fnc_addSetting;
["BAL_BothLegsWounded_IncapacitateBypass", "CHECKBOX", ["'Catastrophic' Both Legs Toggle", "Enables/Disables if both legs have to be wounded for an incapacitation based on an 'Catastrophic' level wound to occur.\nEnabling this will mean that only 1 leg needs to be wounded."], ["Break A Leg","Logic"], true, 1] call CBA_fnc_addSetting;

[] call compile preprocessFileLineNumbers '\bal_main\addon_settings_wounds.sqf';
[] call compile preprocessFileLineNumbers '\bal_main\addon_settings_body.sqf';

//Debug
["BAL_Debug_Toggle", "CHECKBOX", ["Toggle Debug RPT Logs", ""], ["Break A Leg","zDebug"], true] call CBA_fnc_addSetting;