// Get Values from Interface
_fullArtiIndex = lbCurSel 9900103;
_ammoIndex = lbCurSel 9900104;
_rounds = sliderPosition 9900107;
_dist = sliderPosition 9900108;

// Check for missing Errors
if (_fullArtiIndex == -1) exitWith {["No Artillery Element selected","Cannot Fire"] call BIS_fnc_guiMessage;};

if (_ammoIndex == -1) exitWith {["No ammunition selected","Cannot Fire"] call BIS_fnc_guiMessage;};

if (_rounds == 0) exitWith {["No Rounds","Cannot Fire"] call BIS_fnc_guiMessage;};

if (artiMarker == "") exitWith {["No Traget Position","Cannot Fire"] call BIS_fnc_guiMessage;};
_targetPos = getMarkerPos [artiMarker,true];

// Compose GUI Message
_artiName = (fullArti select _fullArtiIndex) select 0;
_ammoName = (((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 1;
_question = format ["Confirm Fire Mission: %1 with %2 rounds off %3 with  %4 meter distribution radius.",_artiName,_rounds,_ammoName,_dist];

// Confirmation
private _result = [_question,"Confirm Fire Mission","Continue","Abbort"] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

closeDialog 1;

_customAudio = supportCustomAudioMsg;

_supportControlName = supportControlName;

[[_fullArtiIndex,_ammoIndex,_rounds,_dist,_targetPos,_customAudio,_supportControlName,side player],"Dialogs\artilleryDialog\fn_executeFiremission.sqf"] remoteExec ["execVM",2];