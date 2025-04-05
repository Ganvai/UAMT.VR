class insDialogCratePaper
{
	idd = 99102;
	
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
			text = "Cancel Insertion";
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
	};
	
	class Controls
	{
		// Nametags
		class NameTag1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.36;
			y = safeZoneY + safeZoneH * 0.26;
			w = safeZoneW * 0.28;
			h = safeZoneH * 0.13;
			style = 16+512;
			lineSpacing = 0.8;
			text = "Here you can store your Backpack for the HALO jump and recieve a parachute. This crate will be dropped with you in you drop zone. After the jump, you can collect your backpack from it again. If you need to change anything in your loadout, you can get your backpack back here and store it again after you made your changes.";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0,0,0,1};
			font = "Caveat";
			sizeEx = "0.025 / (getResolution select 5)";			
		};
		
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
		
		class BtnStore
		{
			type = 1;
			idc = 9910503;
			x = safeZoneX + safeZoneW * 0.39;
			y = safeZoneY + safeZoneH * 0.395;
			w = safeZoneW * 0.22;
			h = safeZoneH * 0.03;
			style = 2;
			borderSize = 0;
			colorBackground[] = {0,0,0,0.05};
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
			sizeEx = "0.04 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			default = false;
			text = "Store Backpack & recieve Parachute";
			action = "[] spawn UAMTins_fnc_insDialogDCSaveBackpack";
		};

		class BtnGet: BtnStore
		{
			idc = 9910504;
			y = safeZoneY + safeZoneH * 0.47;
			text = "Get Backpack back & store Parachute";
			action = "[] spawn UAMTins_fnc_insDialogDCgetBackpack";
		};
		
		class BtnClose: BtnStore
		{
			idc = 300;
			x = safeZoneX + safeZoneW * 0.628;
			y = safeZoneY + safeZoneH * 0.205;
			w = safeZoneW * 0.022;
			h = safeZoneH * 0.02;
			colorBackground[] = {0,0,0,0};
			text = "Close";
			sizeEx = "0.02 / (getResolution select 5)";
			action = "closeDialog 0;";
		};
	};
};
