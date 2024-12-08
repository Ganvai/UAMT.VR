params ["_fullArtiIndex","_ammoIndex"];

//Create Map Display in Dialog
_map = findDisplay 99001 ctrlCreate ["RscMapControl", -1];
ctrlSetFocus _map;
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.2936,safeZoneY + safeZoneH * 0.266,safeZoneW * 0.4125,safeZoneH * 0.4315];

//Get Values from Artillery Array
_artillery = (fullArti select _fullArtiIndex) select 1;
_ammo = (((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 0;

//Execute On Map Click
[_artillery,_ammo,_fullArtiIndex,_ammoIndex,_map] onMapSingleClick {
	params ["_artillery","_ammo","_fullArtiIndex","_ammoIndex","_map"];

	//Reset Click Function - Needed so guiMessage clicks don't interfere
	onMapSingleClick "";

	//Call the evaluation of the chosen Position - "spawn" is needed for guiMessages delaying
	0 = [_artillery,_ammo,_fullArtiIndex,_ammoIndex,_map,_pos] spawn {
		params ["_artillery","_ammo","_fullArtiIndex","_ammoIndex","_map","_pos"];

		//-------------------------------------------------------------------------------------------------------------
		//	Fire Zone Check
		//-------------------------------------------------------------------------------------------------------------
		_fireZoneCheck = false;
		
		//If Ammo is viable for Fire Zone Check make Firezone Check
		if ((((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 3 == "true") then {
			{	
				_fireZoneCheck = _pos inArea _x;
			
				if (_fireZoneCheck) exitWith {};
			}forEach artiNoFireZones;
		};
		
		//If Position is in No-Fire zone and Ammo not allowed
		if (_fireZoneCheck) exitWith {
			private _result = ["The chosen artillery ammunition is not allowed in No Fire Zones.","Firezone Warning","Continue","Abbort"] call BIS_fnc_guiMessage;

			ctrldelete _map;
			
			if (_result) then {
				[_fullArtiIndex,_ammoIndex] call artDialog_fnc_chooseTargetPos;
			};
		};

		//-------------------------------------------------------------------------------------------------------------
		//	Range Check
		//-------------------------------------------------------------------------------------------------------------
		_artiArr = [];
		
		// Make Objects from the String Array of Artillery Classnames
		{
			_obj = missionNamespace getVariable [_x, objNull];
			_artiArr pushback _obj;
		} forEach _artillery;
		
		//Check if position is in Range
		_isInRange = _pos inRangeOfArtillery [_artiArr, _ammo];

		//If not in Range exit function
		if (!_isInRange) exitWith {
			private _result = ["Target is out of range for this Artillery with chosen Ammunition.","Target Out of Range","Continue","Abbort"] call BIS_fnc_guiMessage;
			
			ctrldelete _map;
			
			if (_result) then {

				[_fullArtiIndex,_ammoIndex] call artDialog_fnc_chooseTargetPos;
			};				
		};

		//-------------------------------------------------------------------------------------------------------------
		//	Marker Creation
		//-------------------------------------------------------------------------------------------------------------

		private _result = ["Target Position recieved. Confirm position or change.","Target Out of Range","Confirm","Change"] call BIS_fnc_guiMessage;

		if (_result) then {	

			//Check if there is a Marker from an earlier selection
			if (artiMarker != "") then {
				deleteMarker artiMarker;
			};
			
			//Create Marker
			_markerName = format ["Artillery Strike %1",artiStrikeCount + 1];
			createMarker [_markerName, _pos];
			_markerName setMarkerType "hd_destroy_noShadow";
			_markerName setMarkerColor "ColorBlack";
			
			//Set Marker Text
			_artiName = (fullArti select _fullArtiIndex) select 0;
			_ammoName = (((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 1;
			_markerText = format ["%1 : %2 - %3",_markerName,_artiName,_ammoName];
			_markerName setMarkerText _markerText;
			
			//Publish Marker Name for Fire Function
			artiMarker = _markerName;
			publicVariable "artiMarker";

			ctrlSetText [9900105,str _pos];
			
			ctrldelete _map;
		}
		else {
			ctrldelete _map;
			[_fullArtiIndex,_ammoIndex] call artDialog_fnc_chooseTargetPos;
		};
	};
};
