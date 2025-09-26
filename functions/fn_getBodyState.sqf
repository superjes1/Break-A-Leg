#include "script_macros.hpp"

//--------------------------------------------------------------------------------------------------------------------
// Bloodloss, Bleedrate, Pain and Trauma thresholds
// https://github.com/acemod/ACE3/blob/master/addons/medical_gui/functions/fnc_updateInjuryList.sqf
//--------------------------------------------------------------------------------------------------------------------

_unit = _this select 0;

private _painStatus = 0;
if (BAL_Pain_Toggle) then {
	private _pain = GET_PAIN_PERCEIVED(_unit);
	if (_pain > 0) then {
		switch (true) do {
			case (_pain > PAIN_UNCONSCIOUS): {
				//Severe Pain
				_painStatus = BAL_Pain_Severe;
			};
			case (_pain > (PAIN_UNCONSCIOUS / 5)): {
				//"In Pain"/Moderate Pain
				_painStatus = BAL_Pain_Moderate;
			};
			default { 
				//Mild Pain
				_painStatus = BAL_Pain_Low;
			};
		};
	};
};

private _bleedStatus = 0;
if (BAL_Bleeding_Toggle) then {
	if (IS_BLEEDING(_unit)) then {
		private _cardiacOutput = [_unit] call EFUNC(medical_status,getCardiacOutput);
		private _bleedRate = GET_BLOOD_LOSS(_unit);
		private _bleedRateKO = BLOOD_LOSS_KNOCK_OUT_THRESHOLD * (_cardiacOutput max 0.05);
		// Use nonzero minimum cardiac output to prevent all bleeding showing as massive during cardiac arrest
		switch (true) do {
			case (_bleedRate < _bleedRateKO * BLEED_RATE_SLOW): {
				//Slow Bleeding
				_bleedStatus = BAL_Bleeding_Low;
			};
			case (_bleedRate < _bleedRateKO * BLEED_RATE_MODERATE): {
				//Moderate bleeding
				_bleedStatus = BAL_Bleeding_Moderate;
			};
			case (_bleedRate < _bleedRateKO * BLEED_RATE_SEVERE): {
				//Severe bleeding
				_bleedStatus = BAL_Bleeding_Severe;
			};
			default {
				//Massive bleeding
				_bleedStatus = BAL_Bleeding_Massive;
			};
		};
	};
};

private _bloodlossStatus = 0;
if (BAL_Bloodloss_Toggle) then {
	switch (GET_HEMORRHAGE(_unit)) do {
		case 1: {
			//Lost some Blood
			_bloodlossStatus = BAL_Bloodloss_Low;
		};
		case 2: {
			//Lost a lot of blood
			_bloodlossStatus = BAL_Bloodloss_Moderate;
		};
		case 3: {
			//Lost a large amount of blood
			_bloodlossStatus = BAL_Bloodloss_Severe;
		};
		case 4: {
			//Lost a fatal amount of blood
			_bloodlossStatus = BAL_Bloodloss_Massive;
		};
	};
};

if (BAL_Debug_Toggle) then {diag_log format ["[BAL] Body Status | Pain: %1 - Bleeding: %2 - Bloodloss: %3",_painStatus,_bleedStatus,_bloodlossStatus] };

[_painStatus,_bleedStatus,_bloodlossStatus];