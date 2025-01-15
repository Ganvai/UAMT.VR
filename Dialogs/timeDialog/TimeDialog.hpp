class TimeDialog
{
	idd = 112233;
	name = "Time-Dialog";
	
	movingEnable = false;
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.18875;
			y = safeZoneY + safeZoneH * -0.00888888;
			w = safeZoneW * 0.624375;
			h = safeZoneH * 1.04333334;
			style = 0+48;
			text = "Dialogs\Military_Interface.paa";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class TitleText
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.44433594;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.10644532;
			h = safeZoneH * 0.02951389;
			style = 2;
			text = "Operation Time";
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
		class FrameBtnClose
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.64583334;
			y = safeZoneY + safeZoneH * 0.25370371;
			w = safeZoneW * 0.04800001;
			h = safeZoneH * 0.02507408;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
		};
		class FrameBtnConfirm
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.53385417;
			y = safeZoneY + safeZoneH * 0.47314815;
			w = safeZoneW * 0.13333334;
			h = safeZoneH * 0.06303704;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			
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
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.2353,0.9294,0.2667,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.2353,0.9294,0.2667,1};
			font = "PuristaMedium";
			offsetPressedX = 0.001;
			offsetPressedY = 0.001;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 0.001) / 0.001) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;			
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
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.2353,0.9294,0.2667,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.2353,0.9294,0.2667,1};
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
			action = "closeDialog 0;";			
		};
		
		class BtnConfirmListChoice
		{
			type = 1;
			idc = 200;
			x = safeZoneX + safeZoneW * 0.534375;
			y = safeZoneY + safeZoneH * 0.47407408;
			w = safeZoneW * 0.13229167;
			h = safeZoneH * 0.06018519;
			style = 0+2;
			text = "Set Time";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.2353,0.9294,0.2667,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.2353,0.9294,0.2667,1};
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
			action = execVM "Dialogs\timeDialog\setTime.sqf";
		};

		class ComboTime
		{
			type = 4;
			idc = 112;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.46875;
			w = safeZoneW * 0.16796875;
			h = safeZoneH * 0.05555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.6157,0.8667,0.4235,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.3843,0.1333,0.5765,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = "0.02 / (getResolution select 5)";
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLoad = execVM "Dialogs\timeDialog\timelist.sqf";
		};
		
	};
	
};
