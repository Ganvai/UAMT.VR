if (getMissionConfigValue "supportCustomAudio" == "true") then {
	(missionNameSpace getVariable ["insMethodObj",objNull]) say3D "msg_insertion";
};

if (missionNameSpace getVariable ["insertionActual",""] == "") then {
	if (getMissionConfigValue "paperInterface" == "true") then {
		_display = createDialog ["insDialogMethodPaper"];
	}
	else {
		_display = createDialog ["insDialogMethod"];
	};
}
else {
	if (getMissionConfigValue "paperInterface" == "true") then {
		_display = createDialog ["insDialogEditPaper"];
	}
	else {
	_display = createDialog ["insDialogEdit"];
	};
};
