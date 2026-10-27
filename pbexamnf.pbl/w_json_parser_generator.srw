//objectcomments PB 2017 R2+ JSONParser and JSONGenerator objects
forward
global type w_json_parser_generator from w_center
end type
type st_intro from statictext within w_json_parser_generator
end type
type st_input from statictext within w_json_parser_generator
end type
type mle_json from multilineedit within w_json_parser_generator
end type
type cb_parse from commandbutton within w_json_parser_generator
end type
type st_tree from statictext within w_json_parser_generator
end type
type tv_json from treeview within w_json_parser_generator
end type
type st_path from statictext within w_json_parser_generator
end type
type sle_path from singlelineedit within w_json_parser_generator
end type
type cb_path from commandbutton within w_json_parser_generator
end type
type sle_result from singlelineedit within w_json_parser_generator
end type
type cb_generate from commandbutton within w_json_parser_generator
end type
type cb_use from commandbutton within w_json_parser_generator
end type
type mle_generated from multilineedit within w_json_parser_generator
end type
type cb_close from commandbutton within w_json_parser_generator
end type
end forward

global type w_json_parser_generator from w_center
integer width = 3255
integer height = 2060
string title = "JSONParser and JSONGenerator"
st_intro st_intro
st_input st_input
mle_json mle_json
cb_parse cb_parse
st_tree st_tree
tv_json tv_json
st_path st_path
sle_path sle_path
cb_path cb_path
sle_result sle_result
cb_generate cb_generate
cb_use cb_use
mle_generated mle_generated
cb_close cb_close
end type
global w_json_parser_generator w_json_parser_generator

type variables
JsonParser	inv_parser
end variables

forward prototypes
public function string of_describe (long al_item)
public subroutine of_add_node (long al_tvparent, long al_item, string as_label)
end prototypes

public function string of_describe (long al_item);// Returns a readable description (type and value) of one JSON item
String	ls_Value

Choose Case inv_parser.GetItemType(al_item)
	Case JsonObjectItem!
		ls_Value = "{object, " + String(inv_parser.GetChildCount(al_item)) + " keys}"
	Case JsonArrayItem!
		ls_Value = "[array, " + String(inv_parser.GetChildCount(al_item)) + " items]"
	Case JsonStringItem!
		ls_Value = '"' + inv_parser.GetItemString(al_item) + '"'
	Case JsonNumberItem!
		ls_Value = String(inv_parser.GetItemNumber(al_item))
	Case JsonBooleanItem!
		If inv_parser.GetItemBoolean(al_item) Then
			ls_Value = "true"
		Else
			ls_Value = "false"
		End If
	Case JsonNullItem!
		ls_Value = "null"
End Choose

Return ls_Value
end function

public subroutine of_add_node (long al_tvparent, long al_item, string as_label);// Recursively adds a JSON item and its children to the TreeView
Long		ll_Node, ll_Child, ll_Count, ll_Index
String	ls_Key
JsonItemType	le_Type

ll_Node = tv_json.InsertItemLast(al_tvparent, as_label + " : " + of_describe(al_item), 0)

le_Type = inv_parser.GetItemType(al_item)
If le_Type <> JsonObjectItem! And le_Type <> JsonArrayItem! Then Return

ll_Count = inv_parser.GetChildCount(al_item)
For ll_Index = 1 To ll_Count
	ll_Child = inv_parser.GetChildItem(al_item, ll_Index)
	If le_Type = JsonObjectItem! Then
		ls_Key = inv_parser.GetChildKey(al_item, ll_Index)
	Else
		ls_Key = "[" + String(ll_Index) + "]"
	End If
	of_add_node(ll_Node, ll_Child, ls_Key)
Next
end subroutine

on w_json_parser_generator.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_input=create st_input
this.mle_json=create mle_json
this.cb_parse=create cb_parse
this.st_tree=create st_tree
this.tv_json=create tv_json
this.st_path=create st_path
this.sle_path=create sle_path
this.cb_path=create cb_path
this.sle_result=create sle_result
this.cb_generate=create cb_generate
this.cb_use=create cb_use
this.mle_generated=create mle_generated
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_input
this.Control[iCurrent+3]=this.mle_json
this.Control[iCurrent+4]=this.cb_parse
this.Control[iCurrent+5]=this.st_tree
this.Control[iCurrent+6]=this.tv_json
this.Control[iCurrent+7]=this.st_path
this.Control[iCurrent+8]=this.sle_path
this.Control[iCurrent+9]=this.cb_path
this.Control[iCurrent+10]=this.sle_result
this.Control[iCurrent+11]=this.cb_generate
this.Control[iCurrent+12]=this.cb_use
this.Control[iCurrent+13]=this.mle_generated
this.Control[iCurrent+14]=this.cb_close
end on

on w_json_parser_generator.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_input)
destroy(this.mle_json)
destroy(this.cb_parse)
destroy(this.st_tree)
destroy(this.tv_json)
destroy(this.st_path)
destroy(this.sle_path)
destroy(this.cb_path)
destroy(this.sle_result)
destroy(this.cb_generate)
destroy(this.cb_use)
destroy(this.mle_generated)
destroy(this.cb_close)
end on

event open;call super::open;inv_parser = Create JsonParser

mle_json.Text = '{~r~n' + &
	'  "product": "PowerBuilder",~r~n' + &
	'  "version": 2025,~r~n' + &
	'  "nativeCode": true,~r~n' + &
	'  "framework": null,~r~n' + &
	'  "vendor": { "name": "Appeon", "web": "https://www.appeon.com" },~r~n' + &
	'  "features": [ "JSON", "REST", "PDF", "RibbonBar", "WebBrowser" ],~r~n' + &
	'  "targets": [~r~n' + &
	'    { "type": "Client/Server", "bits": 64 },~r~n' + &
	'    { "type": "PowerServer", "bits": 64 }~r~n' + &
	'  ]~r~n' + &
	'}'

cb_parse.Event Clicked()
end event

event close;call super::close;If IsValid(inv_parser) Then Destroy inv_parser
end event

type st_intro from statictext within w_json_parser_generator
integer x = 37
integer y = 24
integer width = 3145
integer height = 196
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "JSONParser loads JSON text and lets you walk it item by item (GetRootItem, GetItemType, GetChildCount, GetChildKey, GetChildItem) or jump straight to a value with GetItemByPath.  JSONGenerator builds JSON in code without any string concatenation."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_input from statictext within w_json_parser_generator
integer x = 37
integer y = 236
integer width = 1550
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "JSON input (edit it and parse again):"
boolean focusrectangle = false
end type

type mle_json from multilineedit within w_json_parser_generator
integer x = 37
integer y = 304
integer width = 1550
integer height = 820
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Consolas"
long textcolor = 33554432
string text = ""
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_parse from commandbutton within w_json_parser_generator
integer x = 37
integer y = 1144
integer width = 549
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Parse into Tree"
end type

event clicked;String	ls_Error

tv_json.SetRedraw(False)
tv_json.DeleteItem(0)

ls_Error = inv_parser.LoadString(mle_json.Text)
If Len(ls_Error) > 0 Then
	tv_json.SetRedraw(True)
	MessageBox("Invalid JSON", ls_Error, StopSign!)
	Return
End If

of_add_node(0, inv_parser.GetRootItem(), "root")
tv_json.ExpandAll(tv_json.FindItem(RootTreeItem!, 0))
tv_json.SetRedraw(True)
end event

type st_tree from statictext within w_json_parser_generator
integer x = 1632
integer y = 236
integer width = 1550
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Parsed structure:"
boolean focusrectangle = false
end type

type tv_json from treeview within w_json_parser_generator
integer x = 1632
integer y = 304
integer width = 1550
integer height = 820
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = true
boolean hideselection = false
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type st_path from statictext within w_json_parser_generator
integer x = 1632
integer y = 1160
integer width = 297
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Item path:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_json_parser_generator
integer x = 1934
integer y = 1144
integer width = 677
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "/targets/2/type"
borderstyle borderstyle = stylelowered!
end type

type cb_path from commandbutton within w_json_parser_generator
integer x = 2629
integer y = 1144
integer width = 553
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&GetItemByPath"
end type

event clicked;Long	ll_Item

ll_Item = inv_parser.GetItemByPath(sle_path.Text)
If IsNull(ll_Item) Or ll_Item <= 0 Then
	sle_result.Text = "Path not found (array positions are 1-based, e.g. /features/1)"
Else
	sle_result.Text = sle_path.Text + " = " + of_describe(ll_Item)
End If
end event

type sle_result from singlelineedit within w_json_parser_generator
integer x = 1632
integer y = 1260
integer width = 1550
integer height = 92
integer taborder = 0
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
boolean displayonly = true
end type

type cb_generate from commandbutton within w_json_parser_generator
integer x = 37
integer y = 1260
integer width = 549
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Generate &JSON"
end type

event clicked;// Build a JSON document in code with JSONGenerator
JsonGenerator	lnv_Gen
Long				ll_Root, ll_Array, ll_Object

lnv_Gen = Create JsonGenerator

ll_Root = lnv_Gen.CreateJsonObject()
lnv_Gen.AddItemString(ll_Root, "generatedBy", "JSONGenerator")
lnv_Gen.AddItemDateTime(ll_Root, "generatedAt", DateTime(Today(), Now()))
lnv_Gen.AddItemNumber(ll_Root, "pbVersion", 2025)
lnv_Gen.AddItemBoolean(ll_Root, "usesPFC", False)
lnv_Gen.AddItemNull(ll_Root, "notes")

ll_Array = lnv_Gen.AddItemArray(ll_Root, "nativeObjects")
lnv_Gen.AddItemString(ll_Array, "HTTPClient")
lnv_Gen.AddItemString(ll_Array, "RESTClient")
lnv_Gen.AddItemString(ll_Array, "CrypterObject")
lnv_Gen.AddItemString(ll_Array, "CompressorObject")

ll_Object = lnv_Gen.AddItemObject(ll_Root, "window")
lnv_Gen.AddItemString(ll_Object, "class", Parent.ClassName())
lnv_Gen.AddItemNumber(ll_Object, "width", Parent.Width)
lnv_Gen.AddItemNumber(ll_Object, "height", Parent.Height)

mle_generated.Text = lnv_Gen.GetJsonString()

Destroy lnv_Gen
end event

type cb_use from commandbutton within w_json_parser_generator
integer x = 603
integer y = 1260
integer width = 549
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Use as Input"
end type

event clicked;If Len(mle_generated.Text) = 0 Then cb_generate.Event Clicked()
mle_json.Text = mle_generated.Text
cb_parse.Event Clicked()
end event

type mle_generated from multilineedit within w_json_parser_generator
integer x = 37
integer y = 1380
integer width = 3145
integer height = 480
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Consolas"
long textcolor = 33554432
string text = ""
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
boolean displayonly = true
end type

type cb_close from commandbutton within w_json_parser_generator
integer x = 2780
integer y = 1892
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
