//objectcomments PB 2022 R2+ SMTPClient and MimeMessage (native email)
forward
global type w_smtp_client from w_center
end type
type st_intro from statictext within w_smtp_client
end type
type st_host from statictext within w_smtp_client
end type
type sle_host from singlelineedit within w_smtp_client
end type
type st_port from statictext within w_smtp_client
end type
type em_port from editmask within w_smtp_client
end type
type cbx_tls from checkbox within w_smtp_client
end type
type st_user from statictext within w_smtp_client
end type
type sle_user from singlelineedit within w_smtp_client
end type
type st_pwd from statictext within w_smtp_client
end type
type sle_pwd from singlelineedit within w_smtp_client
end type
type st_from from statictext within w_smtp_client
end type
type sle_from from singlelineedit within w_smtp_client
end type
type st_to from statictext within w_smtp_client
end type
type sle_to from singlelineedit within w_smtp_client
end type
type st_subject from statictext within w_smtp_client
end type
type sle_subject from singlelineedit within w_smtp_client
end type
type cbx_html from checkbox within w_smtp_client
end type
type mle_body from multilineedit within w_smtp_client
end type
type cb_send from commandbutton within w_smtp_client
end type
type st_status from statictext within w_smtp_client
end type
type cb_close from commandbutton within w_smtp_client
end type
end forward

global type w_smtp_client from w_center
integer width = 3255
integer height = 2060
string title = "Sending Email with SMTPClient"
st_intro st_intro
st_host st_host
sle_host sle_host
st_port st_port
em_port em_port
cbx_tls cbx_tls
st_user st_user
sle_user sle_user
st_pwd st_pwd
sle_pwd sle_pwd
st_from st_from
sle_from sle_from
st_to st_to
sle_to sle_to
st_subject st_subject
sle_subject sle_subject
cbx_html cbx_html
mle_body mle_body
cb_send cb_send
st_status st_status
cb_close cb_close
end type
global w_smtp_client w_smtp_client

on w_smtp_client.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_host=create st_host
this.sle_host=create sle_host
this.st_port=create st_port
this.em_port=create em_port
this.cbx_tls=create cbx_tls
this.st_user=create st_user
this.sle_user=create sle_user
this.st_pwd=create st_pwd
this.sle_pwd=create sle_pwd
this.st_from=create st_from
this.sle_from=create sle_from
this.st_to=create st_to
this.sle_to=create sle_to
this.st_subject=create st_subject
this.sle_subject=create sle_subject
this.cbx_html=create cbx_html
this.mle_body=create mle_body
this.cb_send=create cb_send
this.st_status=create st_status
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_host
this.Control[iCurrent+3]=this.sle_host
this.Control[iCurrent+4]=this.st_port
this.Control[iCurrent+5]=this.em_port
this.Control[iCurrent+6]=this.cbx_tls
this.Control[iCurrent+7]=this.st_user
this.Control[iCurrent+8]=this.sle_user
this.Control[iCurrent+9]=this.st_pwd
this.Control[iCurrent+10]=this.sle_pwd
this.Control[iCurrent+11]=this.st_from
this.Control[iCurrent+12]=this.sle_from
this.Control[iCurrent+13]=this.st_to
this.Control[iCurrent+14]=this.sle_to
this.Control[iCurrent+15]=this.st_subject
this.Control[iCurrent+16]=this.sle_subject
this.Control[iCurrent+17]=this.cbx_html
this.Control[iCurrent+18]=this.mle_body
this.Control[iCurrent+19]=this.cb_send
this.Control[iCurrent+20]=this.st_status
this.Control[iCurrent+21]=this.cb_close
end on

on w_smtp_client.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_host)
destroy(this.sle_host)
destroy(this.st_port)
destroy(this.em_port)
destroy(this.cbx_tls)
destroy(this.st_user)
destroy(this.sle_user)
destroy(this.st_pwd)
destroy(this.sle_pwd)
destroy(this.st_from)
destroy(this.sle_from)
destroy(this.st_to)
destroy(this.sle_to)
destroy(this.st_subject)
destroy(this.sle_subject)
destroy(this.cbx_html)
destroy(this.mle_body)
destroy(this.cb_send)
destroy(this.st_status)
destroy(this.cb_close)
end on

type st_intro from statictext within w_smtp_client
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
string text = "SMTPClient sends email directly to an SMTP server (plain, STARTTLS or SSL/TLS, with LOGIN/PLAIN/NTLM/XOAUTH2 authentication) and MimeMessage builds the message: recipients, plain-text or HTML body and attachments.  No MAPI or mail client is needed.  Tip: point it at a local test server such as smtp4dev or Papercut running in Docker."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_host from statictext within w_smtp_client
integer x = 37
integer y = 256
integer width = 330
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP host:"
boolean focusrectangle = false
end type

type sle_host from singlelineedit within w_smtp_client
integer x = 370
integer y = 240
integer width = 1100
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "localhost"
borderstyle borderstyle = stylelowered!
string placeholder = "smtp.example.com"
end type

type st_port from statictext within w_smtp_client
integer x = 1550
integer y = 256
integer width = 160
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Port:"
boolean focusrectangle = false
end type

type em_port from editmask within w_smtp_client
integer x = 1720
integer y = 240
integer width = 260
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "25"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type cbx_tls from checkbox within w_smtp_client
integer x = 2030
integer y = 248
integer width = 800
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use TLS"
end type

type st_user from statictext within w_smtp_client
integer x = 37
integer y = 368
integer width = 330
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "User name:"
boolean focusrectangle = false
end type

type sle_user from singlelineedit within w_smtp_client
integer x = 370
integer y = 352
integer width = 1100
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
string placeholder = "leave empty if not required"
end type

type st_pwd from statictext within w_smtp_client
integer x = 1550
integer y = 368
integer width = 300
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
boolean focusrectangle = false
end type

type sle_pwd from singlelineedit within w_smtp_client
integer x = 1720
integer y = 352
integer width = 1100
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
boolean password = true
end type

type st_from from statictext within w_smtp_client
integer x = 37
integer y = 480
integer width = 330
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "From:"
boolean focusrectangle = false
end type

type sle_from from singlelineedit within w_smtp_client
integer x = 370
integer y = 464
integer width = 1100
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "examples@powerbuilder.test"
borderstyle borderstyle = stylelowered!
end type

type st_to from statictext within w_smtp_client
integer x = 1550
integer y = 480
integer width = 160
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type sle_to from singlelineedit within w_smtp_client
integer x = 1720
integer y = 464
integer width = 1462
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ""
borderstyle borderstyle = stylelowered!
string placeholder = "someone@example.com"
end type

type st_subject from statictext within w_smtp_client
integer x = 37
integer y = 592
integer width = 330
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subject:"
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within w_smtp_client
integer x = 370
integer y = 576
integer width = 2812
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Hello from PowerBuilder SMTPClient"
borderstyle borderstyle = stylelowered!
end type

type cbx_html from checkbox within w_smtp_client
integer x = 370
integer y = 688
integer width = 1000
integer height = 80
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Send body as HTML"
boolean checked = true
end type

type mle_body from multilineedit within w_smtp_client
integer x = 370
integer y = 780
integer width = 2812
integer height = 900
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "<h2>Hello!</h2><p>This message was sent with the native <b>SMTPClient</b> object.</p>"
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_send from commandbutton within w_smtp_client
integer x = 370
integer y = 1708
integer width = 600
integer height = 100
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send"
end type

event clicked;SMTPClient	lnv_Smtp
Integer		li_Rc

If Len(sle_to.Text) = 0 Then
	MessageBox("Send", "Enter a recipient first.")
	Return
End If

SetPointer(HourGlass!)
lnv_Smtp = Create SMTPClient
lnv_Smtp.Host = sle_host.Text
lnv_Smtp.Port = Long(em_port.Text)
lnv_Smtp.EnableTLS = cbx_tls.Checked
If Len(sle_user.Text) > 0 Then
	lnv_Smtp.UserName = sle_user.Text
	lnv_Smtp.Password = sle_pwd.Text
End If

lnv_Smtp.Message.SetSender(sle_from.Text, "PowerBuilder Examples")
lnv_Smtp.Message.AddRecipient(sle_to.Text)
lnv_Smtp.Message.Subject = sle_subject.Text
If cbx_html.Checked Then
	lnv_Smtp.Message.HtmlBody = mle_body.Text
Else
	lnv_Smtp.Message.TextBody = mle_body.Text
End If

li_Rc = lnv_Smtp.Send()
If li_Rc = 1 Then
	st_status.Text = "Message sent to " + sle_to.Text
Else
	st_status.Text = "Send failed with code " + String(li_Rc) + " (see 'SMTPClient error codes' in the help)."
End If

Destroy lnv_Smtp
end event

type st_status from statictext within w_smtp_client
integer x = 1000
integer y = 1728
integer width = 1700
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = ""
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_smtp_client
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
