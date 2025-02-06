
class sppDialog
{
    idd = 99100;
    class ControlsBackground
    {
        class Background: RscText
        {
            x = safezoneX + 0.2 * safezoneW;
            y = safezoney + 0.1 * safezoneH;
            w = 0.6 * safezonew;
            h = 0.8 * safezoneH;
			colorBackground[] = {0.2, 0.2, 0.2, 1};
        };
        class frame: RscFrame
        {
            x = safezoneX + 0.21 * safezoneW;
            y = safezoney + 0.11 * safezoneH;
            w = 0.58 * safezonew;
            h = 0.78 * safezoneH;
        };
		class BackgroundArsenalList: RscText
		{
            x = safezoneX + 0.22 * safezoneW;
            y = safezoney + 0.25 * safezoneH;
            w = 0.25 * safezonew;
            h = 0.55 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.8};
		};
        class frameArs: RscFrame
        {
            x = safezoneX + 0.222 * safezoneW;
            y = safezoney + 0.25 * safezoneH;
            w = 0.247 * safezonew;
            h = 0.547 * safezoneH;
			text = "Arsenal";
			sizeEx = 0.03;
        };

		class BackgroundInventoryList: RscText
		{
            x = safezoneX + 0.53 * safezoneW;
            y = safezoney + 0.25 * safezoneH;
            w = 0.25 * safezonew;
            h = 0.55 * safezoneH;
			colorBackground[] = {0, 0, 0, 0.8};
		};
        class frameInv: RscFrame
        {
            x = safezoneX + 0.532 * safezoneW;
            y = safezoney + 0.25 * safezoneH;
            w = 0.247 * safezonew;
            h = 0.547 * safezoneH;
			text = "Crate Inventory";
			sizeEx = 0.03;
        };
        class frameGrpFil: RscFrame
        {
            x = safezoneX + 0.22 * safezoneW;
            y = safezoney + 0.17 * safezoneH;
            w = 0.123 * safezonew;
            h = 0.042 * safezoneH;
			text = "Group Filter";
			sizeEx = 0.03;
        };
        class frameRoleFilter: RscFrame
        {
            x = safezoneX + 0.347 * safezoneW;
            y = safezoney + 0.17 * safezoneH;
            w = 0.123 * safezonew;
            h = 0.042 * safezoneH;
			text = "Role Filter";
			sizeEx = 0.03;
        };
        class frameFillLevel: RscFrame
        {
            x = safezoneX + 0.531 * safezoneW;
            y = safezoney + 0.215 * safezoneH;
            w = 0.248 * safezonew;
            h = 0.032 * safezoneH;
			text = "Fill Level";
			sizeEx = 0.03;
        };
        class frameBox: RscFrame
        {
            x = safezoneX + 0.531 * safezoneW;
            y = safezoney + 0.17 * safezoneH;
            w = 0.248 * safezonew;
            h = 0.042 * safezoneH;
			text = "Box";
			sizeEx = 0.03;
        };
	};
    class Controls
    {
		class GroupFilter: RscListbox
		{
			idc = 9910002;
			type = 4;
			x = safeZoneX + safeZoneW * 0.2225;
			y = safeZoneY + safeZoneH * 0.185;
			w = safeZoneW * 0.1175;
			h = safeZoneH * 0.0218;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
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
		class RoleFilter: RscListbox
		{
			idc = 9910003;
			type = 4;
			x = safeZoneX + safeZoneW * 0.3495;
			y = safeZoneY + safeZoneH * 0.185;
			w = safeZoneW * 0.1175;
			h = safeZoneH * 0.0218;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
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

		class ItemFilter: RscToolbox
		{
			idc = 9910001;
			type = 6;
			style= 2;
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
				"All",
				"Clo",
				"Wea",
				"Amm",
				"Gre",
				"Exp",
				"Att",
				"Med",
				"Mis"
			};
			values[] = 
			{
				"All",
				"Clo",
				"Wea",
				"Amm",
				"Gre",
				"Exp",
				"Att",
				"Med",
				"Mis"				
			};
            x = safezoneX + 0.22 * safezoneW;
            y = safezoney + 0.215 * safezoneH;
            w = 0.25 * safezonew;
            h = 0.032 * safezoneH;
			rows = 1;
			columns = 9;
			font = "RobotoCondensed";
			sizeEx = 0.03;
		};
		class LoadBar: RscProgress
		{
			idc = 9910005;
			onLoad = "_this spawn { for '_i' from 0 to 1 step 0.01 do { (_this # 0) progressSetPosition _i; sleep 0.01 } }";
			deletable = 0;
			fade = 0;
			access = 0;
			type = 8;
			style = 0;
			colorFrame[] = {0,0,0,1};
			colorBar[] = {1,1,1,1};
            x = safezoneX + 0.534 * safezoneW;
            y = safezoney + 0.229 * safezoneH;
            w = 0.241 * safezonew;
            h = 0.013 * safezoneH;
			shadow = 2;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
		};
		class BoxChooser: RscListbox
		{
			idc = 9910006;
			type = 4;
            x = safezoneX + 0.534 * safezoneW;
			y = safeZoneY + safeZoneH * 0.185;
            w = 0.241 * safezonew;
			h = safeZoneH * 0.0218;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.5843,0.8902,0.349,1};
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
	};
};