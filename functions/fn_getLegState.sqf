#include "script_macros.hpp"

_sortWoundType = {
	_woundLevel = 0;
	_this params ["_woundClassID"];

	private _classIndex = floor (_woundClassID / 10);
	_toggle = false;
	_array = [0,0,0];
	//Hardcoding it like this isnt great.
	//However, I cant find anyway to dynamically create the variable name that doesnt result in it being stuck as a string.
	//And this is the fastest method out of the hardcoded ones that I could find. 
	//So this is what I have to work with. 
	switch (_classIndex) do
	{
		case 0: {_toggle =  BAL_Abrasion_Toggle; _array = [BAL_Abrasion_Small,BAL_Abrasion_Med,BAL_Abrasion_Large]};
		case 1: {_toggle =  BAL_Avulsion_Toggle; _array = [BAL_Avulsion_Small,BAL_Avulsion_Med,BAL_Avulsion_Large]};
		case 2: {_toggle =  BAL_Contusion_Toggle; _array = [BAL_Contusion_Small,BAL_Contusion_Med,BAL_Contusion_Large]};
		case 3: {_toggle =  BAL_Crush_Toggle; _array = [BAL_Crush_Small,BAL_Crush_Med,BAL_Crush_Large]};
		case 4: {_toggle =  BAL_Cut_Toggle; _array = [BAL_Cut_Small,BAL_Cut_Med,BAL_Cut_Large]};
		case 5: {_toggle =  BAL_Laceration_Toggle; _array = [BAL_Laceration_Small,BAL_Laceration_Med,BAL_Laceration_Large]};
		case 6: {_toggle =  BAL_VelocityWound_Toggle; _array = [BAL_VelocityWound_Small,BAL_VelocityWound_Med,BAL_VelocityWound_Large]};
		case 7: {_toggle =  BAL_PunctureWound_Toggle; _array = [BAL_PunctureWound_Small,BAL_PunctureWound_Med,BAL_PunctureWound_Large]};
		case 8: {_toggle =  BAL_ThermalBurn_Toggle; _array = [BAL_ThermalBurn_Small,BAL_ThermalBurn_Med,BAL_ThermalBurn_Large]};
	};
	
	if (_toggle) then {
		_category = _woundClassID % 10;
		_woundLevel = _array select _category;
		//level = _woundLevel;
	};
	_woundLevel;
};

_this params ["_unit","_mainWound"];

private _fractures = GET_FRACTURES(_unit);
private _leftStatus = _unit getVariable ["BAL_leftStatus", 0];
private _rightStatus =  _unit getVariable ["BAL_rightStatus", 0];

//Each leg is done only when an update to that legs state has been registered.
//In theory, this could cause some bugs/weird behavours.
//However, it is much more performance friendly, so it will be done this way until a reason not to is presented, or a better solution is found.

if (_mainWound == "LeftLeg" || _mainWound == "leftleg" || _mainWound == "all") then {
	private _leftArray = [0,0,0,0,0];
	_leftStatus = 0;

	_leftLegWounds = [_unit,"LeftLeg"] call ace_medical_fnc_getOpenWounds;
	
	{
		private _woundClassID = _x select 0;

		//Gets the level of the wound from CBA settings
		_level = [_woundClassID] call _sortWoundType;

		if (BAL_StackLeg_Toggle) then {
			for "_i" from (selectMin [_level,4]) to 0 step -1 do {
				private _count = _leftArray select _i;
				_leftArray set [_i,(_count + (_x select 1))];
			};
		} else {
			_leftStatus = selectMax [_leftStatus,_level];
		};			
	}foreach _leftLegWounds;

	if (BAL_StackLeg_Toggle) then {
		reverse _leftArray;
		{
			//If the amount of left leg wounds is greater than or equal to the amount needed for it to be considered that level.
			if ((_leftArray select _foreachindex) >= parseNumber _x) then {
				_leftStatus = 4 - _foreachindex;
				break;
			};	
		}foreach ["1",BAL_StackLeg_Critical,BAL_StackLeg_Major,BAL_StackLeg_Minor,"0"];
	};

	if (BAL_StackBandage_Toggle) then {
		private _leftLegBandaged = [_unit,"LeftLeg"] call ace_medical_fnc_getBandagedWounds;
		private _leftArrayBandaged = [0,0,0,0,0];
		private _leftStatusBandaged = 0;

		{
			private _woundClassID = _x select 0;

			//Gets the level of the wound from CBA settings, and sets it to be one level lower as it is bandaged.
			_level = [_woundClassID] call _sortWoundType;

			for "_i" from (selectMin [_level,4]) to 0 step -1 do {
				private _count = _leftArrayBandaged select _i;
				_leftArrayBandaged set [_i,(_count + (_x select 1))];
			};
		}foreach _leftLegBandaged;

		reverse _leftArrayBandaged;
		{
			//If the amount of body wounds is greater than or equal to the amount needed for it to be considered that level.
			if ((_leftArrayBandaged select _foreachindex) >= parseNumber _x) then {
				_leftStatusBandaged = 4 - _foreachindex;
				break;
			};
		}foreach ["1",BAL_StackBandage_Critical,BAL_StackBandage_Major,BAL_StackBandage_Minor,"0"];

		_leftStatus = selectMax [_leftStatus,_leftStatusBandaged];
	};

	_leftFractured = _fractures select 4;
	if (_leftFractured == 1) then {
		_leftStatus = selectMax [_leftStatus,BAL_Fracture];
	};

	_unit setVariable ["BAL_leftStatus", _leftStatus];
};

if (_mainWound == "RightLeg" || _mainWound == "rightleg" || _mainWound == "all") then {
	_rightStatus = 0;
	private _rightArray = [0,0,0,0,0];

	_rightLegWounds = [_unit,"RightLeg"] call ace_medical_fnc_getOpenWounds;
	{
		private _woundClassID = _x select 0;

		//Gets the level of the wound from CBA settings
		_level = [_woundClassID] call _sortWoundType;

		if (BAL_StackLeg_Toggle) then {
			for "_i" from (selectMin [_level,4]) to 0 step -1 do {
				private _count = _rightArray select _i;
				_rightArray set [_i,(_count + (_x select 1))];
			};
		} else {
			_rightStatus = selectMax [_rightStatus,_level];
		};
	}foreach _rightLegWounds;

	if (BAL_StackLeg_Toggle) then {
		reverse _rightArray;
		{
			//If the amount of body wounds is greater than or equal to the amount needed for it to be considered that level.
			if ((_rightArray select _foreachindex) >= parseNumber _x) then {
				_rightStatus = 4 - _foreachindex;
				break;
			};	
		}foreach ["1",BAL_StackLeg_Critical,BAL_StackLeg_Major,BAL_StackLeg_Minor,"0"];
	};

	if (BAL_StackBandage_Toggle) then {
		private _rightLegBandaged = [_unit,"RightLeg"] call ace_medical_fnc_getBandagedWounds;
		private _rightArrayBandaged = [0,0,0,0,0];
		private _rightStatusBandaged = 0;

		{
			private _woundClassID = _x select 0;

			//Gets the level of the wound from CBA settings, and sets it to be one level lower as it is bandaged.
			_level = [_woundClassID] call _sortWoundType;

			for "_i" from (selectMin [_level,4]) to 0 step -1 do {
				private _count = _rightArrayBandaged select _i;
				_rightArrayBandaged set [_i,(_count + (_x select 1))];
			};
		}foreach _rightLegBandaged;

		reverse _rightArrayBandaged;
		{
			//If the amount of body wounds is greater than or equal to the amount needed for it to be considered that level.
			if ((_rightArrayBandaged select _foreachindex) >= parseNumber _x) then {
				_rightStatusBandaged = 4 - _foreachindex;
				break;
			};
		}foreach ["1",BAL_StackBandage_Critical,BAL_StackBandage_Major,BAL_StackBandage_Minor,"0"];

		_rightStatus = selectMax [_rightStatus,_rightStatusBandaged];
	};

	_rightFractured = _fractures select 5;
	if (_rightFractured == 1) then {
		_rightStatus = selectMax [_rightStatus,BAL_Fracture];
	};

	_unit setVariable ["BAL_rightStatus", _rightStatus];

};

_legStatus = [_leftStatus,_rightStatus];

if (BAL_Debug_Toggle) then {diag_log format ["[BAL] Leg Status | Left: %1 - Right: %2",_legStatus select 0,_legStatus select 1] };

_legStatus;