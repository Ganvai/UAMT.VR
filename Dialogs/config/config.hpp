//- GUI Documenation: https://community.bistudio.com/wiki/Arma:_GUI_Configuration
//- Control Types:    https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Types
//- Control Styles:   https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Styles

//Eden Editor macros such as background colour and pixel grid
#include "\a3\3DEN\UI\macros.inc"
//GRIDs
#include "\a3\ui_f\hpp\definecommongrids.inc"
//DIK Key Codes
#include "\a3\ui_f\hpp\definedikcodes.inc"
//Eden Editor IDDs and IDCs as well as control types, styles and macros
#include "\a3\3den\ui\resincl.inc"

//Eden Editor Base Controls
import ctrlActivePicture;
import ctrlActivePictureKeepAspect;
import ctrlActiveText;
import ctrlButton;
import ctrlButtonCancel;
import ctrlButtonClose;
import ctrlButtonCollapseAll;
import ctrlButtonExpandAll;
import ctrlButtonFilter;
import ctrlButtonOK;
import ctrlButtonPicture;
import ctrlButtonPictureKeepAspect;
import ctrlButtonSearch;
import ctrlButtonToolbar;
import ctrlCheckbox;
import ctrlCheckboxBaseline;
import ctrlCheckboxes;
import ctrlCheckboxesCheckbox;
import ctrlCheckboxToolbar;
import ctrlCombo;
import ctrlComboToolbar;
import ctrlControlsGroup;
import ctrlControlsGroupNoHScrollbars;
import ctrlControlsGroupNoScrollbars;
import ctrlControlsGroupNoVScrollbars;
import ctrlDefault;
import ctrlDefaultButton;
import ctrlDefaultText;
import ctrlEdit;
import ctrlEditMulti;
import ctrlHTML;
import ctrlListbox;
import ctrlListNBox;
import ctrlMap;
import ctrlMapEmpty;
import ctrlMapMain;
import ctrlMenu;
import ctrlMenuStrip;
import ctrlProgress;
import ctrlShortcutButton;
import ctrlShortcutButtonCancel;
import ctrlShortcutButtonOK;
import ctrlShortcutButtonSteam;
import ctrlSliderH;
import ctrlSliderV;
import ctrlStatic;
import ctrlStaticBackground;
import ctrlStaticBackgroundDisable;
import ctrlStaticBackgroundDisableTiles;
import ctrlStaticFooter;
import ctrlStaticFrame;
import ctrlStaticLine;
import ctrlStaticMulti;
import ctrlStaticOverlay;
import ctrlStaticPicture;
import ctrlStaticPictureKeepAspect;
import ctrlStaticPictureTile;
import ctrlStaticTitle;
import ctrlStructuredText;
import ctrlToolbox;
import ctrlToolboxPicture;
import ctrlToolboxPictureKeepAspect;
import ctrlTree;
import ctrlXListbox;
import ctrlXSliderH;
import ctrlXSliderV;

//Classic Base Controls
import RscActivePicture;
import RscActivePictureKeepAspect;
import RscActiveText;
import RscButton;
import RscButtonMenu;
import RscButtonMenuCancel;
import RscButtonMenuOK;
import RscButtonMenuSteam;
import RscButtonTextOnly;
import RscCheckBox;
import RscCombo;
import RscControlsGroup;
import RscControlsGroupNoHScrollbars;
import RscControlsGroupNoScrollbars;
import RscControlsGroupNoVScrollbars;
import RscEdit;
import RscFrame;
import RscHTML;
import RscLine;
import RscListBox;
import RscListNBox;
import RscMapControl;
import RscMapControlEmpty;
import RscObject;
import RscPicture;
import RscPictureKeepAspect;
import RscProgress;
import RscShortcutButton;
import RscSlider;
import RscStructuredText;
import RscText;
import RscToolbox;
import RscTree;
import RscVideo;
import RscXListBox;
import RscXSliderH;
import Scrollbar;

#define CT_STATIC				  0
#define CT_BUTTON				  1
#define CT_EDIT					  2
#define CT_SLIDER				  3
#define CT_COMBO				  4
#define CT_LISTBOX				  5
#define CT_TOOLBOX				  6
#define CT_CHECKBOXES			  7
#define CT_PROGRESS				  8
#define CT_HTML					  9
#define CT_STATIC_SKEW			 10
#define CT_ACTIVETEXT			 11
#define CT_TREE					 12
#define CT_STRUCTURED_TEXT		 13
#define CT_CONTEXT_MENU			 14
#define CT_CONTROLS_GROUP		 15
#define CT_SHORTCUTBUTTON		 16
#define CT_HITZONES				 17
#define CT_VEHICLETOGGLES		 18
#define CT_CONTROLS_TABLE		 19
#define CT_XKEYDESC				 40
#define CT_XBUTTON				 41
#define CT_XLISTBOX				 42
#define CT_XSLIDER				 43
#define CT_XCOMBO				 44
#define CT_ANIMATED_TEXTURE		 45
#define CT_MENU					 46
#define CT_MENU_STRIP			 47
#define CT_CHECKBOX				 77
#define CT_OBJECT				 80
#define CT_OBJECT_ZOOM			 81
#define CT_OBJECT_CONTAINER		 82
#define CT_OBJECT_CONT_ANIM		 83
#define CT_LINEBREAK			 98
#define CT_USER					 99
#define CT_MAP					100
#define CT_MAP_MAIN				101
#define CT_LISTNBOX				102
#define CT_ITEMSLOT				103
#define CT_LISTNBOX_CHECKABLE	104
#define CT_VEHICLE_DIRECTION	105

#define ST_LEFT					0x00
#define ST_RIGHT				0x01
#define ST_CENTER				0x02
#define ST_DOWN					0x04
#define ST_UP					0x08
#define ST_VCENTER				0x0C
#define ST_SINGLE				0x00
#define ST_MULTI				0x10
#define ST_TITLE_BAR			0x20
#define ST_PICTURE				0x30
#define ST_FRAME				0x40
#define ST_BACKGROUND			0x50
#define ST_GROUP_BOX			0x60
#define ST_GROUP_BOX2			0x70
#define ST_HUD_BACKGROUND		0x80
#define ST_TILE_PICTURE			0x90
#define ST_WITH_RECT			0xA0
#define ST_LINE					0xB0
#define ST_UPPERCASE			0xC0
#define ST_LOWERCASE			0xD0
#define ST_ADDITIONAL_INFO		0x0F00
#define ST_SHADOW				0x0100
#define ST_NO_RECT				0x0200
#define ST_KEEP_ASPECT_RATIO	0x0800
#define ST_TITLE				ST_TITLE_BAR + ST_CENTER
#define SL_VERT					0
#define SL_HORZ					0x400
#define SL_TEXTURES				0x10
#define ST_VERTICAL				0x01
#define ST_HORIZONTAL			0
#define LB_TEXTURES				0x10
#define LB_MULTI				0x20
#define TR_SHOWROOT				1
#define TR_AUTOCOLLAPSE			2