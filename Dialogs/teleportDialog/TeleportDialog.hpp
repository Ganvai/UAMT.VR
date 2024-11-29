class teleportDialog
{
	idd = 4321;
	name = "Teleport-Dialog";
	
	movingEnable = false;
	
	class ControlsBackground
	{
		class Background: RscText
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
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
			text = "Teleport";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
		class FrameList
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.31354167;
			y = safeZoneY + safeZoneH * 0.31388889;
			w = safeZoneW * 0.16302084;
			h = safeZoneH * 0.43703704;
			style = 0;
			text = "";
			colorBackground[] = {0.2353,0.9294,0.2667,1};
			colorText[] = {0.7647,0.0706,0.7333,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};	
	};
	class Controls
	{
		class List
		{
			type = 5;
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.3140625;
			y = safeZoneY + safeZoneH * 0.31481482;
			w = safeZoneW * 0.16197917;
			h = safeZoneH * 0.43518519;
			style = 16;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.102,0.102,0.102,1};
			colorSelect[] = {1,1,1,1};
			colorText[] = {0.2275,0.902,0.4118,1};
			font = "PuristaSemiBold";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			onLoad = execVM "Dialogs\teleportDialog\fn_getPlayerGroups.sqf";
			
		};
		class BtnConfirmListChoice
		{
			type = 1;
			idc = 2000;
			x = safeZoneX + safeZoneW * 0.534375;
			y = safeZoneY + safeZoneH * 0.47407408;
			w = safeZoneW * 0.13229167;
			h = safeZoneH * 0.06018519;
			style = 0+2;
			text = "Teleport to Group";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			default = true;
			shadow = 0;
			action = "call UAMTteleport_fnc_teleport;";
		};
		
		class BtnClose
		{
			type = 1;
			idc = 3000;
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			default = false;
			shadow = 0;
			action = "closeDialog 0;";
		};
		
	};
	
};
