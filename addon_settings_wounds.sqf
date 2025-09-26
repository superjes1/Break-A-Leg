//Fractures.
["BAL_Fracture", "LIST", ["Fractures","Set the wound level of Fractures"], ["Break A Leg - Leg Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 4],1] call CBA_fnc_addSetting;

//Stackable Unbandaged Wounds
["BAL_StackLeg_Toggle", "CHECKBOX", ["Stackable Unbandaged Leg Wounds Toggle", "Toggles if Unbandaged Leg Wounds are Stackable"], ["Break A Leg - Leg Wounds",".Unbandaged Stackable Wounds"], true, 1] call CBA_fnc_addSetting;
["BAL_StackLeg_Minor", "EDITBOX",  ["Minor Wound Incapacitation Amount", "How many Unbandaged Minor Leg Wounds are required for it to be considered as a 'Minor' damage to that leg"], ["Break A Leg - Leg Wounds",".Unbandaged Stackable Wounds"],"4",1] call CBA_fnc_addSetting;
["BAL_StackLeg_Major", "EDITBOX",  ["Major Wound Incapacitation Amount", "How many Unbandaged Major Leg Wounds are required for it to be considered as a 'Major' damage to that leg"],["Break A Leg - Leg Wounds",".Unbandaged Stackable Wounds"],"2",1] call CBA_fnc_addSetting;
["BAL_StackLeg_Critical", "EDITBOX",  ["Critical Wound Incapacitation Amount", "How many Unbandaged Critical Leg Wounds are required for it to be considered as a 'Critical' damage to that leg"], ["Break A Leg - Leg Wounds",".Unbandaged Stackable Wounds"],"1",1] call CBA_fnc_addSetting;

//Stackable Bandaged Wounds
["BAL_StackBandage_Toggle", "CHECKBOX", ["Stackable Bandaged Leg Wounds Toggle", "Toggles if Bandaged Leg Wounds are Stackable"], ["Break A Leg - Leg Wounds",".Bandaged Stackable Wounds"], false, 1] call CBA_fnc_addSetting;
["BAL_StackBandage_Minor", "EDITBOX",  ["Minor Wound Incapacitation Amount", "How many Bandaged Minor Leg Wounds are required for it to be considered as a 'Minor' damage to that leg"], ["Break A Leg - Leg Wounds",".Bandaged Stackable Wounds"],"6",1] call CBA_fnc_addSetting;
["BAL_StackBandage_Major", "EDITBOX",  ["Major Wound Incapacitation Amount", "How many Bandaged Major Leg Wounds are required for it to be considered as a 'Major' damage to that leg"],["Break A Leg - Leg Wounds",".Bandaged Stackable Wounds"],"4",1] call CBA_fnc_addSetting;
["BAL_StackBandage_Critical", "EDITBOX",  ["Critical Wound Incapacitation Amount", "How many Bandaged Critical Leg Wounds are required for it to be considered as a 'Critical' damage to that leg"], ["Break A Leg - Leg Wounds",".Bandaged Stackable Wounds"],"2",1] call CBA_fnc_addSetting;

//-----------------
// ACE Wound Types
//-----------------
/*
"Abrasion"
"Avulsion"
"Contusion"
"Crush"
"Cut"
"Laceration"
"VelocityWound"
"PunctureWound"
"ThermalBurn"
*/

//Aburasions/Scrapes
["BAL_Abrasion_Toggle", "CHECKBOX", ["Toggle Scrapes", "Enables/Disables if Scrapes should be considered in Leg Wound Imobalisation Logic. This overrides the other Scrapes settings."], ["Break A Leg - Leg Wounds","Scrapes"], false, 1] call CBA_fnc_addSetting;
["BAL_Abrasion_Small", "LIST", ["Small Scrapes","Set the wound level of Small Scrapes"], ["Break A Leg - Leg Wounds","Scrapes"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Abrasion_Med", "LIST", ["Medium Scrapes","Set the wound level of Medium Scrapes"], ["Break A Leg - Leg Wounds","Scrapes"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Abrasion_Large", "LIST", ["Large Scrapes","Set the wound level of Large Scrapes"], ["Break A Leg - Leg Wounds","Scrapes"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;

//Avulsions
["BAL_Avulsion_Toggle", "CHECKBOX", ["Toggle Avulsions", "Enables/Disables if Avulsions should be considered in Leg Wound Imobalisation Logic. This overrides the other Avulsion settings."], ["Break A Leg - Leg Wounds","Avulsions"], true, 1] call CBA_fnc_addSetting;
["BAL_Avulsion_Small", "LIST", ["Small Avulsions","Set the wound level of Small Avulsions"], ["Break A Leg - Leg Wounds","Avulsions"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Avulsion_Med", "LIST", ["Medium Avulsions","Set the wound level of Medium Avulsions"], ["Break A Leg - Leg Wounds","Avulsions"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_Avulsion_Large", "LIST", ["Large Avulsions","Set the wound level of Large Avulsions"], ["Break A Leg - Leg Wounds","Avulsions"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;

//Contusions/Bruises
["BAL_Contusion_Toggle", "CHECKBOX", ["Toggle Bruises", "Enables/Disables if Bruises should be considered in Leg Wound Imobalisation Logic. This overrides the other Bruise settings."], ["Break A Leg - Leg Wounds","Bruises"], false, 1] call CBA_fnc_addSetting;
["BAL_Contusion_Small", "LIST", ["Small Bruises","Set the wound level of Small Bruises"], ["Break A Leg - Leg Wounds","Bruises"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Contusion_Med", "LIST", ["Medium Bruises","Set the wound level of Medium Bruises"], ["Break A Leg - Leg Wounds","Bruises"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Contusion_Large", "LIST", ["Large Bruises","Set the wound level of Large Bruises"], ["Break A Leg - Leg Wounds","Bruises"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;

//Crush
["BAL_Crush_Toggle", "CHECKBOX", ["Toggle Crushed Tissue", "Enables/Disables if Crushed Tissue should be considered in Leg Wound Imobalisation Logic. This overrides the other Crushed Tissue settings."], ["Break A Leg - Leg Wounds","Crushed Tissue"], false, 1] call CBA_fnc_addSetting;
["BAL_Crush_Small", "LIST", ["Small Crushed Tissue","Set the wound level of Small Crushed Tissue"], ["Break A Leg - Leg Wounds","Crushed Tissue"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Crush_Med", "LIST", ["Medium Crushed Tissue","Set the wound level of Medium Crushed Tissue"], ["Break A Leg - Leg Wounds","Crushed Tissue"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Crush_Large", "LIST", ["Large Crushed Tissue","Set the wound level of Large Crushed Tissue"], ["Break A Leg - Leg Wounds","Crushed Tissue"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;

//Cuts
["BAL_Cut_Toggle", "CHECKBOX", ["Toggle Cuts", "Enables/Disables if Cuts should be considered in Leg Wound Imobalisation Logic. This overrides the other Cut settings."], ["Break A Leg - Leg Wounds","Cuts"], false, 1] call CBA_fnc_addSetting;
["BAL_Cut_Small", "LIST", ["Small Cuts","Set the wound level of Small Cuts"], ["Break A Leg - Leg Wounds","Cuts"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Cut_Med", "LIST", ["Medium Cuts","Set the wound level of Medium Cuts"], ["Break A Leg - Leg Wounds","Cuts"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Cut_Large", "LIST", ["Large Cuts","Set the wound level of Large Cuts"], ["Break A Leg - Leg Wounds","Cuts"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;

//Lacerations/Tears
["BAL_Laceration_Toggle", "CHECKBOX", ["Toggle Tears", "Enables/Disables if Tears should be considered in Leg Wound Imobalisation Logic. This overrides the other Tears settings."], ["Break A Leg - Leg Wounds","Tears"], false, 1] call CBA_fnc_addSetting;
["BAL_Laceration_Small", "LIST", ["Small Tears","Set the wound level of Small Tears"], ["Break A Leg - Leg Wounds","Tears"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Laceration_Med", "LIST", ["Medium Tears","Set the wound level of Medium Tears"], ["Break A Leg - Leg Wounds","Tears"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_Laceration_Large", "LIST", ["Large Tears","Set the wound level of Large Tears"], ["Break A Leg - Leg Wounds","Tears"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;

//Velocity Wounds
["BAL_VelocityWound_Toggle", "CHECKBOX", ["Toggle Velocity Wounds", "Enables/Disables if Velocity Wounds should be considered in Leg Wound Imobalisation Logic. This overrides the other Velocity Wound settings."], ["Break A Leg - Leg Wounds","Velocity Wounds"], true, 1] call CBA_fnc_addSetting;
["BAL_VelocityWound_Small", "LIST", ["Small Velocity Wounds","Set the wound level of Small Velocity Wounds"], ["Break A Leg - Leg Wounds","Velocity Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_VelocityWound_Med", "LIST", ["Medium Velocity Wounds","Set the wound level of Medium Velocity Wounds"], ["Break A Leg - Leg Wounds","Velocity Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_VelocityWound_Large", "LIST", ["Large Velocity Wounds","Set the wound level of Large Velocity Wounds"], ["Break A Leg - Leg Wounds","Velocity Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;

//Puncture Wounds
["BAL_PunctureWound_Toggle", "CHECKBOX", ["Toggle Puncture Wounds", "Enables/Disables if Puncture Wounds should be considered in Leg Wound Imobalisation Logic. This overrides the other Puncture Wound settings."], ["Break A Leg - Leg Wounds","Puncture Wounds"], true, 1] call CBA_fnc_addSetting;
["BAL_PunctureWound_Small", "LIST", ["Small Puncture Wounds","Set the wound level of Small Puncture Wounds"], ["Break A Leg - Leg Wounds","Puncture Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_PunctureWound_Med", "LIST", ["Medium Puncture Wounds","Set the wound level of Medium Puncture Wounds"], ["Break A Leg - Leg Wounds","Puncture Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;
["BAL_PunctureWound_Large", "LIST", ["Large Puncture Wounds","Set the wound level of Large Puncture Wounds"], ["Break A Leg - Leg Wounds","Puncture Wounds"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 2],1] call CBA_fnc_addSetting;

//Burns
["BAL_ThermalBurn_Toggle", "CHECKBOX", ["Toggle Thermal Burns", "Enables/Disables if Thermal Burns should be considered in Leg Wound Imobalisation Logic. This overrides the other Thermal Burn settings."], ["Break A Leg - Leg Wounds","Thermal Burns"], false, 1] call CBA_fnc_addSetting;
["BAL_ThermalBurn_Small", "LIST", ["Small Thermal Burns","Set the wound level of Small Thermal Burns"], ["Break A Leg - Leg Wounds","Thermal Burns"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_ThermalBurn_Med", "LIST", ["Medium Thermal Burns","Set the wound level of Medium Thermal Burns"], ["Break A Leg - Leg Wounds","Thermal Burns"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 0],1] call CBA_fnc_addSetting;
["BAL_ThermalBurn_Large", "LIST", ["Large Thermal Burns","Set the wound level of Large Thermal Burns"], ["Break A Leg - Leg Wounds","Thermal Burns"], [[0, 1, 2, 3, 4], ["Ignored","Minor","Major","Critical","Catastrophic"], 1],1] call CBA_fnc_addSetting;



