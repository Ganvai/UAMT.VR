params ["_caller"];

// Prepare all Variables
_chance = random 1;
_IntelMainCounter = missionNameSpace getVariable ["IntelMainCounter",0];
_intelSecondaryArray = missionNameSpace getVariable ["IntelSecondaryArray",[]];


if (_chance >= 0.5 && _intelMainCounter <= (missionNameSpace getVariable ["IntelMaxCounter",0])) then {
	// If Chance is right and IntelMainCounter not maxed out 
	_intelMainCounter = _intelMainCounter + 1;
	missionNameSpace setVariable ["IntelMainCounter",_intelMainCounter,true];
	
	// Switch if Area gets smaller but not for every Intel tick
	switch _intelMainCounter do {
		case 3 : {/*Do Something like decrease Search Radius*/["Intel Stage 3"]remoteExec ["hint",_caller];};
		case 6 : {/*Do Something like decrease Search Radius*/["Intel Stage 6"]remoteExec ["hint",_caller];};
		case 9 : {/*All Intel Found and Mark Search Position on the Map*/["Intel Stage 9"]remoteExec ["hint",_caller];};
		default {["You found Intel about the Location of the Plane. Gather more Intel to decrease the search radius"]remoteExec ["hint",_caller];};
	};
}
else {
	if (count _intelSecondaryArray > 0) then {
		// If there are still secondary Intel Markers left
		_marker = _intelSecondaryArray select 0;
		
		//Clean Up Array on Public before anything gets messed up
		_intelSecondaryArray deleteat 0;
		missionNameSpace setVariable ["IntelSecondaryArray",_intelSecondaryArray,true];
		
		// Reveal Marker Position
		(_intelSecondaryArray select 0) setMarkerAlpha 1;
		
		//Build Intel Message with Marker Text
		_hintMessage = format ["You found Intel that revealed an Enemy Position on the Map: %1",markerText (_intelSecondaryArray select 0)];
		[_hintMessage]remoteExec ["hint",_caller];
	}
	else {
		//If there is no Intel left to be discovered
		["You already found this Intel."]remoteExec ["hint",_caller];
	};
};
	