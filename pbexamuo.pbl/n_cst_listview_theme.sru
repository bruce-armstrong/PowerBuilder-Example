//objectcomments Gives a report-view ListView's column header the Windows dark style when a dark theme is active
forward
global type n_cst_listview_theme from nonvisualobject
end type
end forward

global type n_cst_listview_theme from nonvisualobject autoinstantiate
end type
global n_cst_listview_theme n_cst_listview_theme

type prototypes
FUNCTION longptr SendMessageW ( longptr hWnd, uint Msg, longptr wParam, longptr lParam ) LIBRARY "user32.dll"
FUNCTION long SetWindowTheme ( longptr hWnd, string pszSubAppName, string pszSubIdList ) LIBRARY "uxtheme.dll"
end prototypes

forward prototypes
public subroutine of_header (listview alv_target)
end prototypes

public subroutine of_header (listview alv_target);// The column header of a report-view ListView is a Windows header control (LVM_GETHEADER),
// which the PowerBuilder theme does not paint. With a dark theme, give it the Windows dark style.
Longptr	ll_Header
String	ls_Null

If Pos(Lower(GetTheme()), "dark") = 0 Then Return
SetNull(ls_Null)
ll_Header = SendMessageW(Handle(alv_target), 4127, 0, 0)
If ll_Header <> 0 Then SetWindowTheme(ll_Header, "DarkMode_ItemsView", ls_Null)
end subroutine

on n_cst_listview_theme.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_listview_theme.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
