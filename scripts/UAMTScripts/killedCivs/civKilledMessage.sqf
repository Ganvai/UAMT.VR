if (isDedicated) exitWith {};

params ["_killer"];

_message = "A Civilian was killed";

if ( civAbortMission == "true" && civKillCount >= civAbortKillCount) then {
	_message = format ["<t align = 'center' shadow = '2' color='#0080ff' size='2' font='RobotoCondensedBold' >%2: </t><t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >Thats it. High Command aborts the Mission. To many Civilian Casualties. Return to Base Immediatly!</t><t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' > Suspected Shooter: %1</t>", name _killer, civMessageSender];
}
else {
	if (civKillCount == 1) then {
		_message = format ["<t align = 'center' shadow = '2' color='#0080ff' size='2' font='RobotoCondensedBold' >%2: </t><t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >A civilian got shot. Position marked for further Investigations.</t><t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' > Suspected Shooter: %1</t>", name _killer, civMessageSender];
		
	}
	else {
		if (civKillCount == civEscalation1) then {
			_message = format ["<t align = 'center' shadow = '2' color='#0080ff' size='2' font='RobotoCondensedBold' >%3: </t><t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >God damnit. We already have %2 dead civilians. Check your fucking targets.</t><t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' > Suspected Shooter: %1</t>", name _killer, str civEscalation1, civMessageSender];
		}
		else {
			if (civKillCount == civEscalation2) then {
				_message = format ["<t align = 'center' shadow = '2' color='#0080ff' size='2' font='RobotoCondensedBold' >%3: </t><t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >Oh my god. We already have %2 civilian casualties. If this goes further we have to abort the Mission.</t><t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' > Suspected Shooter: %1</t>", name _killer, str civEscalation2, civMessageSender];
			}
			else {
				_message = format ["<t align = 'center' shadow = '2' color='#0080ff' size='2' font='RobotoCondensedBold' >%2: </t><t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >We have another dead Civilian. Position marked for further Investigations.</t><t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' > Suspected Shooter: %1</t>", name _killer, civMessageSender];
			};
		};
	};
};

titletext [_message, "PLAIN DOWN", 1, true, true];