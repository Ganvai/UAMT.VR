if (!isServer) exitWith {};

params ["_targetPos","_side","_ammoID",["_createMarker",true]];

missionNameSpace setVariable ["vlsStatus",2,true];

_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;

if (_createMarker) then {
	createMarker ["vlsMrk",_targetPos];
	"vlsMrk" setMarkerAlpha 0;
	"vlsMrk" setMarkerType "hd_destroy_noShadow";
	"vlsMrk" setMarkerText "VLS Target";
};

if (_audioMessages) then {
	_msg = format ["Coordinates recieved. Preparing missile launch."];

	if (_customAudio) then {
		[_msg,_supportControlName,"msg_vlsPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};

	sleep 3.5;
};

vlsName setVehicleAmmo 1;

_ammo  = "magazine_Missiles_Cruise_01_x18";
if (_ammoID == 1) then {
	_ammo = "magazine_Missiles_Cruise_01_Cluster_x18";
	
	missionNameSpace setVariable ["vlsClusterRounds",(missionNameSpace getVariable "vlsClusterRounds") - 1,true];
}
else {
	missionNameSpace setVariable ["vlsHERounds",(missionNameSpace getVariable "vlsHERounds") - 1,true];
};

if ( _ammo != vlsName currentMagazineTurret [0] ) then {
	vlsName loadMagazine [[0],"weapon_VLS_01",_ammo];

	if (_audioMessages) then {
		_msg = format ["Reloading Missile Array. Time to launch: 2.5 mike!"];

		if (_customAudio) then {
			[_msg,_supportControlName,"msg_vlsReload",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};

	waitUntil {sleep 1; weaponState [vlsName,[0]] #6 == 0;};
};

if (_audioMessages) then {
	
	_msg = format ["All units be advised: Missile away!"];
	if (_customAudio) then {
		[_msg,_supportControlName,"msg_vlsAway",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep 3.5;
};

sleep vlsDelay;

_target = createVehicle ["Land_HelipadEmpty_F",_targetPos];

sleep  5;
vlsName setVehicleReceiveRemoteTargets true;
_side reportRemoteTarget [_target,1000];
vlsName doWatch _target;
vlsName fireAtTarget [_target];
vlsName setVehicleReceiveRemoteTargets false;

waitUntil {sleep 0.5; vlsMissile != objNull};

waitUntil {sleep 0.5; vlsMissile distance2D _target < 1000};

if (_audioMessages) then {
	if (_customAudio) then {
		["Missile distance to target: 1000 meter",_supportControlName,"msg_vls1000",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Missile distance to target: 1000 meter",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

waitUntil {sleep 0.5; !alive vlsMissile || vlsMissile distance2D _target > 2000};

if (!alive vlsMissile) then {
	if (_audioMessages) then {
		if (_customAudio) then {
			["Missile Impact",_supportControlName,"msg_vlsimpact",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Missile Impact",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
}
else {
	if (_audioMessages) then {
		if (_customAudio) then {
			["Missile Target Error. Executing Selfdestruct.",_supportControlName,"msg_vlsSelfDestruct",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Missile Target Error. Executing Selfdestruct.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};

	vlsMissile setDamage 1;
};

missionNameSpace setVariable ["vlsStatus",3,true];

sleep 5;

if ( vlsHERounds > 0 || vlsClusterRounds > 0 ) then {
	sleep (10 + vlsCooldown);

	if (_audioMessages) then {
		_msg = format ["Be advised: VLS array is reloaded. Standing by for new coordinates."];

		if (_customAudio) then {
			[_msg,_supportControlName,"msg_vlsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
}
else {
	if (_audioMessages) then {
		_msg = format ["Be advised: VLS is bingo ammo. No more missile strikes available."];

		if (_customAudio) then {
			[_msg,_supportControlName,"msg_vlsEnd",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

deleteVehicle _target;
deleteMarker "vlsMrk";
missile = objNull;
publicVariable "missile";

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