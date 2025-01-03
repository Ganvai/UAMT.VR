/*
	Here you find an extended explanation of what tags you can use:
	https://community.bistudio.com/wiki/FXY_File_Format#Arma_3
*/

if (getMissionConfigValue "radiocodefeature" == "true") then {
	_Radio = player createDiarySubject ["Radio","Radio"];

	_radioString = getMissionConfigValue "radio1M" + "<br/>" + getMissionConfigValue "radio2M" + "<br/>" + getMissionConfigValue "radio3M" + "<br/>" + getMissionConfigValue "radio4M" + "<br/>" + getMissionConfigValue "radio5M" + "<br/>" + getMissionConfigValue "radio6M" + "<br/>" + getMissionConfigValue "radio7M" + "<br/>" + getMissionConfigValue "radio8M" + "<br/>" + getMissionConfigValue "radio9M" + "<br/>" + getMissionConfigValue "radio10M";
	player createDiaryRecord ["Radio",["Radiocodes",_radioString]];
};



_diary = player createDiaryRecord ["Diary", ["Credits", "
mission by: Jan | TOB<br/>
powered by UAMT - Ultimate Arma MilSim Template by Jan | TOB<br/>
Scripts all written or modified and adapted by Jan<br/>
Supply Drop Scripts based on Script by NekyWaiWai.<br/>
Ambient Fly By Scripts based on scripts by Spiderman and Smartgun from TOB and Revo.<br/>
Foggy Breath Script by Xeno.<br/>
Ground Fog Script by Unknown.<br/>
Ambient Vehicle Fire function by IndeedPete.<br/>
Timer Function by Enigx.<br/>
"]];


_Manual = player createDiarySubject ["Manual","UAMT Manual"];

player createDiaryRecord ["Manual",["Mission Control Center","
<font face='PuristaMedium' size=18 color='#fc9700'>Mission Control Center</font><br/>
<br/>
Mission Control Center is an ACE Selfinteract Menu and Zeus Menu enhancement for Zeus and TOC and special Roles.<br/>
You have the options to start and end the Mission, as well as activating special triggers provided by the Missionmaker.<br/>
<br/> 
If the Mission goes on for to long, you can trigger a 'To Be Continued' ending sequence any time.<br/>
<br/>
As this is Arma, sometimes things happen. For these cases, there is the 'Full Heal' option, to revive a Teammate that got Armad.<br/>
That brings you in a pretty powerful position. Keep in mind that this is only for Debug and should not replace your Medics!<br/>
So you have the responsibility of how much fun this mission will be.
<br/>
After starting a Mission via Missionstart the Base Menu is only available when you are in your base. Join in Progress Players or reconnected will be teleported to the base from where they can teleport to their groups.<br/>
<br/>
No matter which option you start, you always have an Ingame Interface double checking your choice!<br/>
<br/>
You can also call in a Supply Drop. The Drop is delivered by Helicopter and drops a crate that works like a Supply Point (see the other chapter for more information). The Supply Drop is pretty powerful and therefor limited to just a few Drops<br/>
You can choose if you want to let the Drop happen on your position or on a Location you can choose on the Map. It will always be marked on the Map and the crates have a smoke or a chemlight depending on the daytime so they are easier to Spot.<br/>
When you have used all available Supply Drops, you will get a Message and the Option is not available anymore in your MCC.
"]];

player createDiaryRecord ["Manual",["Transport","
<font face='PuristaMedium' size=18 color='#fc9700'>Transport</font><br/>
<br/>
You can call a Transport, that will spawn on a given position, fly to a pickup zone to pick your players up and then fly to a Target Location where it will drop you off. 
When all Players are out of the vehicle it will fly automatically back to base.<br/>
<br/>
When you call the Transport the Map will open and you can choose your locations for pickup and target. The area will be checked for a position where the helicopter can land.
It will give a notification when there is no suiteable location close.<br/>
<br/>
There is a timeout in the background running that will close the call when you are taking longer than three minutes to pick a location.<br/>
<br/>
When the Helicopter is on the way to pick you up, the Landing Zone will be marked with a green smoke and a green chemlight.<br/>
<br/>
In the Pickup zone, the Helicopter will wait for your orders to start. They are available in the Mission Control Center under Transport. You will get a message when you can give the starting orders, 
but wait for your team to get in.<br/>
<br/>
If the helicopter ever glitches out, it can be despawned by Zeus. The Script will reset and you can call another transport.<br/>
"]];

player createDiaryRecord ["Manual",["Supply Points and Drop","
<font face='PuristaMedium' size=18 color='#fc9700'>Supply Point</font><br/>
<br/>
You have a Supply Point in your base where you can spawn supply crates fitting to your selected faction. Go up to the Marker on the ground and use ACE-Interaction to spawn the crates you want<br/>
<br/>
Every supply crate is dragable/carryable with ACE and will be automatically filled with the fitting faction equipment. You can load them in any ACE-Cargo Space.<br/>
Alternatively, you can spawn empty Boxes and fill them with Stuff you loaded into your inventory in the Armory!<br/>
<br/>
Even though it is possible, you should never spawn multiple crates without moving the first spawned crate as they will stack and at one point glitch around and kill people.<br/>
<br/>
<font face='PuristaMedium' size=18 color='#fc9700'>Supply Drop</font><br/>
<br/>
All Players with Access to the Mission Control Center can call a Supply Drop is available. The Supply drop will be delivered by Helicopter and will be marked by a Smoke (at Day) or a Chemlight (at night).<br/>
Supply Drops give the same Options as a Supply Point, so you can spawn unlimited Supply Crates to resupply your Players. Its pretty powerful and therefor limited to a small amount given by the Missionmaker<br/>
Supply Drops can be delivered to the position of the Player who is calling the Supply Drop in or be chosen on a Map. Consider this because a Supply Drop hanging in a tree is not much of a help.
"]];

player createDiaryRecord ["Manual",["Base Menu","
<font face='PuristaMedium' size=18 color='#fc9700'>Manual Base Menu</font><br/>
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>How to use</font><br/>
<br/>
The Base Menu is everywhere available before Missionstart (see 'Manual / Mission control Center' for more information) and available in the base after the mission was started.<br/>
<br/>
In the base menu are three options available<br/>
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>1. Teleport</font><br/>
<br/>
Opens a menu to teleport to the available Groups in the game. It is possible to teleport also into vehicles. If there is no place in a vehicle, it will give a message.<br/>
This function is meant for Join in Progress Players.<br/>
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>2. Loadouts</font><br/>
<br/>
Choose your Loadout for your mission. When you choose a loadout, the armory will show only items that are available for your chosen role.<br/>
To choose your loadout, select a loadout from the list and click confirm.<br/>
<br/>
<font face='PuristaMedium' size=14 color='#fc9700'>3. Armory</font><br/>
<br/>
The Armory is an ACE Arsenal where you can choose the equipment available for your selected role.<br/>
<font face='PuristaMedium' size=14 color='#ff0000'>It is ACE Arsenal, you need to refill/change the magazines for your weapon, when you change it, by yourself!</font>
"]];

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