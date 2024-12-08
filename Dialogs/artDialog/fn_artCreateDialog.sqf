if (artiStatus > 0) exitWith {
	switch artiStatus do {
		case 1 : {["No Artillery Strike available. Another Player is currently ordering an artillery strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["No Artillery Strike available. Artillery is currently executing a strike", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["No Artillery Strike available. Artillery is reloading and will be available shortly", "Error"] call BIS_fnc_guiMessage;};
	};
};

createDialog "artDialog";

_map = findDisplay 99001 ctrlCreate ["RscMapControl", -1];
_map ctrlMapSetPosition [safeZoneX + safeZoneW * 0.297,safeZoneY + safeZoneH * 0.329,safeZoneW * 0.406,safeZoneH * 0.333];

artiStatus = 1;
publicVariable "artiStatus";

{
	lbAdd [9900101, _x select 0];
} forEach fullArti;

[] spawn {
	lbSetPictureColor [9900105,0,[1,1,1,1]];
	lbSetPictureColorSelected [9900105,0,[1,1,1,1]];
	
	lbSetPicture [9900105,1,"Dialogs\artDialog\extended.paa"];
	lbSetPictureColor [9900105,1,[1,1,1,1]];
	lbSetPictureColorSelected [9900105,1,[1,1,1,1]];

	lbSetPicture [9900105,2,"Dialogs\artDialog\area.paa"];
	lbSetPictureColor [9900105,2,[1,1,1,1]];
	lbSetPictureColorSelected [9900105,2,[1,1,1,1]];

	lbSetPicture [9900105,3,"Dialogs\artDialog\inverted.paa"];
	lbSetPictureColor [9900105,3,[1,1,1,1]];
	lbSetPictureColorSelected [9900105,3,[1,1,1,1]];

	lbSetPicture [9900105,4,"Dialogs\artDialog\ring.paa"];
	lbSetPictureColor [9900105,4,[1,1,1,1]];
	lbSetPictureColorSelected [9900105,4,[1,1,1,1]];
};

lbSetCurSel [9900101,0];

[0]call artDialog_fnc_artGetAmmo;

createMarker ["artMrk",[0,0,0]];
"artMrk" setMarkerAlpha 0;
"artMrk" setMarkerType "mil_destroy_noShadow";
"artMrk" setMarkerText "Artillery Target";

createMarker ["artMrkRadius",[0,0,0]];
"artMrkRadius" setMarkerAlpha 0;
"artMrkRadius" setMarkershape "ELLIPSE";
"artMrkRadius" setMarkerText "Artillery Target";

[] onMapSingleClick {

	//-------------------------------------------------------------------------------------------------------------
	//	Fire Zone Check
	//-------------------------------------------------------------------------------------------------------------
	_fireZoneCheck = 0;
	_mrkSize = 0;
	
	//If Ammo is viable for Fire Zone Check make Firezone Check
	if ((((fullArti select lbCurSel 9900101) select 2) select lbCurSel 9900102) select 3 == "true") then {
		{	
			if (_pos inArea _x) exitWith {_fireZoneCheck = 1;};
			
			if ((getMarkerSize _x) select 0 >= (getMarkerSize _x) select 1) then {
				_mrkSize = (getMarkerSize _x) select 0;
			}
			else {
				_mrkSize = (getMarkerSize _x) select 1;
			};
			
			if (_pos distance2D (getMarkerPos _x) < ((sliderPosition 9900107) + _mrkSize)) exitWith {_fireZoneCheck = 2;};
		}forEach artiNoFireZones;
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
	} forEach ((fullArti select lbCurSel 9900101) select 1);
	
	//Check if position is in Range
	_isInRange = _pos inRangeOfArtillery [_artiArr, (((fullArti select lbCurSel 9900101) select 2) select lbCurSel 9900102) select 0];

	//If not in Range exit function
	if (!_isInRange) exitWith {
		["Target Position is not in Range", "Error"] spawn BIS_fnc_guiMessage;
	};	
	
	"artMrk" setMarkerPos _pos;
	"artMrk" setMarkerAlpha 1;
	"artMrkRadius" setMarkerPos _pos;
	
	//"artMrkRadius" setMarkerAlpha 1;
	"artMrkRadius" setMarkerPos _pos;
	"artMrkRadius" setMarkersize [(sliderPosition 9900107),(sliderPosition 9900107)];
};

sleep 1;

if (findDisplay 99001 == displayNull) then {
	onMapSingleClick "";
	deleteMarker "artMrkRadius";
	deleteMarker "artMrk";
	artiStatus = 0;
	publicVariable "artiStatus";
};