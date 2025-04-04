class insDialogMethod
{
	idd = 99101;
	name = "Insertion-Dialog Main";
	
	movingEnable = false;

	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1;
			y = safeZoneY + safeZoneH * 0.1;
			w = safeZoneW * 0.8;
			h = safeZoneH * 0.8;
			style = 48;
			text = "Dialogs\MilitaryInterfaceTablet.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};
		
		class TitleText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.46875;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.05729167;
			h = safeZoneH * 0.02962963;
			style = 2;
			text = "Insertion";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 0;
			
		};
		class TitleLine
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.30364584;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.39270834;
			h = safeZoneH * 0.00092593;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};

		class DivLine_2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.57226563;
			y = safeZoneY + safeZoneH * 0.31423612;
			w = safeZoneW * 0.00195313;
			h = safeZoneH * 0.43923612;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class DivLine_1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.42578125;
			y = safeZoneY + safeZoneH * 0.31423612;
			w = safeZoneW * 0.00195313;
			h = safeZoneH * 0.43923612;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class HL_Vehicle
		{
			type = 0;
			idc = 403;
			x = safeZoneX + safeZoneW * 0.59082032;
			y = safeZoneY + safeZoneH * 0.32291667;
			w = safeZoneW * 0.09179688;
			h = safeZoneH * 0.02951389;
			style = 2;
			text = "Ground Vehicles";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			onLoad = "if (getMissionConfigValue 'insEnableGroundV' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'Ground Vehicles (NA)';};";
		};
		class HL_HaLo
		{
			type = 0;
			idc = 401;
			x = safeZoneX + safeZoneW * 0.3125;
			y = safeZoneY + safeZoneH * 0.32291667;
			w = safeZoneW * 0.09179688;
			h = safeZoneH * 0.02951389;
			style = 2;
			text = "HALO";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			onLoad = "if (getMissionConfigValue 'insEnableHALO' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'HALO (NA)';};";
		};
		class HL_Helo
		{
			type = 0;
			idc = 402;
			x = safeZoneX + safeZoneW * 0.44433594;
			y = safeZoneY + safeZoneH * 0.32291667;
			w = safeZoneW * 0.10644532;
			h = safeZoneH * 0.02951389;
			style = 2;
			text = "Helicopter";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = "0.02 / (getResolution select 5)";
			default = false;
			onLoad = "if (getMissionConfigValue 'insEnableHeli' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'Helicopter (NA)';};";
		};
		
	};
	class Controls
	{
		class BtnDudd
		{
			type = 1;
			idc = 301;
			x = safeZoneX + safeZoneW * 0.000001;
			y = safeZoneY + safeZoneH * 0.000001;
			w = safeZoneW * 0.00000001;
			h = safeZoneH * 0.00000001;
			style = 0+2;
			text = "";
			borderSize = 0;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,0};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0;
			offsetY = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			default = true;
		};

		class BtnClose
		{
			type = 1;
			idc = 300;
			x = safeZoneX + safeZoneW * 0.64635417;
			y = safeZoneY + safeZoneH * 0.25462963;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 0+2;
			text = "Exit";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "closeDialog 0;";
			
		};
		class BtnVehicle
		{
			type = 1;
			idc = 302;
			x = safeZoneX + safeZoneW * 0.58691407;
			y = safeZoneY + safeZoneH * 0.6875;
			w = safeZoneW * 0.10449219;
			h = safeZoneH * 0.03819445;
			style = 0+2;
			text = "Ground Vehicles";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = execVM "scripts\UAMTScripts\insertion\carsSetUp.sqf";
			onLoad = "if (getMissionConfigValue 'insEnableGroundV' == 'false') then {(_this # 0) ctrlEnable false;};";
		};
		class BtnHelicopter
		{
			type = 1;
			idc = 303;
			x = safeZoneX + safeZoneW * 0.44042969;
			y = safeZoneY + safeZoneH * 0.6875;
			w = safeZoneW * 0.11914063;
			h = safeZoneH * 0.03819445;
			style = 0+2;
			text = "Helicopter";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = "closeDialog 0; [] call UAMTins_fnc_insDialogHeloCreate;";
			onLoad = "if (getMissionConfigValue 'insEnableHeli' == 'false') then {(_this # 0) ctrlEnable false;};";
		};
		class BtnHaLo
		{
			type = 1;
			idc = 304;
			x = safeZoneX + safeZoneW * 0.30859375;
			y = safeZoneY + safeZoneH * 0.6875;
			w = safeZoneW * 0.10449219;
			h = safeZoneH * 0.03819445;
			style = 0+2;
			text = "HALO";
			borderSize = 0;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorBackgroundActive[] = {0.302,0.302,0.302,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.005;
			offsetY = 0.005;
			sizeEx = "0.02 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			action = "closeDialog 0; [] call UAMTins_fnc_insDialogHALOCreate;";
			onLoad = "if (getMissionConfigValue 'insEnableHALO' == 'false') then {(_this # 0) ctrlEnable false;};";
		};
		
		class TextHALO
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.31347657;
			y = safeZoneY + safeZoneH * 0.37326389;
			w = safeZoneW * 0.09960938;
			h = safeZoneH * 0.296875;
			style = 16;
			lineSpacing = 0.8;
			text = "High Altitude Low Opening - Parachute jump from aircraft in a height of 6000 to 7000 meters above ground. A slow but relatively silent approach with low visibility in low light conditions. While it is the most silent option, it is very dangerous and needs more coordination of your group.";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {0.902,0.7725,0.9961,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class TextHelo
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.45019532;
			y = safeZoneY + safeZoneH * 0.37326389;
			w = safeZoneW * 0.09960938;
			h = safeZoneH * 0.296875;
			style = 16;
			lineSpacing = 0.8;
			text = "Insertion with helicopters. Loud but fast. You can set individual flight paths and landing zones for each helicopter to attack from multiple sides. Helicopters are easy targets and might be spotted by the enemy. It is advised to land on the Y and patrol into the AO instead of landing on the X.";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {0.902,0.7725,0.9961,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class TextVehicle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.58691407;
			y = safeZoneY + safeZoneH * 0.37326389;
			w = safeZoneW * 0.09960938;
			h = safeZoneH * 0.296875;
			style = 16;
			lineSpacing = 0.8;
			text = "Ground vehicles are the most secure option. Some vehicles provide additional firepower and can carry supplies for you. Vehicle insertion is slow and you can get into ambushes, but they increase your mobility during the mission.";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {0.902,0.7725,0.9961,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		
	};
	
};
