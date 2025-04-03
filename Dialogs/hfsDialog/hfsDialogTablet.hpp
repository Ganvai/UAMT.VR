class hfsDialogTablet
{
	idd = 99004;
	onLoad = "[_this select 0]execVM 'Dialogs\hfsDialog\fn_hfsInitDialog.sqf';";
	
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
			text = "Helicopter Fire Support";
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
			text = "Element:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};

		class NameTagHi2: NameTagHi1
		{
			idc = 9900402;
			x = safeZoneX + safeZoneW * 0.4125;
			text = "Direction: SOUTH";
		};
	};
	class Controls
	{
		class BtnCall
		{
			type = 1;
			idc = 9900404;
			x = safeZoneX + safeZoneW * 0.4421875;
			y = safeZoneY + safeZoneH * 0.79907408;
			w = safeZoneW * 0.115625;
			h = safeZoneH * 0.03148149;
			style = 0+2;
			text = "Call Heli Fire Support";
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
			action = "[(lbValue [9900401,lbCurSel 9900401]),(sliderPosition 9900403)] spawn hfsDialog_fnc_hfsCallDialog;";
		};
		
		class BtnClose: BtnCall
		{
			idc = 300;
			x = safeZoneX + safeZoneW * 0.74;
			y = safeZoneY + safeZoneH * 0.153;
			w = safeZoneW * 0.027;
			h = safeZoneH * 0.017;
			text = "Close";
			sizeEx = "0.015 / (getResolution select 5)";
			action = "call hfsDialog_fnc_hfsCloseDialog;";
		};
		
		class BtnHelp: BtnClose
		{
			idc = 9900405;
			x = safeZoneX + safeZoneW * 0.705;
			text = "Help";
			action = "call hfsDialog_fnc_hfsDialogHelp;";
		};

		class CtrlHi1
		{
			type = 4;
			idc = 9900401;
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
		};
		
		class CtrlHi2: CtrlHi1
		{
			type = 43;
			idc = 9900403;
			x = safeZoneX + safeZoneW * 0.4125;
			style = 1024;
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			color[] = {0.5843,0.8902,0.349,1};
			colorActive[] = {1,1,1,1};
			sliderStep = 5;
			sliderRange[] = {0, 360};
			sliderPosition = 180;
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			onSliderPosChanged = "params ['_control', '_newValue'];	_insert = 0; switch _newValue do {case 0 : {_insert = 'NORTH';};case 360 : {_insert = 'NORTH';};case 90 : {_insert = 'EAST';};case 180 : {_insert = 'SOUTH';};case 270 : {_insert = 'WEST';};default {_insert = _newValue;};};_text = format ['Direction: %1',_insert];ctrlSetText [9900402, _text];if (markerAlpha (player getVariable ['hfsMrkLocal','']) == 1) then {(player getVariable ['hfsDirMrkLocal','']) setMarkerPos ((getMarkerPos (player getVariable ['hfsMrkLocal',''])) getPos [500,_newValue]);(player getVariable ['hfsDirMrkLocal','']) setMarkerAlpha 1;(player getVariable ['hfsDirMrkLocal','']) setMarkerDir (_newValue + 180);};";
		};
	};
};
