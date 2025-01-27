params ["_unit"];

hint "Hold ACtion Function";
// Add Hold ACtion to gather Intel
[
	_unit,
	"search for Intel",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 5",
	"_caller distance _target < 5",
	{},
	{},
	{
		_caller playMove "AinvPknlMstpSnonWnonDr_medic4";
		[_caller]spawn {
			params ["_player"];
			private _sound = playSound3D ["A3\Sounds_F\characters\stances\rifle_to_unarmed.wss", _player];
			sleep 1.36286;
			private _sound = playSound3D ["A3\Sounds_F\characters\stances\unarmed_to_binoculars.wss", _player];
			sleep 1.5;
			private _sound = playSound3D ["A3\Sounds_F\characters\stances\unarmed_to_binoculars.wss", _player];
			sleep 1.5;
			private _sound = playSound3D ["A3\Sounds_F\characters\stances\unarmed_to_binoculars.wss", _player];
			sleep 1.5;
			private _sound = playSound3D ["A3\Sounds_F\characters\stances\binoculars_to_unarmed.wss", _player];
			sleep 1.37501;
			[_player] call UAMT_fnc_intelReveal;
		};
		
		// Remove Hold Action for all Clients (Added in on completion Code):
		[_this select 0, _this select 2] remoteExecCall ["removeAction", 0];
	},
	{},
	[],
	1,
	2000,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd",0, true];

/*
AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic
AinvPknlMstpSnonWnonDr_medic4
AinvPknlMstpSnonWnonDnon_medic0

AinvPknlMstpSlayWrflDnon_AmovPercMstpSrasWrflDnon
*/