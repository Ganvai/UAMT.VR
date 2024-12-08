params ['_lbCurSel'];

_fullArtiIndex = lbCurSel 9900101;
_ammoArtiIndex = _lbCurSel;

_sliderOld = sliderPosition 9900103;

_ammoCount = (((fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 2;
_ammoClass = (((fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 0;

_magSize = getNumber (configFile >> "CfgMagazines" >> _ammoClass >> "count");

_artCount = count ((fullArti select _fullArtiIndex) select 1);

_magsShots = _magSize * _artCount;

_maxRndSlider = 0;

if (_ammoCount > 0 ) then {
	if (_ammoCount> _magsShots) then {
		sliderSetRange [9900103, 0, _magsShots];
	}
	else {
		sliderSetRange [9900103, 0, _ammoCount];
	};
}
else {
	sliderSetRange [9900103, 0, 0];
	ctrlSetText [9900104,'Out of Ammo'];
};

if (_sliderOld > (sliderRange 9900103) select 1) then {
	sliderSetPosition [9900103, (sliderRange 9900103) select 1];
	_text = format ['%1 Rounds',(sliderRange 9900103) select 1];
	ctrlSetText [9900104, _text];
}
else {
	sliderSetPosition [9900103, _sliderOld];
};