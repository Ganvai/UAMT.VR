class sppDialog
{
	idd = 99100;
	onLoad = "[_this select 0]execVM 'Dialogs\sppDialog\fn_initDialog.sqf';";
	
	class ControlsBackground
	{
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.17;
			y = safeZoneY + safeZoneH * 0.13;
			w = safeZoneW * 0.66;
			h = safeZoneH * 0.74;
			style = 0;
			text = "";
			colorBackground[] = {0.102,0.102,0.102,0.6706};
			colorText[] = {0.2078,0.051,0.6824,0};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		
		class Background_solid
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.18;
			y = safeZoneY + safeZoneH * 0.15;
			w = safeZoneW * 0.64;
			h = safeZoneH * 0.7;
			style = 0+80;
			text = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorText[] = {0.2,0.2,0.2,1};
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
			shadow = 1;
		};		
		
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.19;
			y = safeZoneY + safeZoneH * 0.153;
			w = safeZoneW * 0.62;
			h = safeZoneH * 0.03;
			style = 2;
			text = "Supply Point";
			colorBackground[] = {1,1,1,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = "0.03 / (getResolution select 5)";
		};
		
		class TitleLine: Title
		{
			y = safeZoneY + safeZoneH * 0.182;
			h = safeZoneH * 0.001;
			style = 0;
			text = "";
			colorBackground[] = {0.5,0.5,0.5,1};
		};

		class FrameLeft: RscFrame
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.19;
			y = safeZoneY + safeZoneH * 0.19;
			w = safeZoneW * 0.3;
			h = safeZoneH * 0.6;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {1,1,1,1};
			text = "Arsenal";
			font = "PuristaMedium";
			sizeEx = "0.02 / (getResolution select 5)";
		};
		
		class FrameRight: FrameLeft
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.51;
			text = "Crate Inventory";
		};
	};
	
	class Controls
	{ 
		class BtnClose
		{
			type = 1;
			idc = 201;
			x = safeZoneX + safeZoneW * 0.77;
			y = safeZoneY + safeZoneH * 0.158;
			w = safeZoneW * 0.04;
			h = safeZoneH * 0.02;
			style = 2;
			text = "Close";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.1,0.1,0.1,1};
			colorText[] = {0.8,0.8,0.8,1};
			font = "PuristaMedium";
			offsetPressedX = 0.005;
			offsetPressedY = 0.005;
			offsetX = 0.001;
			offsetY = 0.001;
			sizeEx = "0.015 / (getResolution select 5)";
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			action = "call sppDialog_fnc_closeSupplyPoint";
		};
		
		class BtnExecute: BtnClose
		{
			type = 1;
			idc = 203;
			x = safeZoneX + safeZoneW * 0.425;
			y = safeZoneY + safeZoneH * 0.8;
			w = safeZoneW * 0.15;
			h = safeZoneH * 0.035;
			sizeEx = "0.03 / (getResolution select 5)";
			text = "Get Cargo Crate";
			action = "call sppDialog_fnc_getBox";
		};
		
		
		class GroupFilt
		{
			type = 4;
			idc = 101;
			x = safeZoneX + safeZoneW * 0.195;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1425;
			h = safeZoneH * 0.025;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.1,0.1,0.1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,1,1,1};
			colorSelectBackground[] = {0.5,0.5,0.5,1};
			colorText[] = {0.702,0.702,0.702,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = "0.023 / (getResolution select 5)";
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
			tooltip = "Filter Equipment by Groups in the field";
			onLBSelChanged = "call sppDialog_fnc_groupFilter";
		};
		class RoleFilt: GroupFilt
		{
			type = 4;
			idc = 102;
			x = safeZoneX + safeZoneW * 0.3425;
			tooltip = "Filter Equipment by available Roles";
			onLBSelChanged = "call sppDialog_fnc_arsenalList";
		};

		class FrameToolbox
		{
			idc = 103;
			x = safeZoneX + safeZoneW * 0.21;
			y = safeZoneY + safeZoneH * 0.24;
			w = safeZoneW * 0.26;
			h = safeZoneH * 0.03;
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			type = 6;
			style= 48;
			colorText[] = {0.95,0.95,0.95,1};
			color[] = {0.95,0.95,0.95,1};
			colorTextSelect[] = {0.95,0.95,0.95,1};
			colorSelect[] = {0.95,0.95,0.95,1};
			colorTextDisable[] = {0.4,0.4,0.4,1};
			colorDisable[] = {0.4,0.4,0.4,1};
			colorSelectedBg[] =
			{
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
				0.5
			};
			shadow = 0;
			strings[] =
			{
				"a3\ui_f_curator\data\displays\rscdisplaycurator\modemodules_ca.paa",
				"a3\ui_f_curator\data\displays\rscdisplaycurator\modeunits_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomag_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargothrow_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoput_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\itemoptic_ca.paa",
				"a3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa",
				"a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomisc_ca.paa"
			};
			values[] = 
			{
				0,
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8				
			};
			rows = 1;
			columns = 9;
			onToolBoxSelChanged = "call sppDialog_fnc_arsenalList";
		};
		
		class ArsenalLB: ctrlListbox
		{
			type = 5;
			idc = 104;
			x = safeZoneX + safeZoneW * 0.195;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.29;
			h = safeZoneH * 0.51;
			style = 16;
			colorBackground[] = {0.3,0.3,0.3,1};
			colorSelectBackground[] = {0,0,0,1};
			colorSelectBackground2[] = {0,0,0,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.702,0.702,0.702,1};
			colorPicture[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			wholeHeight = 0.3;
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
			onLBSelChanged = "[108,_this select 1] call sppDialog_fnc_manageFocus";
		};
		
		class BoxSelect: GroupFilt
		{
			type = 4;
			idc = 105;
			x = safeZoneX + safeZoneW * 0.515;
			tooltip = "Select a box type in which you equipment is stored.\nBox types differ in their load capacity,\nbut depending on the size of the box,\nyou may not be able to load it into smaller vehicles.";
			onLBSelChanged = "call sppDialog_fnc_createBox";
		};
		
		class Weight
		{
			type = 0;
			idc = 113;
			x = safeZoneX + safeZoneW * 0.6575;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.05;
			h = safeZoneH * 0.025;
			style = 0;
			text = "Weight:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.5,0.5,0.5,1};
			font = "PuristaMedium";
			sizeEx = "0.023 / (getResolution select 5)";
			tooltip = "Shows weight of the box.\nColor indicates if it can be carried,\ndragged or not be moved at all.";
		};
		
		class BoxStatus: Weight
		{
			type = 0;
			x = safeZoneX + safeZoneW * 0.708;
			w = safeZoneW * 0.095;
			style = 1;
			idc = 106;
			text = "0lb";
			tooltip = "Box can be carried";
		};
		
		class BoxLoad
		{
			type = 8;
			idc = 107;
			x = safeZoneX + safeZoneW * 0.515;
			y = safeZoneY + safeZoneH * 0.24;
			w = safeZoneW * 0.29;
			h = safeZoneH * 0.03;
			style = 0;
			colorBar[] = {0.902,0.902,0.902,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			tooltip = "Shows load status of the chosen box type.\nSome boxey can carry more than others,\nbut look out for the weight.\nIf its to heavy, it can not be moved.";
		};
		
		class InventoryLB: ArsenalLB
		{
			type = 5;
			idc = 108;
			x = safeZoneX + safeZoneW * 0.515;
			onLBSelChanged = "[104,_this select 1] call sppDialog_fnc_manageFocus";
		};
		
		class PlusTen
		{
			type = 1;
			idc = 109;
			x = safeZoneX + safeZoneW * 0.491;
			y = safeZoneY + safeZoneH * 0.4;
			w = safeZoneW * 0.018;
			h = safeZoneH * 0.03;
			style = 48;
			text = "\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa";
			tooltip = "+ 10";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
			colorText[] = {1,1,1,1};
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
			onButtonClick = "[10] call sppDialog_fnc_addItem";
		};
		
		class PlusOne: PlusTen
		{
			idc = 110;
			y = safeZoneY + safeZoneH * 0.435;
			text = "";
			tooltip = "+ 1";
			onButtonClick = "[1] call sppDialog_fnc_addItem";
		};
		
		class MinusOne: PlusTen
		{
			idc = 111;
			y = safeZoneY + safeZoneH * 0.47;
			text = "";
			tooltip = "- 1";
			onButtonClick = "[-1] call sppDialog_fnc_addItem";
		};
		
		class MinusTen: PlusTen
		{
			idc = 112;
			y = safeZoneY + safeZoneH * 0.505;
			text = "\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_ca.paa";
			tooltip = "- 10";
			onButtonClick = "[-10] call sppDialog_fnc_addItem";
		};
	};	
};
