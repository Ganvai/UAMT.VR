_networkID = clientowner;

_recipients = missionNameSpace getVariable ["UAMT_RadioRecipients",[]];

_recipients = _recipients - [_networkID];

missionNameSpace setVariable ["UAMT_RadioRecipients",_recipients,true];