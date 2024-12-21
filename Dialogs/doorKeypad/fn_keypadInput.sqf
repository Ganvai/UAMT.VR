params ["_pad","_house","_code","_doors","_target","_actionID"];

_display = createDialog ["doorKeypad",true];

playSound3D ["A3\Sounds_F_Orange\MissionSFX\orange_PeriodSwitch_Notification.wss",_pad];

_pad setVariable ["_pad",_pad,true];
_pad setVariable ["_house",_house,true];
_pad setVariable ["_code",_code,true];
_pad setVariable ["_doors",_doors,true];
_pad setVariable ["_target",_target,true];
_pad setVariable ["_actionID",_actionID,true];


