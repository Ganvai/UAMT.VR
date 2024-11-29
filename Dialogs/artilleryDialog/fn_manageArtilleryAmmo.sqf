params ['_control', '_lbCurSel', '_lbSelection'];

_fullArtiIndex = lbCurSel 9900103;
_ammoArtiIndex = _lbCurSel;

ctrlSetText [9900105, 'No Coordinates Set'];
ctrlSetText [9900101, '0 Rounds'];
sliderSetPosition [9900107, 0];

if (_lbCurSel != -1) then {
	ctrlEnable [9900106,true];
	
	_ammoCount = (((fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 2;
	_ammoClass = (((fullArti select _fullArtiIndex) select 2) select _ammoArtiIndex) select 0;
	
	_magSize = getNumber (configFile >> "CfgMagazines" >> _ammoClass >> "count");
	
	_artCount = count ((fullArti select _fullArtiIndex) select 1);
	
	_magsShots = _magSize * _artCount;
	
	_maxRndSlider = 0;
	
	if (_ammoCount > 0 ) then {
		if (_ammoCount> _magsShots) then {
			ctrlEnable [9900107,true];
			sliderSetRange [9900107, 0, _magsShots];
		}
		else {
			ctrlEnable [9900107,true];
			sliderSetRange [9900107, 0, _ammoCount];
		};
	}
	else {
		ctrlEnable [9900107,false];
		ctrlSetText [9900101,'Out of Ammo'];
	};
}
else {
	ctrlEnable [9900106,false];
	ctrlEnable [9900107,false];
	ctrlSetText [9900101,'No Ammo selected'];
};