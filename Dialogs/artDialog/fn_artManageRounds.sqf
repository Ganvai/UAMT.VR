params ['_lbCurSel'];

_fullArti = missionNameSpace getVariable "fullArti";
_sliderControl = findDisplay 99001 displayCtrl 9900103;
_artControl = findDisplay 99001 displayCtrl 9900101;

_fullArtiIndex = lbCurSel _artControl;
_ammoArtiIndex = _lbCurSel;

_sliderOld = sliderPosition _sliderControl;

_ammoCount = (((_fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 2;
_ammoClass = (((_fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 0;

_magSize = getNumber (configFile >> "CfgMagazines" >> _ammoClass >> "count");

_artCount = count ((_fullArti select _fullArtiIndex) select 1);

_magsShots = _magSize * _artCount;

_maxRndSlider = 0;

if (_ammoCount > 0 ) then {
	if (_ammoCount> _magsShots) then {
		_sliderControl sliderSetRange [0, _magsShots];
	}
	else {
		_sliderControl sliderSetRange [0, _ammoCount];
	};
}
else {
	_sliderControl sliderSetRange [0, 0];
	findDisplay 99001 displayCtrl 9900104 ctrlSetText ['Out of Ammo'];
};

if (_sliderOld > (sliderRange _sliderControl) select 1) then {
	_sliderControl sliderSetPosition (sliderRange _sliderControl) select 1;
	_text = format ['%1 Rounds',(sliderRange _sliderControl) select 1];
	findDisplay 99001 displayCtrl 9900104 ctrlSetText _text;
}
else {
	_sliderControl sliderSetPosition _sliderOld;
};