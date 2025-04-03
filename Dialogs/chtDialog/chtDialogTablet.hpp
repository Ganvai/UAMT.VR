class chtDialogTablet
{
	idd = 99006;
	onLoad = "[_this select 0]execVM 'Dialogs\chtDialog\fn_chtInitDialog.sqf';";
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * -0.00625;
			y = safeZoneY + safeZoneH * 0;
			w = safeZoneW * 1.0125;
			h = safeZoneH * 1;
			style = 48;
			text = "Dialogs\MilitaryInterfaceTablet.paa";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};
		
		class TitleLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.23;
			y = safeZoneY + safeZoneH * 0.15;
			w = safeZoneW * 0.537;
			h = safeZoneH * 0.02;
			style = 2;
			text = "Call Helicopter Transport";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};
		
		class Headline
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.23;
			y = safeZoneY + safeZoneH * 0.17870371;
			w = safeZoneW * 0.537;
			h = safeZoneH * 0.002;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";			
		};

		class BottomLine: Headline
		{
			y = safeZoneY + safeZoneH * 0.79;
		};

		class MapFrame: Headline
		{
			colorBackground[] = {0,0,0,1};
			y = safeZoneY + safeZoneH * 0.25;
			h = safeZoneH * 0.47;			
		};

		class NameTagHi1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.23;
			y = safeZoneY + safeZoneH * 0.19;
			w = safeZoneW * 0.172;
			h = safeZoneH * 0.015;
			style = 2;
			text = "Heli:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};

		class NameTagHi2: NameTagHi1
		{
			x = safeZoneX + safeZoneW * 0.4125;
			text = "Waypoint:";
		};
	};
	
	class Controls
	{
		class BtnCall
		{
			type = 1;
			idc = 9900604;
			x = safeZoneX + safeZoneW * 0.4421875;
			y = safeZoneY + safeZoneH * 0.79907408;
			w = safeZoneW * 0.115625;
			h = safeZoneH * 0.03148149;
			style = 0+2;
			text = "Call Transport";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.102,0.102,0.102,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
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
			action = "[(lbCurSel 9900601)] spawn chtDialog_fnc_chtCallDialog;";
		};
		
		class BtnClose: BtnCall
		{
			idc = 300;
			x = safeZoneX + safeZoneW * 0.74;
			y = safeZoneY + safeZoneH * 0.153;
			w = safeZoneW * 0.027;
			h = safeZoneH * 0.017;
			text = "Close";
			sizeEx = "0.02 / (getResolution select 5)";
			default = false;
			shadow = 0;
			action = "call chtDialog_fnc_chtCloseDialog;";
		};
		
		class BtnHelp: BtnClose
		{
			idc = 9900605;
			x = safeZoneX + safeZoneW * 0.705;
			text = "Help";
			default = false;
			shadow = 0;
			action = "call chtDialog_fnc_chtDialogHelp;";
		};

		class CtrlHi1
		{
			type = 4;
			idc = 9900601;
			x = safeZoneX + safeZoneW * 0.23;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.172;
			h = safeZoneH * 0.025;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			color[] = {0.5843,0.8902,0.349,1};
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.102,0.102,0.102,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.6,0.6,0.6,1};
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
			onLBSelChanged = "params ['_control', '_lbCurSel']; [_control,_lbCurSel] call chtDialog_fnc_chtChangeMrkNamesDialog;";
		};
		
		class CtrlHi2: CtrlHi1
		{
			type = CT_XLISTBOX;
			idc = 9900602;
			x = safeZoneX + safeZoneW * 0.4125;
			sizeEx = "0.02 / (getResolution select 5)";
			deletable = 0;
			fade = 0;
			color[] = {0.5843,0.8902,0.349,1};
			colorActive[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {1,1,1,0.25};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
			soundSelect[] =
			{
				"\A3\ui_f\data\sound\RscListbox\soundSelect",
				0.09,
				1
			};
			style = ST_CENTER + LB_TEXTURES + SL_HORZ + 2;
			shadow = 0;
			arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
			font = "PuristaMedium";
			class Items
			{
				class PickUp
				{
					text = "Set PickUp Position";
					colorText[] = {0.5843,0.8902,0.349,1};
					data = "pickup";
					value = 1;
					default = 1;
				};
				class Destination
				{
					text = "Set Drop Off Position";
					colorText[] = {0.5843,0.8902,0.349,1};
					data = "dropOff";
					value = 2;
					default = 0;
				};
			};
			tooltip = "Select to set pickup or dropzone waypoint on the map";
		};
	};
	
};
