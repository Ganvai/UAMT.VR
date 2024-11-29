private _result = ["Do you want to close the Interface? All inputs will be lost.","Close Window",true,true] call BIS_fnc_guiMessage;

if (_result) then {
	closeDialog 2;
	
	//Check if there is a Marker from an earlier selection
	if (artiMarker != "") then {
		deleteMarker artiMarker;
		artiMarker = "";
	};
	
	artiStatus = 0;
	publicVariable "artiStatus";
};