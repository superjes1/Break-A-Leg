#include "script_macros.hpp"

_this params ["_unit","_incapacitate"];

//If the unit isnt incapacitated but should be, incapacitate them.
if (!(_unit getVariable ["BAL_isIncapacitated", false]) && (_incapacitate)) then {
	
	//This probably needs some more fine tuning in regards to how loud it is, and how far away it can be heard. 
	playSound3D ["z\ace\addons\medical_feedback\sounds\fracture_2.wav",player,false, getPosASL player, 1, 1, 50];

	//If they are in a vehicle, the animation stuff looks/reacts really weird. So make sure they arent in a vehicle before doing it all.
	if (vehicle _unit == _unit) then {
		[_unit, true] call ACEFUNC(medical_engine,setUnconsciousAnim);

		[_unit] call ACEFUNC(common,setProne);

		_unit setVariable ["BAL_Cooldown", (serverTime + 2)];
		[{[_this, false] call ACEFUNC(medical_engine,setUnconsciousAnim)},_unit,2] call CBA_fnc_waitAndExecute;
	} else {
		//Give them an alert so that they know they are incapacitated.
		[["bal_main\UI\broken_bone.paa",2, [255,0,0],true],["You are Incapacitated"]] call CBA_fnc_notify;
		playSound ["Hint",true];	
	};
	_unit setVariable ["BAL_isIncapacitated", true];
};

//If the unit is incapacitated but shouldnt be, un-incapacitate them.
if ((_unit getVariable ["BAL_isIncapacitated", false]) && !(_incapacitate)) then {

	_unit setVariable ["BAL_isIncapacitated", false];

};