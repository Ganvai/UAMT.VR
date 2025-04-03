if (missionNameSpace getVariable ["artiStatus",0] > 1) exitWith {
	switch (missionNameSpace getVariable ["artiStatus",0]) do {
		case 2 : {["No Artillery Strike available. Artillery is executing a strike", "Error"] spawn BIS_fnc_guiMessage;};
		case 3 : {["No Artillery Strike available. Artillery is reloading and will be available shortly", "Error"] spawn BIS_fnc_guiMessage;};
	};
};

[] spawn {
	sleep 1;

	if (findDisplay 99001 == displayNull) then {
		onMapSingleClick "";
		deleteMarkerLocal (player getVariable "artMrkRadLocal");
		deleteMarkerLocal (player getVariable "artMrkLocal");
	};
};

_display = "";
_map = "";

if (getMissionConfigValue "paperInterface" == "true") then {
	_display = createDialog ["artDialogPaper"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.496,safeZoneY + safeZoneH * 0.142,safeZoneW * 0.343,safeZoneH * 0.705];

}
else {
	_display = createDialog ["artDialogTablet"];
	_map = _display ctrlCreate ["RscMapControl", -1];
	_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.232,safeZoneY + safeZoneH * 0.253,safeZoneW * 0.533,safeZoneH * 0.464];
};

_lbControl = _display displayCtrl 9900101;
{
	_lbControl lbAdd (_x select 0);
} forEach (missionNameSpace getVariable "fullArti");

_lbControl lbSetCurSel 0;

_lbControl = _display displayCtrl 9900105;

[_lbControl] spawn {
	params ["_lbControl"];
	
	_lbControl lbSetPictureColor [0,[1,1,1,1]];
	_lbControl lbSetPictureColorSelected [0,[1,1,1,1]];
	
	_lbControl lbSetPicture [1,"Dialogs\artDialog\extended.paa"];
	_lbControl lbSetPictureColor [1,[1,1,1,1]];
	_lbControl lbSetPictureColorSelected [1,[1,1,1,1]];

	_lbControl lbSetPicture [2,"Dialogs\artDialog\area.paa"];
	_lbControl lbSetPictureColor [2,[1,1,1,1]];
	_lbControl lbSetPictureColorSelected [2,[1,1,1,1]];

	_lbControl lbSetPicture [3,"Dialogs\artDialog\inverted.paa"];
	_lbControl lbSetPictureColor [3,[1,1,1,1]];
	_lbControl lbSetPictureColorSelected [3,[1,1,1,1]];

	_lbControl lbSetPicture [4,"Dialogs\artDialog\ring.paa"];
	_lbControl lbSetPictureColor [4,[1,1,1,1]];
	_lbControl lbSetPictureColorSelected [4,[1,1,1,1]];
};

_lbControl lbSetCurSel 0;

[0]call artDialog_fnc_artGetAmmo;

_artMrkLocal = format ["artMrkLocal %1 - %2",clientowner,missionNameSpace getVariable ["artiStrikeCount",0]];
player setVariable ["artMrkLocal",_artMrkLocal] ;

createMarkerLocal [_artMrkLocal,[0,0,0]];
_artMrkLocal setMarkerAlphaLocal 0;
_artMrkLocal setMarkerTypeLocal "mil_destroy_noShadow";
_artMrkLocal setMarkerTextLocal "Artillery Target";

_artMrkRadLocal = format ["artMrkRadLocal %1 - %2",clientowner,missionNameSpace getVariable ["artiStrikeCount",0]];
player setVariable ["artMrkRadLocal",_artMrkRadLocal] ;

createMarkerLocal [_artMrkRadLocal,[0,0,0]];
_artMrkRadLocal setMarkerAlphaLocal 0;
_artMrkRadLocal setMarkershapeLocal "ELLIPSE";
_artMrkRadLocal setMarkerTextLocal "Artillery Target";

[] onMapSingleClick {

	//-------------------------------------------------------------------------------------------------------------
	//	Fire Zone Check
	//-------------------------------------------------------------------------------------------------------------
	_fireZoneCheck = 0;
	_mrkSize = 0;
	
	//If Ammo is viable for Fire Zone Check make Firezone Check
	if (((((missionNameSpace getVariable "fullArti") select lbCurSel (findDisplay 99001 displayCtrl 9900101)) select 2) select lbCurSel (findDisplay 99001 displayCtrl 9900102)) select 3 == "true") then {
		{	
			if (_pos inArea _x) exitWith {_fireZoneCheck = 1;};
			
			if ((getMarkerSize _x) select 0 >= (getMarkerSize _x) select 1) then {
				_mrkSize = (getMarkerSize _x) select 0;
			}
			else {
				_mrkSize = (getMarkerSize _x) select 1;
			};
			
			if (_pos distance2D (getMarkerPos _x) < ((sliderPosition (findDisplay 99001 displayCtrl 9900107)) + _mrkSize)) exitWith {_fireZoneCheck = 2;};
		}forEach (getMissionConfigValue "artiNoFireZones");
	};
	
	//If Position is in No-Fire zone and Ammo not allowed
	if (_fireZoneCheck > 0) exitWith {
		if (_fireZoneCheck == 1) then {
			["Target Position is in No Fire Zone", "Error"] spawn BIS_fnc_guiMessage;
		}
		else {
			["Dispersion Radius is overlapping with No Fire Zone.", "Error"] spawn BIS_fnc_guiMessage;
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
	} forEach (((missionNameSpace getVariable "fullArti") select lbCurSel (findDisplay 99001 displayCtrl 9900101)) select 1);
	
	//Check if position is in Range
	_isInRange = _pos inRangeOfArtillery [_artiArr, ((((missionNameSpace getVariable "fullArti") select lbCurSel (findDisplay 99001 displayCtrl 9900101)) select 2) select lbCurSel (findDisplay 99001 displayCtrl 9900102)) select 0];

	//If not in Range exit function
	if (!_isInRange) exitWith {
		["Target Position is not in Range. Keep in mind that this could also mean the target is to close to the artillery.", "Error"] spawn BIS_fnc_guiMessage;
	};	
	
	(player getVariable "artMrkLocal") setMarkerPosLocal _pos;
	(player getVariable "artMrkLocal") setMarkerAlphaLocal 1;
	(player getVariable "artMrkRadLocal") setMarkerPosLocal _pos;
	
	//"artMrkRadius" setMarkerAlpha 1;
	(player getVariable "artMrkRadLocal") setMarkerPosLocal _pos;
	(player getVariable "artMrkRadLocal") setMarkersizeLocal [(sliderPosition (findDisplay 99001 displayCtrl 9900107)),(sliderPosition (findDisplay 99001 displayCtrl 9900107))];
};