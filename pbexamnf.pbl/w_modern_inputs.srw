//objectcomments PB 2025 Placeholder text and OpenURL
forward
global type w_modern_inputs from w_center
end type
type st_intro from statictext within w_modern_inputs
end type
type gb_form from groupbox within w_modern_inputs
end type
type sle_name from singlelineedit within w_modern_inputs
end type
type sle_email from singlelineedit within w_modern_inputs
end type
type em_phone from editmask within w_modern_inputs
end type
type mle_notes from multilineedit within w_modern_inputs
end type
type cb_fill from commandbutton within w_modern_inputs
end type
type cb_clear from commandbutton within w_modern_inputs
end type
type gb_links from groupbox within w_modern_inputs
end type
type st_links from statictext within w_modern_inputs
end type
type cb_docs from commandbutton within w_modern_inputs
end type
type cb_community from commandbutton within w_modern_inputs
end type
type cb_mail from commandbutton within w_modern_inputs
end type
type cb_close from commandbutton within w_modern_inputs
end type
end forward

global type w_modern_inputs from w_center
integer width = 3255
integer height = 2060
string title = "Placeholders and OpenURL"
st_intro st_intro
gb_form gb_form
sle_name sle_name
sle_email sle_email
em_phone em_phone
mle_notes mle_notes
cb_fill cb_fill
cb_clear cb_clear
gb_links gb_links
st_links st_links
cb_docs cb_docs
cb_community cb_community
cb_mail cb_mail
cb_close cb_close
end type
global w_modern_inputs w_modern_inputs

on w_modern_inputs.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.sle_name=create sle_name
this.sle_email=create sle_email
this.em_phone=create em_phone
this.mle_notes=create mle_notes
this.cb_fill=create cb_fill
this.cb_clear=create cb_clear
this.st_links=create st_links
this.cb_docs=create cb_docs
this.cb_community=create cb_community
this.cb_mail=create cb_mail
this.cb_close=create cb_close
this.gb_form=create gb_form
this.gb_links=create gb_links
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.sle_name
this.Control[iCurrent+3]=this.sle_email
this.Control[iCurrent+4]=this.em_phone
this.Control[iCurrent+5]=this.mle_notes
this.Control[iCurrent+6]=this.cb_fill
this.Control[iCurrent+7]=this.cb_clear
this.Control[iCurrent+8]=this.st_links
this.Control[iCurrent+9]=this.cb_docs
this.Control[iCurrent+10]=this.cb_community
this.Control[iCurrent+11]=this.cb_mail
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.gb_form
this.Control[iCurrent+14]=this.gb_links
end on

on w_modern_inputs.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.gb_form)
destroy(this.sle_name)
destroy(this.sle_email)
destroy(this.em_phone)
destroy(this.mle_notes)
destroy(this.cb_fill)
destroy(this.cb_clear)
destroy(this.gb_links)
destroy(this.st_links)
destroy(this.cb_docs)
destroy(this.cb_community)
destroy(this.cb_mail)
destroy(this.cb_close)
end on

type st_intro from statictext within w_modern_inputs
integer x = 37
integer y = 24
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
string text = "SingleLineEdit, MultiLineEdit and EditMask (string masks) support a Placeholder hint that shows while the field is empty and unfocused, saving a label per field.  OpenURL opens a link in the default browser, replacing the old Inet.HyperlinkToURL."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type gb_form from groupbox within w_modern_inputs
integer x = 37
integer y = 184
integer width = 1550
integer height = 1180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Placeholder property"
end type

type sle_name from singlelineedit within w_modern_inputs
integer x = 110
integer y = 284
integer width = 1400
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
string placeholder = "Full name"
end type

type sle_email from singlelineedit within w_modern_inputs
integer x = 110
integer y = 404
integer width = 1400
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
string placeholder = "E-mail address"
end type

type em_phone from editmask within w_modern_inputs
integer x = 110
integer y = 524
integer width = 1400
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "(###) ###-####"
string placeholder = "Phone (EditMask, string mask)"
end type

type mle_notes from multilineedit within w_modern_inputs
integer x = 110
integer y = 644
integer width = 1400
integer height = 460
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
string placeholder = "Notes - a MultiLineEdit with a placeholder"
end type

type cb_fill from commandbutton within w_modern_inputs
integer x = 110
integer y = 1136
integer width = 680
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Fill In"
end type

event clicked;sle_name.Text = "Jane Developer"
sle_email.Text = "jane@example.com"
em_phone.Text = "5551234567"
mle_notes.Text = "Placeholders disappear as soon as a field has a value."
end event

type cb_clear from commandbutton within w_modern_inputs
integer x = 830
integer y = 1136
integer width = 680
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&lear"
end type

event clicked;sle_name.Text = ""
sle_email.Text = ""
em_phone.Text = ""
mle_notes.Text = ""
cb_fill.SetFocus()
end event

type gb_links from groupbox within w_modern_inputs
integer x = 1632
integer y = 184
integer width = 1550
integer height = 1180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "OpenURL"
end type

type st_links from statictext within w_modern_inputs
integer x = 1700
integer y = 284
integer width = 1420
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Each button calls OpenURL( url ), which opens the address in the default web browser."
boolean focusrectangle = false
end type

type cb_docs from commandbutton within w_modern_inputs
integer x = 1700
integer y = 444
integer width = 1420
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "PowerBuilder &Documentation"
end type

event clicked;OpenUrl("https://docs.appeon.com/pb.html")
end event

type cb_community from commandbutton within w_modern_inputs
integer x = 1700
integer y = 564
integer width = 1420
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Appeon &Community"
end type

event clicked;OpenUrl("https://community.appeon.com")
end event

type cb_mail from commandbutton within w_modern_inputs
integer x = 1700
integer y = 684
integer width = 1420
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "mailto: &Link"
end type

event clicked;OpenUrl("mailto:" + sle_email.Text + "?subject=Sent%20from%20PowerBuilder")
end event

type cb_close from commandbutton within w_modern_inputs
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
