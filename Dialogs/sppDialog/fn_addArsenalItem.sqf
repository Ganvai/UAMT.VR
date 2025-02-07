disableSerialization;
params ["_control","_itemClass","_itemDisplayName","_itemPicture","_itemTooltip"];

if (_itemClass != "") then {
	_index = _control lbAdd _itemDisplayName;
	_control lbSetData [_index, _itemClass];
	_control lbSetPictureRight [_index, _itemPicture];
	_control lbSetPictureRightColor [_index,[1,1,1,1]];
	_control lbSetPictureRightColorSelected [_index,[1,1,1,1]];
	_control lbSetTooltip [_index,_itemTooltip];
};