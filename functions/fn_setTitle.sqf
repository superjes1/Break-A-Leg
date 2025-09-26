_unit = _this select 0;

_cooldown = _unit getVariable ["BAL_Cooldown", 0];

if (serverTime >= _cooldown) then {

	_reason = player getVariable ["BAL_reason",0];


	_reasonArray = [["bal_main\UI\broken_bone.paa",2,[255,0,0]],["YOU ARE INCAPACITATED!",1.5,[255,0,0]]];
	
	if (BAL_IncapacitationTitle_Reason >= 1 && _reason > 0) then {
		_reasonArray pushback ["You were Incapacitated due to:",1.2,[255,255,255]];
		if (BAL_IncapacitationTitle_Reason >= 2) then {

			_leftStatus = player getVariable ["BAL_leftStatus", 0];
			_rightStatus = player getVariable ["BAL_rightStatus", 0];
			_bodyStatus = player getVariable ["BAL_bodyStatus",[0,[0,0,0]]];

			if (_leftStatus >= _reason) then {
				private _reasontxt = "";
				switch _leftStatus do {
					case 1: {_reasontxt = "A Minor Wound on your Left Leg";};
					case 2: {_reasontxt = "A Major Wound on your Left Leg";};
					case 3: {_reasontxt = "A Critical Wound on your Left Leg";};
					case 4: {_reasontxt = "A Catastrophic Wound on your Left Leg";};
				};
				_reasonArray pushback [_reasontxt,1,[255,255,255]]
			};

			if (_rightStatus >= _reason) then {
				private _reasontxt = "";
				switch _rightStatus do {
					case 1: {_reasontxt = "A Minor Wound on your Right Leg";};
					case 2: {_reasontxt = "A Major Wound on your Right Leg";};
					case 3: {_reasontxt = "A Critical Wound on your Right Leg";};
					case 4: {_reasontxt = "A Catastrophic Wound on your Right Leg";};
				};
				_reasonArray pushback [_reasontxt,1,[255,255,255]]
			};

			if ((_bodyStatus select 0) >= _reason) then {

				//Pain Check
				if (((_bodyStatus select 1) select 0) >= _reason) then {
					private _reasontxt = "";
					switch _rightStatus do {
						case 1: {_reasontxt = "A Minor amount of pain";};
						case 2: {_reasontxt = "A Major amount of pain";};
						case 3: {_reasontxt = "A Critical amount of pain";};
						case 4: {_reasontxt = "A Catastrophic amount of pain";};
					};
					_reasonArray pushback [_reasontxt,1,[255,255,255]]
				};

				//Bleeding Check
				if (((_bodyStatus select 1) select 1) >= _reason) then {
					private _reasontxt = "";
					switch _rightStatus do {
						case 1: {_reasontxt = "A Minor amount of bleeding";};
						case 2: {_reasontxt = "A Major amount of bleeding";};
						case 3: {_reasontxt = "A Critical amount of bleeding";};
						case 4: {_reasontxt = "A Catastrophic amount of bleeding";};
					};
					_reasonArray pushback [_reasontxt,1,[255,255,255]]
				};

				//Bloodloss Check
				if (((_bodyStatus select 1) select 2) >= _reason) then {
					private _reasontxt = "";
					switch _rightStatus do {
						case 1: {_reasontxt = "A Minor amount of bloodloss";};
						case 2: {_reasontxt = "A Major amount of bloodloss";};
						case 3: {_reasontxt = "A Critical amount of bloodloss";};
						case 4: {_reasontxt = "A Catastrophic amount of bloodloss";};
					};
					_reasonArray pushback [_reasontxt,1,[255,255,255]]
				};

			};

			} else {
			//"Simple" reasoning mode. 
			_reasontxt = "";
			switch _reason do {
				case 1: {_reasontxt = "Multiple Minor Wounds across your entire body"};
				case 2: {_reasontxt = "Some Major wounds across most of your body"};
				case 3: {_reasontxt = "A Critical wound and a Minor wound"};
				case 4: {_reasontxt = "A Catastrophic wound that needs immediate treatment!";};
			};
			_reasonArray pushback [_reasontxt,1,[255,255,255]];
		};
	};

	if (BAL_IncapacitationTitle_Toggle) then {
		titleText ["<t color='#ff0000' size='3'>YOU ARE INCAPACITATED!</t>", "PLAIN NOFADE", -1, true, true];
		titleFadeOut BAL_IncapacitationTitle_Cooldown;
	};
	//Lets the notification be skipped. 
	_reasonArray pushback true;
	_reasonArray call CBA_fnc_notify;
	private _sound = selectRandom ["ACE_fracture_1","ACE_fracture_2","ACE_fracture_3"];
	playSound [_sound,true];

	_unit setVariable ["BAL_Cooldown", (serverTime + BAL_IncapacitationTitle_Cooldown)];
};