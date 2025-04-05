class insDialogMethodPaper
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
			x = safeZoneX + safeZoneW * 0.043;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 1;
			h = safeZoneH * 1;
			style = 48;
			text = "Dialogs\ClipboardInterface.paa";
			colorBackground[] = {0.75,0.75,0.75,1};
			colorText[] = {0.75,0.75,0.75,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};
		
		class TitleText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.22;
			w = safeZoneW * 0.30;
			h = safeZoneH * 0.025;
			style = 2;
			text = "Insertion";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 0;
		};
		
		class TitleLine: TitleText
		{
			y = safeZoneY + safeZoneH * 0.245;
			h = safeZoneH * 0.0015;
			colorBackground[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
		};
		
		class DivLine_1: TitleText
		{
			x = safeZoneX + safeZoneW * 0.445;
			y = safeZoneY + safeZoneH * 0.3;
			w = safeZoneW * 0.001;
			h = safeZoneH * 0.39;
			colorBackground[] = {0,0,0,1};
		};
		
		class DivLine_2: DivLine_1
		{
			x = safeZoneX + safeZoneW * 0.555;
		};

		class HL_HaLo: TitleText
		{
			type = 0;
			idc = 401;
			x = safeZoneX + safeZoneW * 0.34;
			y = safeZoneY + safeZoneH * 0.32;
			w = safeZoneW * 0.10;
			h = safeZoneH * 0.03;
			text = "HALO";
			font = "Caveat";
			sizeEx = "0.03 / (getResolution select 5)";
			onLoad = "if (getMissionConfigValue 'insEnableHALO' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'HALO (NA)';};";
		};

		class HL_Helo: HL_HaLo
		{
			idc = 402;
			x = safeZoneX + safeZoneW * 0.45;
			text = "Helicopter";
			onLoad = "if (getMissionConfigValue 'insEnableHeli' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'Helicopter (NA)';};";
		};

		class HL_Vehicle: HL_HaLo
		{
			idc = 403;
			x = safeZoneX + safeZoneW * 0.56;
			text = "Ground Vehicles";
			onLoad = "if (getMissionConfigValue 'insEnableGroundV' == 'false') then {(_this # 0) ctrlsetTextColor [0.3,0.3,0.3,1]; (_this # 0) ctrlsetText 'Ground Vehicles (NA)';};";
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

		class BtnHalo
		{
			type = 1;
			idc = 304;
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.68;
			w = safeZoneW * 0.08;
			h = safeZoneH * 0.03;
			style = 2;
			borderSize = 0;
			colorBackground[] = {0,0,0,0.1};
			colorBackgroundActive[] = {0.502,0.502,0.502,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,0};
			colorText[] = {0,0,0,1};			
			font = "Caveat";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0;
			offsetY = 0;
			sizeEx = "0.03 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			text = "HALO";
			action = "closeDialog 0; [] call UAMTins_fnc_insDialogHALOCreate;";
			onLoad = "if (getMissionConfigValue 'insEnableHALO' == 'false') then {(_this # 0) ctrlEnable false;};";
			default = false;
		};

		class BtnClose: BtnHalo
		{
			idc = 300;
			x = safeZoneX + safeZoneW * 0.628;
			y = safeZoneY + safeZoneH * 0.205;
			w = safeZoneW * 0.022;
			h = safeZoneH * 0.02;
			text = "Close";
			sizeEx = "0.02 / (getResolution select 5)";
			action = "closeDialog 0;";
			default = false;
		};

		class BtnHelicopter: BtnHalo
		{
			idc = 303;
			x = safeZoneX + safeZoneW * 0.46;
			text = "Helicopter";
			action = "closeDialog 0; [] call UAMTins_fnc_insDialogHeloCreate;";
			onLoad = "if (getMissionConfigValue 'insEnableHeli' == 'false') then {(_this # 0) ctrlEnable false;};";
		};
		
		class BtnVehicle: BtnHalo
		{
			idc = 302;
			x = safeZoneX + safeZoneW * 0.57;
			text = "Ground Vehicles";
			action = execVM "scripts\UAMTScripts\insertion\carsSetUp.sqf";
			onLoad = "if (getMissionConfigValue 'insEnableGroundV' == 'false') then {(_this # 0) ctrlEnable false;};";
		};

		class TextHALO
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.34;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.3;
			style = 16+512;
			lineSpacing = 0.8;
			text = "High Altitude Low Opening - Parachute jump from aircraft in a height of 6000 to 7000 meters above ground. A slow but relatively silent approach with low visibility in low light conditions. While it is the most silent option, it is very dangerous and needs more coordination of your group.";
			colorBackground[] = {0.102,0.102,0.102,0};
			colorText[] = {0,0,0,1};
			font = "Caveat";
			sizeEx = "0.025 / (getResolution select 5)";	
		};

		class TextHelo: TextHALO
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.45;
			text = "Insertion with helicopters. Loud but fast. You can set individual flight paths and landing zones for each helicopter to attack from multiple sides. Helicopters are easy targets and might be spotted by the enemy. It is advised to land on the Y and patrol into the AO instead of landing on the X.";
		};

		class TextVehicle: TextHALO
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.56;
			text = "Ground vehicles are the most secure option. Some vehicles provide additional firepower and can carry supplies for you. Vehicle insertion is slow and you can get into ambushes, but they increase your mobility during the mission.";
		};		
	};
};
