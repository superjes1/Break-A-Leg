//Stackable Body Wounds
["BAL_StackBody_Toggle", "CHECKBOX", ["Stackable Body Wounds Toggle", "Toggles if Body Wounds are Stackable"], ["Break A Leg - Body Wounds","Stackable Wounds"], true, 1] call CBA_fnc_addSetting;
["BAL_StackBody_Minor", "SLIDER",  ["Minor Wound Incapacitation Amount", "How many Minor Body Wounds are required for it to be considered as a 'Minor' body damage"], ["Break A Leg - Body Wounds","Stackable Wounds"], [0, 3, 3, 0],1] call CBA_fnc_addSetting;
["BAL_StackBody_Major", "SLIDER",  ["Major Wound Incapacitation Amount", "How many Major Body Wounds are required for it to be considered as a 'Major' body damage"],["Break A Leg - Body Wounds","Stackable Wounds"], [0, 3, 2, 0],1] call CBA_fnc_addSetting;
["BAL_StackBody_Critical", "SLIDER",  ["Critical Wound Incapacitation Amount", "How many Critical Body Wounds are required for it to be considered as a 'Critical' body damage"], ["Break A Leg - Body Wounds","Stackable Wounds"], [0, 3, 1, 0],1] call CBA_fnc_addSetting;

//Pain
["BAL_Pain_Toggle", "CHECKBOX", ["Pain Toggle", "Enables/Disables if Pain is considered in Imobalisation Logic."], ["Break A Leg - Body Wounds","Pain"], true, 1] call CBA_fnc_addSetting;
["BAL_Pain_Low", "LIST", ["Mild Pain", "Equivelent to 'In Mild Pain'"], ["Break A Leg - Body Wounds","Pain"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_Pain_Moderate", "LIST", ["Moderate Pain","Equivelent to 'In Pain'"], ["Break A Leg - Body Wounds","Pain"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;
["BAL_Pain_Severe", "LIST", ["Severe Pain","Equivelent to 'In Severe Pain'"], ["Break A Leg - Body Wounds","Pain"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 3],1] call CBA_fnc_addSetting;

//Bleeding
["BAL_Bleeding_Toggle", "CHECKBOX", ["Bleeding Toggle", "Enables/Disables if Bleeding is considered in Imobalisation Logic."], ["Break A Leg - Body Wounds","Bleeding"], true, 1] call CBA_fnc_addSetting;
["BAL_Bleeding_Low", "LIST", ["Slow Bleeding","Set the wound level of Slow Bleeding"], ["Break A Leg - Body Wounds","Bleeding"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_Bleeding_Moderate", "LIST", ["Moderate Bleeding","Set the wound level of Moderate Bleeding"], ["Break A Leg - Body Wounds","Bleeding"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;
["BAL_Bleeding_Severe", "LIST", ["Severe Bleeding","Set the wound level of Severe Bleeding"], ["Break A Leg - Body Wounds","Bleeding"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 3],1] call CBA_fnc_addSetting;
["BAL_Bleeding_Massive", "LIST", ["Massive Bleeding","Set the wound level of Massive Bleeding"], ["Break A Leg - Body Wounds","Bleeding"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 4],1] call CBA_fnc_addSetting;

//Bloodloss
["BAL_Bloodloss_Toggle", "CHECKBOX", ["Bloodloss Toggle", "Enables/Disables if Bloodloss is considered in Imobalisation Logic."], ["Break A Leg - Body Wounds","Bloodloss"], true, 1] call CBA_fnc_addSetting;
["BAL_Bloodloss_Low", "LIST", ["Low Bloodloss","Equivelent to 'Lost some Blood'"], ["Break A Leg - Body Wounds","Bloodloss"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Bloodloss_Moderate", "LIST", ["Moderate Bloodloss","Equivelent to 'Lost a lot of Blood'"], ["Break A Leg - Body Wounds","Bloodloss"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_Bloodloss_Severe", "LIST", ["Severe Bloodloss","Equivelent to 'Lost a large amount of Blood'"], ["Break A Leg - Body Wounds","Bloodloss"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;
["BAL_Bloodloss_Massive", "LIST", ["Massive Bloodloss","Equivelent to 'Lost a fatal amount of Blood'"], ["Break A Leg - Body Wounds","Bloodloss"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 3],1] call CBA_fnc_addSetting;