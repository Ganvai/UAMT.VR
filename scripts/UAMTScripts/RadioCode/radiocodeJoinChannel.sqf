_networkID = clientowner;

_check = false;
_check = recipients findIf { _x == _networkID } > -1;

if (_check == false) then {
	recipients pushback _networkID;
};

publicVariable "recipients";