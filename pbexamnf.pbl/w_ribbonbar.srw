//objectcomments PB 2019 R3+ RibbonBar control built from PowerScript and JSON
forward
global type w_ribbonbar from w_center
end type
type rbb_1 from ribbonbar within w_ribbonbar
end type
type st_intro from statictext within w_ribbonbar
end type
type cb_script from commandbutton within w_ribbonbar
end type
type cb_json from commandbutton within w_ribbonbar
end type
type cb_export from commandbutton within w_ribbonbar
end type
type mle_log from multilineedit within w_ribbonbar
end type
type cb_close from commandbutton within w_ribbonbar
end type
end forward

global type w_ribbonbar from w_center
integer width = 3255
integer height = 2060
string title = "RibbonBar Control"
rbb_1 rbb_1
st_intro st_intro
cb_script cb_script
cb_json cb_json
cb_export cb_export
mle_log mle_log
cb_close cb_close
end type
global w_ribbonbar w_ribbonbar

forward prototypes
public subroutine of_log (string as_text)
public subroutine of_clear ()
public subroutine of_build_with_script ()
end prototypes

public subroutine of_log (string as_text);mle_log.Text = String(Now(), "hh:mm:ss") + "  " + as_text + "~r~n" + mle_log.Text
end subroutine

public subroutine of_clear ();// Remove every category (and with it every panel and button)
RibbonCategoryItem	lr_Category

Do While rbb_1.GetCategoryCount() > 0
	If rbb_1.GetCategoryByIndex(1, lr_Category) <> 1 Then Exit
	rbb_1.DeleteCategory(lr_Category.ItemHandle)
Loop
end subroutine

public subroutine of_build_with_script ();// Build the ribbon item by item: Category > Panel > Large/Small buttons.
// The last argument names the user event (declared on rbb_1) that handles the click.
Long	ll_Category, ll_Panel

of_clear()

ll_Category = rbb_1.InsertCategoryLast("Home")

ll_Panel = rbb_1.InsertPanelLast(ll_Category, "Records", "AddSmall!")
rbb_1.InsertLargeButtonLast(ll_Panel, "Add", "AddBig!", "ue_large_clicked")
rbb_1.InsertLargeButtonLast(ll_Panel, "Delete", "DeleteBig!", "ue_large_clicked")
rbb_1.InsertSmallButtonLast(ll_Panel, "Employees", "EmployeeSmall!", "ue_small_clicked")
rbb_1.InsertSmallButtonLast(ll_Panel, "Bill of Materials", "BOMSmall!", "ue_small_clicked")
rbb_1.InsertSmallButtonLast(ll_Panel, "Page Size", "PageSizeSmall!", "ue_small_clicked")

ll_Panel = rbb_1.InsertPanelLast(ll_Category, "Account", "EmployeeSmall!")
rbb_1.InsertLargeButtonLast(ll_Panel, "Account", "AccountBig!", "ue_large_clicked")
rbb_1.InsertLargeButtonLast(ll_Panel, "Settings", "AccountSettingsBig!", "ue_large_clicked")
rbb_1.InsertLargeButtonLast(ll_Panel, "Sign Out", "SignOutBig!", "ue_large_clicked")

ll_Category = rbb_1.InsertCategoryLast("Help")
ll_Panel = rbb_1.InsertPanelLast(ll_Category, "Information", "HelpSmall!")
rbb_1.InsertLargeButtonLast(ll_Panel, "Help", "HelpBig!", "ue_large_clicked")
rbb_1.InsertLargeButtonLast(ll_Panel, "About", "AboutBig!", "ue_large_clicked")

of_log("Ribbon built with InsertCategoryLast / InsertPanelLast / InsertLargeButtonLast / InsertSmallButtonLast")
end subroutine

on w_ribbonbar.create
int iCurrent
call super::create
this.rbb_1=create rbb_1
this.st_intro=create st_intro
this.cb_script=create cb_script
this.cb_json=create cb_json
this.cb_export=create cb_export
this.mle_log=create mle_log
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rbb_1
this.Control[iCurrent+2]=this.st_intro
this.Control[iCurrent+3]=this.cb_script
this.Control[iCurrent+4]=this.cb_json
this.Control[iCurrent+5]=this.cb_export
this.Control[iCurrent+6]=this.mle_log
this.Control[iCurrent+7]=this.cb_close
end on

on w_ribbonbar.destroy
call super::destroy
destroy(this.rbb_1)
destroy(this.st_intro)
destroy(this.cb_script)
destroy(this.cb_json)
destroy(this.cb_export)
destroy(this.mle_log)
destroy(this.cb_close)
end on

event open;call super::open;of_build_with_script()
end event

type rbb_1 from ribbonbar within w_ribbonbar
event type long ue_large_clicked ( long itemhandle )
event type long ue_small_clicked ( long itemhandle )
integer x = 0
integer y = 0
integer width = 3237
integer height = 500
boolean autosizeheight = true
end type

event ue_large_clicked;// Bound to ribbon buttons by name; receives the handle of the clicked item
RibbonLargeButtonItem	lr_Button

This.GetLargeButton(itemhandle, lr_Button)
of_log("Clicked: " + lr_Button.Text)
Return 1
end event

event ue_small_clicked;// Bound to ribbon buttons by name; receives the handle of the clicked item
RibbonSmallButtonItem	lr_Button

This.GetSmallButton(itemhandle, lr_Button)
of_log("Clicked: " + lr_Button.Text)
Return 1
end event

type st_intro from statictext within w_ribbonbar
integer x = 37
integer y = 540
integer width = 3145
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "The RibbonBar control organizes commands into Categories, Panels, buttons, check boxes and combo boxes.  It can be built in the RibbonBar Builder, from PowerScript (as here), or loaded from XML/JSON with ImportJSON/ImportXML.  PowerBuilder 2025 can even show an existing MDI menu as a ribbon with no code changes."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type cb_script from commandbutton within w_ribbonbar
integer x = 37
integer y = 696
integer width = 700
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Build with &Script"
end type

event clicked;of_build_with_script()
end event

type cb_json from commandbutton within w_ribbonbar
integer x = 755
integer y = 696
integer width = 700
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Load from &JSON"
end type

event clicked;// The same kind of ribbon described as JSON (the format produced by ExportJSON)
String	ls_Json
Integer	li_Rc

ls_Json = '{"RibbonItems":{"Category":[' + &
	'{"Text":"From JSON","Panel":[' + &
	'{"Text":"Edit","PictureName":"AddSmall!","RibbonItem":[' + &
		'{"LargeButton":{"Text":"New","PictureName":"AddBig!","Clicked":"ue_large_clicked"}},' + &
		'{"LargeButton":{"Text":"Remove","PictureName":"DeleteBig!","Clicked":"ue_large_clicked"}},' + &
		'{"SmallButton":{"Text":"People","PictureName":"EmployeeSmall!","Clicked":"ue_small_clicked"}},' + &
		'{"SmallButton":{"Text":"Tabs","PictureName":"TabsSmall!","Clicked":"ue_small_clicked"}}' + &
	']}]}]}}'

li_Rc = rbb_1.ImportJSON(ls_Json)
of_log("ImportJSON returned " + String(li_Rc))
end event

type cb_export from commandbutton within w_ribbonbar
integer x = 1473
integer y = 696
integer width = 700
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Show &ExportJSON()"
end type

event clicked;mle_log.Text = rbb_1.ExportJSON() + "~r~n~r~n" + mle_log.Text
end event

type mle_log from multilineedit within w_ribbonbar
integer x = 37
integer y = 820
integer width = 3145
integer height = 980
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Consolas"
long textcolor = 33554432
string text = "Click the ribbon buttons above."
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
boolean displayonly = true
end type

type cb_close from commandbutton within w_ribbonbar
integer x = 2780
integer y = 1824
integer width = 402
integer height = 100
integer taborder = 900
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event
