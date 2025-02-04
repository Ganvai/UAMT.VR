_players = allplayers - entities "HeadlessClient_F";
_cargo = [];

{
	// Setup all Temp Variables
	_role = _x getVariable "loadout";
	_magWell = [];
	
	if (_role in _supplyCrateRoles) then {
		
		//Get All available Magazines
		_primArr = [missionConfigFile >> "CfgLoadouts" >> _role, "primary", []] call BIS_fnc_returnConfigEntry;
		_primAltArr = [missionConfigFile >> "CfgLoadouts" >> _role, "primaryAlternatives", []] call BIS_fnc_returnConfigEntry;
		
		if (count _primArr > 0) then {
			_magWell pushback ((_primArr select 4) select 0);
		};
		
		{
			_magWell pushback (_x select 1);
		}forEach _primAltArr

		_profWeapons = _x getVariable ["profWeapons",[]];
		
		_playerMagWell = compatibleMagazines (_profWeapons select 0);
		
		{
			if (_x in _playerMagWell) exitWith {
				_cargo pushback _x;
			};
		}forEach _magWell;

	};
}forEach _players;

