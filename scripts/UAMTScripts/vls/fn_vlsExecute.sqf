if (!isServer) exitWith {};

params ["_targetPos","_side","_ammoID",["_createMarker",true]];

missionNameSpace setVariable ["vlsStatus",2,true];

_vlsObj = missionNameSpace getVariable [(getMissionConfigValue "vlsName"),objNull];

_audioMessages = getMissionConfigValue "supportMessages";
_customAudio = getMissionConfigValue "supportCustomAudio";
_supportControlName = getMissionConfigValue "supportControlName";

if (_createMarker) then {
	createMarker ["vlsMrk",_targetPos];
	"vlsMrk" setMarkerAlpha 0;
	"vlsMrk" setMarkerType "hd_destroy_noShadow";
	"vlsMrk" setMarkerText "VLS Target";
};

if (_audioMessages == "true") then {
	_msg = format ["Coordinates recieved. Preparing missile launch."];

	if (_customAudio == "true") then {
		[_msg,_supportControlName,"msg_vlsPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};

	sleep 3.5;
};

_vlsObj setVehicleAmmo 1;

_ammo  = "magazine_Missiles_Cruise_01_x18";
if (_ammoID == 1) then {
	_ammo = "magazine_Missiles_Cruise_01_Cluster_x18";
	
	missionNameSpace setVariable ["vlsClusterRounds",(missionNameSpace getVariable "vlsClusterRounds") - 1,true];
}
else {
	missionNameSpace setVariable ["vlsHERounds",(missionNameSpace getVariable "vlsHERounds") - 1,true];
};

if ( _ammo != _vlsObj currentMagazineTurret [0] ) then {
	_vlsObj loadMagazine [[0],"weapon_VLS_01",_ammo];

	if (_audioMessages == "true") then {
		_msg = format ["Reloading Missile Array. Time to launch: 2.5 mike!"];

		if (_customAudio == "true") then {
			[_msg,_supportControlName,"msg_vlsReload",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

sleep 1;

waitUntil {sleep 1; weaponState [_vlsObj,[0]] #6 == 0 && weaponState [_vlsObj,[0]] #5 == 0 };

if (_audioMessages == "true") then {
	
	_msg = format ["All units be advised: Missile away!"];
	if (_customAudio == "true") then {
		[_msg,_supportControlName,"msg_vlsAway",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep 3.5;
};

sleep (getMissionConfigValue "vlsDelay");

_target = createVehicle ["Land_HelipadEmpty_F",_targetPos];

sleep  5;

_vlsObj setVehicleReceiveRemoteTargets true;
_side reportRemoteTarget [_target,1000];
_vlsObj doWatch _target;
_vlsObj enableAI "FIREWEAPON";
_vlsObj fireAtTarget [_target];

waitUntil {missionNameSpace getVariable ["vlsMissile",objNull] != objNull };

_vlsObj disableAI "FIREWEAPON";

waitUntil { sleep 0.5; (missionNameSpace getVariable ["vlsMissile",objNull] distance2D _target < 1000 || getPos (missionNameSpace getVariable ["vlsMissile",objNull]) select 2 > 1000) };

_error = false;

if ((getPos (missionNameSpace getVariable ["vlsMissile",objNull])) select 2 > 1000) then {
	_error = true;
};

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["Missile distance to target: 1000 meters",_supportControlName,"msg_vls1000",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Missile distance to target: 1000 meters",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

waitUntil {sleep 0.5; !alive (missionNameSpace getVariable ["vlsMissile",objNull]) || (missionNameSpace getVariable ["vlsMissile",objNull]) distance2D _target > 2000 || _error};

if (!alive (missionNameSpace getVariable ["vlsMissile",objNull]) && !_error) then {
	if (_audioMessages == "true") then {
		if (_customAudio == "true") then {
			["Missile Impact",_supportControlName,"msg_vlsimpact",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Missile Impact",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
}
else {
	if (_audioMessages == "true") then {
		if (_customAudio == "true") then {
			["Missile Guidance Error. Executing Selfdestruct.",_supportControlName,"msg_vlsSelfDestruct",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Missile Guidance Error. Executing Selfdestruct.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};

	missionNameSpace getVariable ["vlsMissile",objNull] setDamage 1;
};

missionNameSpace setVariable ["vlsStatus",3,true];

sleep 5;

if ( (missionNameSpace getVariable "vlsHERounds") > 0 || (missionNameSpace getVariable "vlsClusterRounds") > 0 ) then {
	sleep (10 + getMissionConfigValue "vlsCooldown");

	if (_audioMessages == "true") then {
		_msg = format ["Be advised: VLS array is reloaded. Standing by for new coordinates."];

		if (_customAudio == "true") then {
			[_msg,_supportControlName,"msg_vlsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
}
else {
	if (_audioMessages == "true") then {
		_msg = format ["Be advised: VLS is bingo ammo. No more missile strikes available."];

		if (_customAudio == "true") then {
			[_msg,_supportControlName,"msg_vlsEnd",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

_vlsObj setVehicleReceiveRemoteTargets false;

deleteVehicle _target;
deleteMarker "vlsMrk";
missionNameSpace setVariable ["vlsMissile",objNull,true];

missionNameSpace setVariable ["vlsStatus",0,true];

/*
ammo_Missile_Cruise_01_Cluster
ammo_Missile_Cruise_01

weapon_VLS_01

"magazine_Missiles_Cruise_01_x18"
"magazine_Missiles_Cruise_01_Cluster_x18"

Reload Time Same Mag: 15
Reload Time Magazine: 2:19
*/