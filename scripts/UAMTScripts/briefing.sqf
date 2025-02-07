/*
	Here you find an extended explanation of what tags you can use:
	https://community.bistudio.com/wiki/FXY_File_Format#Arma_3
*/
if ((getUserInfo getPlayerID player) isEqualTo []) exitWith {};

_Manual = player createDiarySubject ["Manual","Mission Features"];


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Credits
//
//------------------------------------------------------------------
//------------------------------------------------------------------

_diary = player createDiaryRecord ["Manual", ["Credits", "
This Mission was build with the UAMT (Ultimate Arma MilSim Template). The template was created by Jan, Smargun and Spiderman from 'The Old Boys' | TOB.<br/>
Although we spend a year working on this, it would have been way longer if there wouldn't have been so many creators who explored things first, published their work and shared it with the community.<br/>
<br/>
Tons of Thanks go out to these legends and the whole Arma Community:<br/>
Supply Drop Scripts based on Script by NekyWaiWai.<br/>
Ambient Fly By Scripts based on scripts by Spiderman and Smartgun from TOB and R3vo.<br/>
Foggy Breath Script by Xeno.<br/>
Ground Fog Script by Unknown.<br/>
Ambient Vehicle Fire function by IndeedPete.<br/>
Timer Function by Enigx.<br/>
"]];

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Radio Codes
//
//------------------------------------------------------------------
//------------------------------------------------------------------


if (getMissionConfigValue "radiocodefeature" == "true") then {
	_radioCodeText = "<font face='PuristaMedium' size=16 color='#fc9700'>Radio Codes</font><br/>
This mission features Radio Codes. All roles are able to send Radio Codes. Everyone who has subscribed to the reading channel will see: 'who', 'the group' and the sent 'Code-Message'.<br/>
This is mostly meant to keep Radiochannels free in larger Missions and was meant to be used especially for the 'Speech Request' message (Standard Code 1- TOC come in).<br/><br/>
You can send a code via ACE-Selfinteraction (STRG+WIN) -> Radiocodes.<br/>
In this menu you can also subscribe or unsubscribe from the reading channel.<br/>
All sent messages are also logged here.<br/><br/>
<font face='PuristaMedium' size=16 color='#fc9700'>Available Codes:</font><br/>";
	_radioCodeText = _radioCodeText + getMissionConfigValue "radio1M" + "<br/>" + getMissionConfigValue "radio2M" + "<br/>" + getMissionConfigValue "radio3M" + "<br/>" + getMissionConfigValue "radio4M" + "<br/>" + getMissionConfigValue "radio5M" + "<br/>" + getMissionConfigValue "radio6M" + "<br/>" + getMissionConfigValue "radio7M" + "<br/>" + getMissionConfigValue "radio8M" + "<br/>" + getMissionConfigValue "radio9M" + "<br/>" + getMissionConfigValue "radio10M";
	player createDiaryRecord ["Manual",["Radiocodes",_radioCodeText]];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Fire Support
//
//------------------------------------------------------------------
//------------------------------------------------------------------
_fireFeatures = "";

if (getMissionConfigValue "artiFeature" == "true") then {
	_featureText =  "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Artillery</font><br/>
Call in Artillery via Interface. You can choose a position on the map, artillery element, ammunition, rounds, firepattern and radius on target.<br/>
Who can call in Artillery:<br/>";

	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "supplyDropRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};

	_fireFeatures = _fireFeatures + _featureText;
};

if (getMissionConfigValue "vlsFeature" == "true") then {
	_featureText =  "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>VLS (Interface)</font><br/>
Call in a VLS (Vertical Launch System) Missile Strike (also known as Cruise Missile). Select ammunition and target position in an Interface and watch 3 million dollars go boom.<br/>
Who can call in VLS via Interface:<br/>";

	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "supplyDropRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};

	if (count (getMissionConfigValue "vlsRolesCMDR") > 0) then {
		_vlsEquipment = "";
		{
			_name = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_vlsEquipment = _vlsEquipment + "- " + _name + "<br/>";
		}forEach (getMissionConfigValue "vlsEquipment");
		
		_featureText = _featureText + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>VLS Call In</font><br/>
VLS can also be called in via eye contact and Equipment. Players with the access to the 'VLS Call In' need special Equipment:<br/>";
		_featureText = _featureText + _vlsEquipment + "<br/>They need to aim with the equipment at the target position. ";
		
		if (getMissionConfigValue "vlsNeedsLaser" == "true") then {
			_featureText = _featureText + "The laser has to be activated. ";
		};
		
		_featureText = _featureText + "<br/>When the target is aquired, they can call in the VLS Strike via ACE-Selfinteract (STRG+WIN). The Missile will hit the position aimed at when called in and will not follow the laser after it was launched. No need to aim at the target after the call. ";

		if (getMissionConfigValue "vlsAllowDrones" == "true") then {
			_featureText = _featureText + "<br/><br/>Drones can be used for this as well and work exactly the same way.<br/>";
		};
		
		_featureText = _featureText + "Roles who can call in VLS via Equipment:<br/>";
		
		_featureGroups = [];
		_featureRoles = [];
		_featurePlayers = [];

		{	
			_role = _x;
			_break = true;
			
			{
				if (_role == groupID _x) then {
					_featureGroups pushback _role;
					_break = false;
				};
			}forEach groups (side player);
			
			if (_break) then {
				{
					if (_role == vehicleVarName _x) then {
						_featurePlayers pushback _role;
						_break = false;
					};		
				}forEach (allPlayers - entities "HeadlessClient_F");
			};
			
			if (_break) then {
					_featureRoles pushback _x;
			};
		
		}forEach (getMissionConfigValue "supplyDropRoles");
		
		if (count _featureGroups > 0) then {
			_featureText = _featureText + "Groups:<br/>";
			{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
		};

		if (count _featureRoles > 0) then {
			_featureText = _featureText + "<br/>Roles:<br/>";
			{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
		};

		if (count _featurePlayers > 0) then {
			_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
			{	
				_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
				_featureText = _featureText + "- " +  _name + "<br/>";
			}forEach _featurePlayers;
		};
	};

	_fireFeatures = _fireFeatures + _featureText;
};

if (getMissionConfigValue "casFeature" == "true") then {
	_featureText =  "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>CAS (Interface)</font><br/>
Call in a CAS Strike by fixedd wing element. Select ammunition and target position in an Interface then set the approach vector for the element.<br/>
Who can call in CAS via Interface:<br/>";

	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "supplyDropRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};

	if (count (getMissionConfigValue "casRolesCMDR") > 0) then {
		_vlsEquipment = "";
		{
			_name = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_vlsEquipment = _vlsEquipment + "- " + _name + "<br/>";
		}forEach (getMissionConfigValue "casEquipment");
		
		_featureText = _featureText + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>CAS via Equipment</font><br/>
CAS can also be called in via eye contact and equipment. Players with the access to the 'CAS Call In' need special Equipment:<br/>";
		_featureText = _featureText + _vlsEquipment + "<br/>They need to aim with the equipment at the target position. ";
		
		if (getMissionConfigValue "vlsNeedsLaser" == "true") then {
			_featureText = _featureText + "The laser has to be activated. ";
		};
		
		_featureText = _featureText + "<br/>When the target is aquired, they can call in the CAS Strike via ACE-Selfinteract (STRG+WIN). The strike will hit the position aimed at when called in and will not follow the laser after it was launched. No need to aim at the target after the call. ";

		if (getMissionConfigValue "vlsAllowDrones" == "true") then {
			_featureText = _featureText + "<br/><br/>Drones can be used for this as well and work exactly the same way.<br/>";
		};
		
		_featureText = _featureText + "Roles who can call in CAS via Equipment:<br/>";
		
		_featureGroups = [];
		_featureRoles = [];
		_featurePlayers = [];

		{	
			_role = _x;
			_break = true;
			
			{
				if (_role == groupID _x) then {
					_featureGroups pushback _role;
					_break = false;
				};
			}forEach groups (side player);
			
			if (_break) then {
				{
					if (_role == vehicleVarName _x) then {
						_featurePlayers pushback _role;
						_break = false;
					};		
				}forEach (allPlayers - entities "HeadlessClient_F");
			};
			
			if (_break) then {
					_featureRoles pushback _x;
			};
		
		}forEach (getMissionConfigValue "supplyDropRoles");
		
		if (count _featureGroups > 0) then {
			_featureText = _featureText + "Groups:<br/>";
			{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
		};

		if (count _featureRoles > 0) then {
			_featureText = _featureText + "<br/>Roles:<br/>";
			{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
		};

		if (count _featurePlayers > 0) then {
			_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
			{	
				_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
				_featureText = _featureText + "- " +  _name + "<br/>";
			}forEach _featurePlayers;
		};
	};

	_fireFeatures = _fireFeatures + _featureText;
};

if (getMissionConfigValue "hfsFeature" == "true") then {
	_featureText =  "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Heli Fire Support (Interface)</font><br/>
Call in a rotary wing element to a position. Select the element, position on the map and the approach vector via Interface.<br/>
Who can call in Helicopters via Interface:<br/>";

	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "supplyDropRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};

	if (count (getMissionConfigValue "casRolesCMDR") > 0) then {
		_vlsEquipment = "";
		{
			_name = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_vlsEquipment = _vlsEquipment + "- " + _name + "<br/>";
		}forEach (getMissionConfigValue "casEquipment");
		
		_featureText = _featureText + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Heli Fire Support (on position)</font><br/>
Heli Fire Support can also be called in quick on the callers position. Use the Option in the ACE-Selfinteraction menu and select the rotary wing element. They will come in to your position and give fire support.<br/>Who can call in Helicopter Fire Support on their position:<br/>";
		
		_featureGroups = [];
		_featureRoles = [];
		_featurePlayers = [];

		{	
			_role = _x;
			_break = true;
			
			{
				if (_role == groupID _x) then {
					_featureGroups pushback _role;
					_break = false;
				};
			}forEach groups (side player);
			
			if (_break) then {
				{
					if (_role == vehicleVarName _x) then {
						_featurePlayers pushback _role;
						_break = false;
					};		
				}forEach (allPlayers - entities "HeadlessClient_F");
			};
			
			if (_break) then {
					_featureRoles pushback _x;
			};
		
		}forEach (getMissionConfigValue "supplyDropRoles");
		
		if (count _featureGroups > 0) then {
			_featureText = _featureText + "Groups:<br/>";
			{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
		};

		if (count _featureRoles > 0) then {
			_featureText = _featureText + "<br/>Roles:<br/>";
			{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
		};

		if (count _featurePlayers > 0) then {
			_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
			{	
				_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
				_featureText = _featureText + "- " +  _name + "<br/>";
			}forEach _featurePlayers;
		};
	};

	_fireFeatures = _fireFeatures + _featureText;
};

if (_fireFeatures != "") then {
	player createDiaryRecord ["Manual",["Fire Support",_fireFeatures]];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Support Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------
_supportFunctions = "";

if (getMissionConfigValue "supplyPointFeature" == "true") then {
	_supplyPointText = "<font face='PuristaMedium' size=16 color='#fc9700'>Supply Points</font><br/>
There are Supply Points on the map where you can spawn unlimited supply crates. These crates hold supplies for the available roles. To use a Supply Point go to it and use the ACE-Interaction (WIN) and then select a crate from the List. The crate will spawn in front of the supply point.<br/>
You can load these crates onto vehicles via ACE-Cargo or (if activated) the loadinVehicle feature from the template.<br/>
Don't spawn to many crates at once, because they will glitch into each other, jump wildly around the area and Arma you.";

	_supportFunctions = _supplyPointText;
};

if (getMissionConfigValue "supplyDropFeature" == "true") then {
	_featureText = "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Supply Drop</font><br/>
The Supply Drop will call a Helicopter that will drop a Supply Box via parachute. At the Supply Box, you can spawn multiple supply crates via ACE-Interaction (WIN).<br/>
When calling in a Supply Drop, you should choose an open and safe position. As this is a parachute drop, they won't land exactly at the chosen position<br/><br/>Who can call in Supply Drops:<br/>";

	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "supplyDropRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};
	
	_supportFunctions = _supportFunctions + _featureText;
};

if (getMissionConfigValue "chtFeature" == "true") then {
	_featureText =  "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Helicopter Transport</font><br/>
Helicopter Transports are available. You can call in a Helicopter that to fly players to a position on the map. You can select a Pick Up location and a Drop Off location.<br/>
At the Pickup location the helicopter will wait until a player in the Helicopter gives the Start Orders via an interaction. The heli will then fly to the Drop Off Location. When all Players are out, the helicopter will fly back to base.<br/>
If there are more helicopters available, you can call every one individually to different locations.<br/><br/>
Who can call in Transport Helicopters:<br/>";
	
	_featureGroups = [];
	_featureRoles = [];
	_featurePlayers = [];

	{	
		_role = _x;
		_break = true;
		
		{
			if (_role == groupID _x) then {
				_featureGroups pushback _role;
				_break = false;
			};
		}forEach groups (side player);
		
		if (_break) then {
			{
				if (_role == vehicleVarName _x) then {
					_featurePlayers pushback _role;
					_break = false;
				};		
			}forEach (allPlayers - entities "HeadlessClient_F");
		};
		
		if (_break) then {
				_featureRoles pushback _x;
		};
	
	}forEach (getMissionConfigValue "chtRoles");
	
	if (count _featureGroups > 0) then {
		_featureText = _featureText + "Groups:<br/>";
		{_featureText = _featureText + "- " + _x + "<br/>";}forEach _featureGroups;
	};

	if (count _featureRoles > 0) then {
		_featureText = _featureText + "<br/>Roles:<br/>";
		{_featureText = _featureText + "- " +  _x + "<br/>";}forEach _featureRoles;
	};

	if (count _featurePlayers > 0) then {
		_featureText = _featureText + "<br/>Players (can always call in no matter their role or group):<br/>";
		{	
			_name = (getUserInfo (getPlayerID (missionNameSpace getVariable [_x,objNull]))) select 4;
			_featureText = _featureText + "- " +  _name + "<br/>";
		}forEach _featurePlayers;
	};

	_supportFunctions = _supportFunctions + _featureText;
};

if (_supportFunctions != "") then {
	player createDiaryRecord ["Manual",["Support Features",_supportFunctions]];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Insertion
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "insFeature" == "true") then {
	_insText = "<font face='PuristaMedium' size=16 color='#fc9700'>Insertion</font><br/>
This Mission has teh Insertion Feacture activated. This means you can select how to get into the Mission AO. In the Insertion Interface you can choose between the following options:";

	if (getMissionConfigValue "insEnableHALO" == "true") then {
		_insText = _insText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'> - HALO</font><br/>
Jump via HALO into the AO. Select a position where you want to drop on the map and from where the HALO aircraft (can be helicopter or plan) should approach. The Pilot of the aircraft will guide you through the process, but you have to jump for yourself.<br/>
<font face='PuristaMedium' size=12 color='#fc9700'>Backpack on Chest for HALO</font><br/>
You don't need the mod 'Backpack on Chest'. If this is not loaded, a crate will be spawned where you can exchange your backpack for a parachute. The crate will be dropped with you at the HALO Dropzone. There you can retrieve your backpack after the jump.";
	};

	if (getMissionConfigValue "insEnableHeli" == "true") then {
		_insText = _insText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'> - Helicopter</font><br/>
Helicopters will fly you into the mission. You can select the Landing Zone for each Helicopter as well as their flight route.";
	};

	if (getMissionConfigValue "insEnableGroundV" == "true") then {
		_insText = _insText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'> - Ground Vehicles</font><br/>
Ground Vehicles are standing ready at the base. You can pack them with supplies and drive them yourself wherever you want to start. You have them available for the rest of the mission.";
	};
	
	_insText = _insText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'>Important to know:</font><br/>
	All Insertions will only start when every Player is in the selected vehicle. For Ground Vehicles, this means they only get fuelled up when all Players are in one of the available cars. Once the mission started, no Insertion is possible.";
	
	player createDiaryRecord ["Manual",["Insertion",_insText]];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Main Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------
_mainFeaturesText = "<font face='PuristaMedium' size=16 color='#fc9700'>Main Features</font><br/>
This mission is based on the UAMT by TOB and will provide a lot of features that you don't know from Arma. Here you get an Overview about everything that will be going on.<br/><br/>";

_mainFeaturesText = _mainFeaturesText + "<font face='PuristaMedium' size=16 color='#fc9700'>Base Menu</font><br/>
The Base Menu gives all Players the most important features when in the base.<br/>
<br/>
To call functions in the Base Menu, use ACE-Selfinteraction (STRG + WIN) and select Base Menu, then select one of the Following functions:
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>1. Teleport</font><br/>
Opens a menu to teleport to the available Groups in the game. It is possible to teleport also into vehicles. If there is no place in a vehicle, it will give a message.<br/>
This function is meant for Join in Progress Players.<br/>
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>2. Reset Loadout</font><br/>
Resets your loadout to the mission default. Usefull to rearm or when you need to undo changes you made.";

if (getMissionConfigValue "allowArmory" == "true") then {
	_mainFeaturesText = _mainFeaturesText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'>3. Armory</font><br/>
The Armory is an ACE Arsenal where you can choose the equipment available for your selected role/loadout.<br/>
<font face='PuristaMedium' size=14 color='#ff0000'>It is ACE Arsenal, you need to refill/change the magazines for your weapon, when you change it, by yourself!</font>";
};

if (getMissionConfigValue "allowLoadouts" == "true") then {
	_mainFeaturesText = _mainFeaturesText + "<br/><br/><font face='PuristaMedium' size=14 color='#fc9700'>4. Loadouts</font><br/>
An Interface where you can choose  your loadout. Every loadout has a specific access to weapons and equipment. Some Loadouts offer special functions, like EODs, Engineers or Medics. Others have access to call in Supports, like CAS, Artillery or Supply Drops. Read more about this in 'Support Functions'.";
};

if (getMissionConfigValue "weaponProficiency" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Weapon Proficiency</font><br/>
In this Mission features a more extensive Role-System. The Loadouts with their specific arsenal and abilities, as well as all the Support Functions that are limited to roles or players are one side. Weapon Proficiency is the other.<br/>
Every role is proficient with the attached weapon class fitting to the role. Riflemans with Assault Rifles, MG-Gunners with MGs and autorifles, AT-Rifleman with Launchers and so on.<br/>
If you are handling the weaponclass you are proficient with, you have more control over the weapon, meaning less recoil and less weapon sway.";
};

if (getMissionConfigValue "loadCargoFeature" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Load Cargo Feature</font><br/>
It was in Arma all along but in this mission, it is at last usable. You can load Containers and Supply Crates on fitting vehicles and transport them. This enables you to even build real logistic chains in the battlefield.";
};

if (getMissionConfigValue "endAllDead" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>End when everybody is Down</font><br/>
Don't waste your screenlife heedlessly. When all players are dead or unconscious, this mission is over";
};

if (getMissionConfigValue "cFcivil" == "true" || getMissionConfigValue "cFfriendlies" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Casualties by Players</font><br/>
Collateral Damage is not a trivial offence. If a soldier kills a civilian or a friendly unit it will be called out and the soldiers has to prepare for serious repercussions.";
};

if (getMissionConfigValue "rVifFeature" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Vehicle IEDs</font><br/>
The enemy is ruthless and uses vehicle IEDs. Be carefull when using or looting enemy vehicles. Better let your EOD check them first.";
};

if (getMissionConfigValue "rifFeature" == "true") then {
	_mainFeaturesText = _mainFeaturesText  + "<br/><br/><font face='PuristaMedium' size=16 color='#fc9700'>Suicide Vests</font><br/>
Some enemies want to take you down under all circumstances and are wearing suicide vests. When you are to close, they will try to use them. Take them out on a distance with headshots. Bodyshots have a high risk of triggering an explosion.<br/><br/>
Obviously looting these enemies is extremely dangerous.";
};

player createDiaryRecord ["Manual",["Main Features",_mainFeaturesText]];
//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Mission Specific Items
//
// In this follow Up Script you can add Mission Specific Configs
// This makes Updating the UAMT to a new Version easier.
//
//------------------------------------------------------------------
//------------------------------------------------------------------
execVM "MissionSpecifics\briefing.sqf";