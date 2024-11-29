if (!isServer) exitWith {};

params ["_customAudio","_HALOVeh","_side"];

WaitUntil {sleep 0.1; ((eyePos driver _HALOVeh) select 2 > 300)};

if (_customAudio) then {
	["Okay, listen up. We will now start our climb to the jump height of 3000 meters. This will be a rapid pressure change, so be ready to pop your ears.","Pilot","msg_HALOClimbStart",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Okay, listen up. We will now start our climb to the jump height of 3000 meters. This will be a rapid pressure change, so be ready to pop your ears.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

WaitUntil {sleep 0.1; ((eyePos driver _HALOVeh) select 2 > 990)};

if (_customAudio) then {
	["Just reached 1000 meters. 2000 more to go.","Pilot","msg_HALOClimb1000",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Just reached 1000 meters. 2000 more to go.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

WaitUntil {sleep 0.1; ((eyePos driver _HALOVeh) select 2 > 1990)};

if (_customAudio) then {
	["2000 meters. All engines running normal. We continue climbing.","Pilot","msg_HALOClimb2000",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["2000 meters. All engines running normal. We continue climbing.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

WaitUntil {sleep 0.1; ((eyePos driver _HALOVeh) select 2 > 2490)};

if (_customAudio) then {
	["2500 meters. We are nearly there.","Pilot","msg_HALOClimb2500",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["2500 meters. We are nearly there.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

WaitUntil {sleep 0.1; ((eyePos driver _HALOVeh) select 2 > 2990)};

if (_customAudio) then {
	["3000 meters. Continuing to approach vector.","Pilot","msg_HALOClimb3000",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["3000 meters. Continuing to approach vector","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};
