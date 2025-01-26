//----------------------------------------------------------------
//----------------------------------------------------------------
//
//			Supply Point Init
//
// Adds the ACE Functions to spawn Supply Crates to an Object
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//
//----------------------------------------------------------------
//----------------------------------------------------------------

params ["_supplyPoints"];

{
	_boxes = [missionConfigFile >> "CfgFactionEquipment", "supplyCrates", []] call BIS_fnc_returnConfigEntry;
	
	_supplyPoint = _x select 0;
	
	if ( (typeName _supplyPoint) == "STRING") then {
		_supplyPoint = missionNamespace getVariable [(_x select 0), objNull];
	};
	
	_supplyPointDist = _x select 1;
	_supplyPointDir = _x select 2;
	_supplyPointBoxName = "";
	_supplyPointBoxType = "";
	_supplyPointBoxVar = "";
	_boxNumber = 0;
	
	{
		_boxNumber = _boxNumber + 1;
		_actionName = format ["SupplyBox %1", _boxNumber];
		_supplyPointBoxName = _x select 0;
		_supplyPointBoxType = _x select 1;
		_supplyPointBoxVar = _x select 2;

		_statement = {
			params ["_target", "_player", "_actionParams"];
			_actionParams params ["_supplyPoint", "_supplyPointDist", "_supplyPointDir", "_supplyPointBoxType", "_supplyPointBoxVar"];
			
			[_supplyPoint,_supplyPointDist,_supplyPointDir,_supplyPointBoxType,_supplyPointBoxVar] remoteExec ["UAMT_fnc_spawnSupplyCrate",2];
			//[_supplyPoint,_supplyPointDist,_supplyPointDir,_supplyPointBoxType,_supplyPointBoxVar] call UAMT_fnc_spawnSupplyCrate;
		};
		
		_box = [_actionName, _supplyPointBoxName, "", _statement, {true}, {}, [_supplyPoint, _supplyPointDist, _supplyPointDir, _supplyPointBoxType, _supplyPointBoxVar]] call ace_interact_menu_fnc_createAction;		
		[_supplyPoint, 0, ["ACE_MainActions"], _box] call ace_interact_menu_fnc_addActionToObject;
		
	}forEach _boxes;
}forEach _supplyPoints;