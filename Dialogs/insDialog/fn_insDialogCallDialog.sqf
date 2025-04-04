if (getMissionConfigValue "supportCustomAudio" == "true") then {
	(missionNameSpace getVariable ["insMethodObj",objNull]) say3D "msg_insertion";
};

if (missionNameSpace getVariable ["insertionActual",""] == "") then {
	if (getMissionConfigValue "paperInterface" == "true") then {
		_display = createDialog ["insDialogMethodGeneric"];
	}
	else {
		_display = createDialog ["insDialogMethod"];
	};
}
else {
	[] spawn UAMTins_fnc_insDialogEditCancel;
};
