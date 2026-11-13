//------------------------------------------------------------------
//------------------------------------------------------------------
//
//              Civilian Presence Looks
//
//
// Function to create looks for Civilian Presence Modules. Can of
// course be used for groups, but you get the gist.
//
//
// [_unit] call UAMT_fnc_civPresLooks;
//
//------------------------------------------------------------------
//------------------------------------------------------------------
params ["_unit","_loadouts","_uniforms","_vests","_backpack","_headgear","_goggles","_primary","_faces","_voices",["_equipment",false]];


// Apply Loadouts
if (_loadouts !isEqualTo []) then {
    _unit setUnitLoadout selectRandom _loadouts;
};


// Apply Uniforms
if (_uniforms !isEqualTo []) then {
    removeUniform _unit;
    _unit forceAddUniform selectRandom _uniforms;
};

// Apply Headgear
if (_vests !isEqualTo []) then {
    removeVest _unit;
    _unit forceAddUniform selectRandom _vests;
};

// Apply _backpack
if (_backpack !isEqualTo []) then {
    removeVest _unit;
    _unit forceAddUniform selectRandom _backpack;
};

// Apply Headgear
if (_vests !isEqualTo []) then {
    removeBackpack _unit;
    _unit forceAddUniform selectRandom _vests;
};

// Apply Headgear
if (_headgear !isEqualTo []) then {
    removeHeadgear _unit;
    _unit forceAddUniform selectRandom _headgear;
};

// Apply _goggles
if (_goggles !isEqualTo []) then {
    removeGoggles _unit;
    _unit forceAddUniform selectRandom _goggles;
};

// Apply _primary
if (_primary !isEqualTo []) then {
    removeWeaponGlobal _unit;
    _unit forceAddUniform selectRandom _primary;
};

// Apply Face
if (_faces !isEqualTo []) then {
    _face = selectRandom _faces;
    [_unit, _face] remoteExec ["setFace", 0, _unit];
};

// Apply Voice
if (_voices !isEqualTo []) then {
    _voice = selectRandom _voices;
    [_unit, _voice] remoteExec ["setSpeaker", 0, _unit];
};
