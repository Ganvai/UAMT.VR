_networkID = clientowner;

_check = false;
_recipients = missionNameSpace getVariable ["UAMT_RadioRecipients",[]];
_check = _recipients findIf { _x == _networkID } > -1;

if (_check == false) then {
	_recipients pushback _networkID;
};

missionNameSpace setVariable ["UAMT_RadioRecipients",_recipients,true];