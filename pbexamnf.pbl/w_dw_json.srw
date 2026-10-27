//objectcomments PB 2017 R3+ DataWindow ExportJson / ImportJson
forward
global type w_dw_json from w_center
end type
type st_intro from statictext within w_dw_json
end type
type st_source from statictext within w_dw_json
end type
type dw_source from datawindow within w_dw_json
end type
type st_target from statictext within w_dw_json
end type
type dw_target from datawindow within w_dw_json
end type
type cb_plain from commandbutton within w_dw_json
end type
type cb_dwjson from commandbutton within w_dw_json
end type
type cb_changed from commandbutton within w_dw_json
end type
type cb_import from commandbutton within w_dw_json
end type
type mle_json from multilineedit within w_dw_json
end type
type st_info from statictext within w_dw_json
end type
type cb_close from commandbutton within w_dw_json
end type
end forward

global type w_dw_json from w_center
integer width = 3255
integer height = 2060
string title = "DataWindow and JSON"
st_intro st_intro
st_source st_source
dw_source dw_source
st_target st_target
dw_target dw_target
cb_plain cb_plain
cb_dwjson cb_dwjson
cb_changed cb_changed
cb_import cb_import
mle_json mle_json
st_info st_info
cb_close cb_close
end type
global w_dw_json w_dw_json

on w_dw_json.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_source=create st_source
this.dw_source=create dw_source
this.st_target=create st_target
this.dw_target=create dw_target
this.cb_plain=create cb_plain
this.cb_dwjson=create cb_dwjson
this.cb_changed=create cb_changed
this.cb_import=create cb_import
this.mle_json=create mle_json
this.st_info=create st_info
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_source
this.Control[iCurrent+3]=this.dw_source
this.Control[iCurrent+4]=this.st_target
this.Control[iCurrent+5]=this.dw_target
this.Control[iCurrent+6]=this.cb_plain
this.Control[iCurrent+7]=this.cb_dwjson
this.Control[iCurrent+8]=this.cb_changed
this.Control[iCurrent+9]=this.cb_import
this.Control[iCurrent+10]=this.mle_json
this.Control[iCurrent+11]=this.st_info
this.Control[iCurrent+12]=this.cb_close
end on

on w_dw_json.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_source)
destroy(this.dw_source)
destroy(this.st_target)
destroy(this.dw_target)
destroy(this.cb_plain)
destroy(this.cb_dwjson)
destroy(this.cb_changed)
destroy(this.cb_import)
destroy(this.mle_json)
destroy(this.st_info)
destroy(this.cb_close)
end on

event open;call super::open;// The right-hand DataWindow starts empty so you can see the import
dw_target.Reset()
end event

type st_intro from statictext within w_dw_json
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
string text = "ExportJson turns DataWindow rows into JSON (plain two-level JSON, or the richer DataWindow JSON that keeps the original/changed buffers).  ImportJson loads JSON back into any DataWindow or DataStore whose column names match the JSON keys.  Edit a salary on the left, then try ~"Changed Rows Only~"."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_source from statictext within w_dw_json
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
string text = "Source DataWindow (editable):"
boolean focusrectangle = false
end type

type dw_source from datawindow within w_dw_json
integer x = 37
integer y = 304
integer width = 1550
integer height = 700
integer taborder = 10
string title = "none"
string dataobject = "d_nf_employees"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_target from statictext within w_dw_json
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
string text = "Target DataWindow (filled by ImportJson):"
boolean focusrectangle = false
end type

type dw_target from datawindow within w_dw_json
integer x = 1632
integer y = 304
integer width = 1550
integer height = 700
integer taborder = 20
string title = "none"
string dataobject = "d_nf_employees"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_plain from commandbutton within w_dw_json
integer x = 37
integer y = 1028
integer width = 640
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export &Plain JSON"
end type

event clicked;mle_json.Text = dw_source.ExportJson()
st_info.Text = "dw_source.ExportJson() - an array of row objects, keyed by column name."
end event

type cb_dwjson from commandbutton within w_dw_json
integer x = 695
integer y = 1028
integer width = 640
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export &DataWindow JSON"
end type

event clicked;mle_json.Text = dw_source.ExportJson(True)
st_info.Text = "dw_source.ExportJson(True) - DataWindow JSON with identity, buffers and row status."
end event

type cb_changed from commandbutton within w_dw_json
integer x = 1353
integer y = 1028
integer width = 640
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&hanged Rows Only"
end type

event clicked;dw_source.AcceptText()
mle_json.Text = dw_source.ExportJson(Primary!, True, False)
If dw_source.ModifiedCount() = 0 Then
	st_info.Text = "No rows have been modified yet - change a value in the source DataWindow first."
Else
	st_info.Text = "dw_source.ExportJson(Primary!, True, False) - " + String(dw_source.ModifiedCount()) + " modified row(s)."
End If
end event

type cb_import from commandbutton within w_dw_json
integer x = 2542
integer y = 1028
integer width = 640
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&ImportJson  >>"
end type

event clicked;Long		ll_Rows
String	ls_Error

dw_target.Reset()
ll_Rows = dw_target.ImportJson(mle_json.Text, ls_Error)

If ll_Rows < 0 Then
	st_info.Text = "ImportJson failed (" + String(ll_Rows) + "). " + ls_Error
Else
	st_info.Text = String(ll_Rows) + " row(s) imported. " + ls_Error
End If
end event

type mle_json from multilineedit within w_dw_json
integer x = 37
integer y = 1152
integer width = 3145
integer height = 620
integer taborder = 70
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

type st_info from statictext within w_dw_json
integer x = 37
integer y = 1792
integer width = 2700
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click one of the Export buttons."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_dw_json
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
