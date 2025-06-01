//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//
//			Ambush
//
// Makes a Group prepare for an ambush. They will wait until the trigger that is given is activated 
// or if enemies are inside the Aggro Distance radius OR they get attacked.
//
// This function needs a Trigger that can be activated and should also mark the position where the ambush should take place.
//
// _group : Group that goes into ambush mode 
// _trigger : Trigger-Object the group waits for to be activated to start the ambush
// _aggroDistance : NUMBER - Optional - Default: 50 - radius around the Groupleader. If enemies are in this radius, the group will attack and ignore the trigger
// _wpType : STRING - Waypoint Type with wich the group should approach the Trigger position when trigger gets activated
// _aiIgnore : BOOL - Default: TRUE - Makes all Units of the Ambush Group setCaptive true so they are ignored by AI until the trigger is activated
// _aiActivateDist : BOOL - Default: false - If true, all AI that are from hostile sides activate the Ambush when they are in aggro range.
//										 	Default is false which is also recommended because on true this function is costing much more performance. On Default, only Players
//											are activating the Ambush via distance.
//
// Example:
// [_group,_trigger,100,"SAD",true,false] spawn UAMT_fnc_ambush;
//
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------


params ["_group","_trigger",["_aggroDistance",50],["_wpType","SAD"],["_aiIgnore",true],["_aiActivateDist",false]];

{
	_x disableAI "PATH";
	_x disableAI "FIREWEAPON";
	
	_x setUnitPos "DOWN";

	if (_aiIgnore) then {
		_x setCaptive true;
	};
	
	_X addEventHandler ["Suppressed", {
		params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
		if ([side _unit, side _instigator] call BIS_fnc_sideIsEnemy) then {
			{
				_x enableAI "PATH";
				_x enableAI "FIREWEAPON";
				
				_x setUnitPos "AUTO";

				_x reveal _instigator;
				
				_x setCaptive false;

				_x removeAllEventHandlers "Killed";
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "Suppressed";
			} forEach units (group _unit);
		};
	}];
	
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		if ([side _unit, side _instigator] call BIS_fnc_sideIsEnemy) then {
			{
				_x enableAI "PATH";
				_x enableAI "FIREWEAPON";
				
				_x setUnitPos "AUTO";
				
				_x reveal _instigator;
				
				_x setCaptive false;

				_x removeAllEventHandlers "Killed";
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "Suppressed";
			} forEach units (group _unit);
		};
	}];
	
	_x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if ([side _unit, side _instigator] call BIS_fnc_sideIsEnemy) then {
			{
				_x enableAI "PATH";
				_x enableAI "FIREWEAPON";
				
				_x setUnitPos "AUTO";
				
				_x reveal _instigator;
				
				_x setCaptive false;
				
				_x removeAllEventHandlers "Killed";
				_x removeAllEventHandlers "Hit";
				_x removeAllEventHandlers "Suppressed";
			} forEach units (group _unit);
		};
	}];	
}forEach units _group;

_leader = leader _group;


if (_aiActivateDist) then {
	waitUntil {
		sleep 1; 
		
		_hostileSides = _leader call BIS_fnc_enemySides;
		
		_unitsToCheck = [];
		{
			_unitsToCheck pushback _x;
		} forEach units _hostileSides;
		
		(triggerActivated _trigger || ({_leader distance _x < _aggroDistance} count (_unitsToCheck) > 0 ));
	};
}
else {
	waitUntil {sleep 1; triggerActivated _trigger || ({_leader distance _x < _aggroDistance} count (playableunits + switchableunits) > 0 )};
};

{
	_x enableAI "PATH";
	_x enableAI "FIREWEAPON";
	
	_x setUnitPos "AUTO";

	if (_aiIgnore) then {
		_x setCaptive false;
	};
	
}forEach units _group;

_wp = _group addWaypoint [position _trigger, 0];
_wp setWaypointType _wpType;