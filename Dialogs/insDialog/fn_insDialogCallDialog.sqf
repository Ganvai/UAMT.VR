if (getMissionConfigValue "supportCustomAudio" == "true") then {
	(missionNameSpace getVariable ["insMethodObj",objNull]) say3D "msg_insertion";
};

if (missionNameSpace getVariable ["insertionActual",""] == "") then {
	createDialog "insDialogMethod";
}
else {
	createDialog "insDialogEdit";
};
