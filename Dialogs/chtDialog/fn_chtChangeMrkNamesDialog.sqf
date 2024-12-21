params ['_control', '_lbCurSel'];

_pickUpMrk = player getVariable "CHT_CallPUMrk";
_dropOffMrk = player getVariable "CHT_CallDOMrk";

_pickUpText = player getVariable "CHT_puMrkTxtClean";
_dropOffText = player getVariable "CHT_doMrkTxtClean";

_heliName = _control lbText _lbCurSel;

_newPickUpTxt = format ["%1 (%2)",_pickUpText,_heliName];
_pickUpMrk setMarkerTextLocal _newPickUpTxt;

_newDropOffTxt = format ["%1 (%2)",_dropOffText,_heliName];
_dropOffMrk setMarkerTextLocal _newDropOffTxt;