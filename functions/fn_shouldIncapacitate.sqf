_this params ["_unit",["_leftStatus",-1],["_rightStatus",-1]];
_incapacitate = false;

//Loads last known leg status if it was not provided/checked
if (_leftStatus == -1) then {_leftStatus = _unit getVariable ["BAL_leftStatus", 0];};
if (_rightStatus == -1) then {_rightStatus = _unit getVariable ["BAL_rightStatus", 0];};

//Gets the body status of the unit.
//Aka, Bloodloss, Bleeding rate, Pain ect.
_bodyStatus = [_unit] call BAL_fnc_getBodyState;
_bodyStatusMax = 0;
if (BAL_StackBody_Toggle) then {
	_bodyArray = [0,0,0,0,0];
	{
		for "_i" from (selectMin [_x,4]) to 0 step -1 do {
			private _count = _bodyArray select _i;
			_bodyArray set [_i,(_count + 1)];
		};
	}foreach _bodyStatus;

	reverse _bodyArray;

	{
		//If the amount of body wounds is greater than or equal to the amount needed for it to be considered that level.
		if ((_bodyArray select _foreachindex) >= _x) then {
			_bodyStatusMax = 4 - _foreachindex;
			break;
		};	
	}foreach [1,BAL_StackBody_Critical,BAL_StackBody_Major,BAL_StackBody_Minor,0];
} else {
	_bodyStatusMax = SelectMax _bodyStatus;
};

player setVariable ["BAL_bodyStatus",[_bodyStatusMax,_bodyStatus]];

//Gets the max leg state between both legs. 
//This makes the logic a lot easier.
_legMax = SelectMax [_leftStatus,_rightStatus];
_legMin = SelectMin [_leftStatus,_rightStatus];

//-----------------------------------
//Welcome to Logic Hell!
//-----------------------------------

_reason = 0;
//There is almost certainly a better way of doing this, but im on a bit of a time crunch atm and this is the easiest way, so its what im doing. 
if (BAL_BothLegsWounded_IncapacitateBypass) then {
	if (_legMax == 4 || _bodyStatusMax == 4) then {
		_incapacitate = true; _reason = 4; if (BAL_Debug_Toggle) then { diag_log "[BAL] Catastrophic level wound."};
	};
};

//If both legs have to be wounded to incapacitate the player, then check if both legs are wounded. If not, then just go ahead as normal. 
if (((BAL_BothLegsWounded_Toggle ) && (_legMin >= 1)) || (!BAL_BothLegsWounded_Toggle)) then {
	//Check if there is an "Catastrophic" level wound. 
	//These immobalise by themselves, so there is no need to do fancy logic. 
	if (_legMax == 4 || _bodyStatusMax == 4) then {
		_incapacitate = true; _reason = 4; if (BAL_Debug_Toggle) then {diag_log "[BAL] Catastrophic level wound."};
	}else{
		//If there isnt an incapacitation level wound, then we need to check for the other potential incapacitation causes.
		//Start at the top and work our way down, aka critical wound logic first, as they are the most important to imform the players about. 
		//We have to account for the fact that the body wound can replace either of the leg wounds, so we need to do two seperate checks. 
		if (
			//Check 1: A critical Leg wound OR a critical Body wound, AND a minor leg wound
			(((_legMax == 3) || (_bodyStatusMax == 3)) && (_legMin >= 1)) 
			||  //Or
			//Check 2: A critical Leg wound AND a minor body wound OR a minor Leg wound
			((_legMax == 3) && ((_bodyStatusMax >= 1) || (_legMin >= 1)))
			) then {
				_incapacitate = true; _reason = 3; if (BAL_Debug_Toggle) then {diag_log "[BAL] Critical + Minor"};
		} else {
			//If one leg has a major wound AND the other has a major wound OR there is major body damage, then incapacitate.
			if ((_legMax >= 2) && ((_bodyStatusMax >= 2) || (_legMin >= 2)) ) then {
				_incapacitate = true; _reason = 2; if (BAL_Debug_Toggle) then {diag_log "[BAL] Double Major"};
			} else {
				//If there is Minor wounds on both legs and minor body damage, then incapacitate.
				if ((_legMax >= 1) && (_legMin >= 1) && (_bodyStatusMax >= 1)) then {
					_incapacitate = true; _reason = 1; if (BAL_Debug_Toggle) then {diag_log "[BAL] Triple Minor"};
				};
			};
		};
	};
};

if (_reason != 0) then{
	player setVariable ["BAL_reason", _reason];
};

_incapacitate;