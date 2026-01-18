if (!isServer) exitWith {};

params ["_vls","_targetPos","_side","_ammoID","_audioMessages","_customAudio","_supportControlName",["_createMarker",true]];

if (_createMarker) then {
	createMarker ["vlsMrk",_targetPos];
	"vlsMrk" setMarkerAlpha 0;
	"vlsMrk" setMarkerType "hd_destroy_noShadow";
	"vlsMrk" setMarkerText "VLS Target";
};

if (_audioMessages) then {
	_msg = format ["Coordinates recieved. Preparing missile launch."];

	if (_customAudio) then {
		[_msg,_supportControlName,"msg_vlsPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};

	sleep 2;
};

_vls setVehicleAmmo 1;

_ammo  = "magazine_Missiles_Cruise_01_x18";
if (_ammoID == 1) then {
	_ammo = "magazine_Missiles_Cruise_01_Cluster_x18";
};

if ( _ammo != _vls currentMagazineTurret [0] ) then {
	_vls loadMagazine [[0],"weapon_VLS_01",_ammo];

	if (_audioMessages) then {
		_msg = format ["Reloading Missile Array. Time to launch: 2.5 mike!"];

		if (_customAudio) then {
			[_msg,_supportControlName,"msg_vlsReload",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		}
		else {
			[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		};
	};

	waitUntil {sleep 1; weaponState [_vls,[0]] #6 == 0;};
};

if (_audioMessages) then {
	
	_msg = format ["All units: Missile away!"];
	if (_customAudio) then {
		[_msg,_supportControlName,"msg_vlsAway",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};
	
	sleep 2;
};

_target = createVehicle ["Land_HelipadEmpty_F",_targetPos];

_side reportRemoteTarget [_target,1000];
_vls doWatch _target;
_vls fireAtTarget [_target];

deleteVehicle _target;
deleteMarker "vlsMrk";

/*
ammo_Missile_Cruise_01_Cluster
ammo_Missile_Cruise_01

weapon_VLS_01

"magazine_Missiles_Cruise_01_x18"
"magazine_Missiles_Cruise_01_Cluster_x18"

Reload Time Same Mag: 15
Reload Time Magazine: 2:19
*/