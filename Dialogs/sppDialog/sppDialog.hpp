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
			x = safeZoneX + safeZoneW * 0.175;
			y = safeZoneY + safeZoneH * -0.05277777;
			w = safeZoneW * 0.65;
			h = safeZoneH * 1.0962963;
			style = 48;
			text = "Dialogs\Military_Interface.paa";
			colorBackground[] = {1,1,1,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.296875;
			y = safeZoneY + safeZoneH * 0.23333334;
			w = safeZoneW * 0.40520834;
			h = safeZoneH * 0.02962963;
			style = 2;
			text = "Supply Point";
			colorBackground[] = {1,1,1,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TitleLine
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29010417;
			y = safeZoneY + safeZoneH * 0.27037038;
			w = safeZoneW * 0.42083334;
			h = safeZoneH * 0.00092593;
			style = 0;
			text = "";
			colorBackground[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.3137,0.5373,0.2314,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class FrameLeft: RscFrame
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.2890625;
			y = safeZoneY + safeZoneH * 0.272;
			w = safeZoneW * 0.19895834;
			h = safeZoneH * 0.454;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {1,1,1,1};
			text = "Arsenal";
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85);
			
		};
		class FrameRight: RscFrame
		{
			idc = 0;
			x = safeZoneX + safeZoneW * 0.51197917;
			y = safeZoneY + safeZoneH * 0.272;
			w = safeZoneW * 0.19895834;
			h = safeZoneH * 0.454;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorText[] = {1,1,1,1};
			text = "Crate Inventory";
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85);
			
		};
		
	};
	class Controls
	{
		class BtnClose
		{
			type = 1;
			idc = 201;
			x = safeZoneX + safeZoneW * 0.6578125;
			y = safeZoneY + safeZoneH * 0.23611112;
			w = safeZoneW * 0.04635417;
			h = safeZoneH * 0.02222223;
			style = 0+2;
			text = "Close";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
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
			shadow = 0;
			onButtonClick = "call sppDialog_fnc_closeSupplyPoint";
		};
		class BtnExecute
		{
			type = 1;
			idc = 203;
			x = safeZoneX + safeZoneW * 0.4375;
			y = safeZoneY + safeZoneH * 0.73981482;
			w = safeZoneW * 0.12604167;
			h = safeZoneH * 0.03148149;
			style = 2;
			text = "Get Cargo Crate";
			borderSize = 0;
			colorBackground[] = {0.302,0.302,0.302,1};
			colorBackgroundActive[] = {0.6,0.6,0.6,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0.5843,0.8902,0.349,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.5843,0.8902,0.349,1};
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
			shadow = 0;
			onButtonClick = "call sppDialog_fnc_getBox";
		};
		class GroupFilt
		{
			type = 4;
			idc = 101;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.090625;
			h = safeZoneH * 0.02222223;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.1,0.1,0.1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.702,0.702,0.702,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
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
			onLBSelChanged = "call sppDialog_fnc_groupFilter";
		};
		class RoleFilt
		{
			type = 4;
			idc = 102;
			x = safeZoneX + safeZoneW * 0.39270834;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.090625;
			h = safeZoneH * 0.02222223;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.1,0.1,0.1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.702,0.702,0.702,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
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
			onLBSelChanged = "call sppDialog_fnc_arsenalList";
		};
		class FrameToolbox
		{
			idc = 103;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.3175926;
			w = safeZoneW * 0.18958334;
			h = safeZoneH * 0.02777778;
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
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.35185186;
			w = safeZoneW * 0.18958334;
			h = safeZoneH * 0.3675926;
			style = 16;
			colorBackground[] = {0.2,0.2,0.2,1};
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
		class BoxSelect
		{
			type = 4;
			idc = 105;
			x = safeZoneX + safeZoneW * 0.51666667;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.117;
			h = safeZoneH * 0.02222223;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.1,0.1,0.1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorSelectBackground[] = {0.3,0.3,0.3,1};
			colorText[] = {0.702,0.702,0.702,1};
			colorPicture[] = {1,1,1,1};
			colorPictureSelect[] = {1,1,1,1};
			colorPictureSelected[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
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
			onLBSelChanged = "call sppDialog_fnc_createBox";
		};
		class Weight
		{
			type = 0;
			idc = 113;
			x = safeZoneX + safeZoneW * 0.635;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.03;
			h = safeZoneH * 0.02222223;
			style = 0;
			text = "Weight: ";
			colorBackground[] = {0.302,0.302,0.302,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			tooltip = "Box is carriable";
		};
		class BoxStatus
		{
			type = 0;
			idc = 106;
			x = safeZoneX + safeZoneW * 0.668;
			y = safeZoneY + safeZoneH * 0.29074075;
			w = safeZoneW * 0.035;
			h = safeZoneH * 0.02222223;
			style = 1;
			text = "0lb";
			colorBackground[] = {0.302,0.302,0.302,0};
			colorText[] = {0.5843,0.8902,0.349,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			tooltip = "Box is carriable";
		};
		class BoxLoad
		{
			type = 8;
			idc = 107;
			x = safeZoneX + safeZoneW * 0.51666667;
			y = safeZoneY + safeZoneH * 0.32222223;
			w = safeZoneW * 0.18958334;
			h = safeZoneH * 0.01851852;
			style = 0;
			colorBar[] = {0.902,0.902,0.902,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		class InventoryLB
		{
			type = 5;
			idc = 108;
			x = safeZoneX + safeZoneW * 0.51666667;
			y = safeZoneY + safeZoneH * 0.35185186;
			w = safeZoneW * 0.18958334;
			h = safeZoneH * 0.3675926;
			style = 16;
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.5843,0.8902,0.349,1};
			colorText[] = {0.502,0.502,0.502,1};
			font = "PuristaMedium";
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
			onLBSelChanged = "[104,_this select 1] call sppDialog_fnc_manageFocus";
		};
		class PlusTen
		{
			type = 1;
			idc = 109;
			x = safeZoneX + safeZoneW * 0.49114584;
			y = safeZoneY + safeZoneH * 0.43055556;
			w = safeZoneW * 0.01822917;
			h = safeZoneH * 0.02222223;
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			onButtonClick = "[10] call sppDialog_fnc_addItem";
		};
		class PlusOne
		{
			type = 1;
			idc = 110;
			x = safeZoneX + safeZoneW * 0.49114584;
			y = safeZoneY + safeZoneH * 0.45833334;
			w = safeZoneW * 0.01822917;
			h = safeZoneH * 0.02222223;
			style = 48;
			text = "";
			tooltip = "+ 1";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			onButtonClick = "[1] call sppDialog_fnc_addItem";
		};
		class MinusOne
		{
			type = 1;
			idc = 111;
			x = safeZoneX + safeZoneW * 0.49114584;
			y = safeZoneY + safeZoneH * 0.49537038;
			w = safeZoneW * 0.01822917;
			h = safeZoneH * 0.02222223;
			style = 48;
			text = "";
			tooltip = "- 1";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			onButtonClick = "[-1] call sppDialog_fnc_addItem";
		};
		class MinusTen
		{
			type = 1;
			idc = 112;
			x = safeZoneX + safeZoneW * 0.49114584;
			y = safeZoneY + safeZoneH * 0.52314815;
			w = safeZoneW * 0.01822917;
			h = safeZoneH * 0.02222223;
			style = 48;
			text = "\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_ca.paa";
			tooltip = "- 10";
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
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			shadow = 0;
			onButtonClick = "[-10] call sppDialog_fnc_addItem";
		};
	};	
};
