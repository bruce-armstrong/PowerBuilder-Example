//objectcomments PB 2019 R2+ WebBrowser (WebView2) control
forward
global type w_webbrowser from w_center
end type
type st_intro from statictext within w_webbrowser
end type
type sle_url from singlelineedit within w_webbrowser
end type
type cb_go from commandbutton within w_webbrowser
end type
type cb_back from commandbutton within w_webbrowser
end type
type cb_forward from commandbutton within w_webbrowser
end type
type cb_html from commandbutton within w_webbrowser
end type
type wb_1 from webbrowser within w_webbrowser
end type
type st_js from statictext within w_webbrowser
end type
type sle_js from singlelineedit within w_webbrowser
end type
type cb_eval from commandbutton within w_webbrowser
end type
type mle_log from multilineedit within w_webbrowser
end type
type cb_close from commandbutton within w_webbrowser
end type
end forward

global type w_webbrowser from w_center
integer width = 3255
integer height = 2060
string title = "WebBrowser Control"
st_intro st_intro
sle_url sle_url
cb_go cb_go
cb_back cb_back
cb_forward cb_forward
cb_html cb_html
wb_1 wb_1
st_js st_js
sle_js sle_js
cb_eval cb_eval
mle_log mle_log
cb_close cb_close
end type
global w_webbrowser w_webbrowser

type variables
Boolean	ib_EventRegistered
end variables

forward prototypes
public subroutine of_log (string as_text)
end prototypes

public subroutine of_log (string as_text);mle_log.Text = String(Now(), "hh:mm:ss") + "  " + as_text + "~r~n" + mle_log.Text
end subroutine

on w_webbrowser.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.sle_url=create sle_url
this.cb_go=create cb_go
this.cb_back=create cb_back
this.cb_forward=create cb_forward
this.cb_html=create cb_html
this.wb_1=create wb_1
this.st_js=create st_js
this.sle_js=create sle_js
this.cb_eval=create cb_eval
this.mle_log=create mle_log
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.sle_url
this.Control[iCurrent+3]=this.cb_go
this.Control[iCurrent+4]=this.cb_back
this.Control[iCurrent+5]=this.cb_forward
this.Control[iCurrent+6]=this.cb_html
this.Control[iCurrent+7]=this.wb_1
this.Control[iCurrent+8]=this.st_js
this.Control[iCurrent+9]=this.sle_js
this.Control[iCurrent+10]=this.cb_eval
this.Control[iCurrent+11]=this.mle_log
this.Control[iCurrent+12]=this.cb_close
end on

on w_webbrowser.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.sle_url)
destroy(this.cb_go)
destroy(this.cb_back)
destroy(this.cb_forward)
destroy(this.cb_html)
destroy(this.wb_1)
destroy(this.st_js)
destroy(this.sle_js)
destroy(this.cb_eval)
destroy(this.mle_log)
destroy(this.cb_close)
end on

event open;call super::open;wb_1.Post Navigate(sle_url.Text)
end event

type st_intro from statictext within w_webbrowser
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
string text = "The WebBrowser control embeds Microsoft Edge WebView2, a modern Chromium-based browser engine.  PowerScript can run JavaScript in the page with EvaluateJavascriptSync, and JavaScript can call back into PowerBuilder through user events registered with RegisterEvent (window.webBrowser.<eventname>)."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type sle_url from singlelineedit within w_webbrowser
integer x = 37
integer y = 168
integer width = 1975
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "https://www.appeon.com"
borderstyle borderstyle = stylelowered!
end type

type cb_go from commandbutton within w_webbrowser
integer x = 2030
integer y = 164
integer width = 270
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;wb_1.Navigate(sle_url.Text)
end event

type cb_back from commandbutton within w_webbrowser
integer x = 2318
integer y = 164
integer width = 270
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "< &Back"
end type

event clicked;wb_1.GoBack()
end event

type cb_forward from commandbutton within w_webbrowser
integer x = 2606
integer y = 164
integer width = 270
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Fwd >"
end type

event clicked;wb_1.GoForward()
end event

type cb_html from commandbutton within w_webbrowser
integer x = 2894
integer y = 164
integer width = 288
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Demo"
end type

event clicked;// Load an HTML page from a string; its button calls the PowerBuilder user event ue_from_js
String	ls_Html

ls_Html = '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>JavaScript and PowerBuilder</title><style>' + &
	'body{font-family:Segoe UI,sans-serif;margin:24px;color:#222} input{font-size:14px;padding:4px;width:260px}' + &
	'button{font-size:14px;padding:4px 12px} #reply{margin-top:12px;color:#0a6}</style></head><body>' + &
	'<h2>JavaScript &harr; PowerBuilder</h2>' + &
	'<p>Type a message and send it to PowerBuilder. The PowerScript user event returns a reply.</p>' + &
	'<input id="msg" value="Hello from JavaScript"> ' + &
	'<button onclick="var r = window.webBrowser.ue_from_js(document.getElementById(~'msg~').value);' + &
	' document.getElementById(~'reply~').innerText = r;">Call PowerBuilder</button>' + &
	'<div id="reply"></div><p id="counter">PowerScript has changed this text 0 times.</p>' + &
	'</body></html>'

wb_1.NavigateToString(ls_Html)
sle_js.Text = "document.getElementById('counter').innerText = 'Changed by PowerScript at ' + new Date().toLocaleTimeString(); document.title"
end event

type wb_1 from webbrowser within w_webbrowser
event type string ue_from_js ( string as_message )
integer x = 37
integer y = 284
integer width = 3145
integer height = 1020
end type

event ue_from_js;// Called from JavaScript: window.webBrowser.ue_from_js('...')
// Note: do not call Navigate/EvaluateJavascriptSync from inside this event.
of_log("JavaScript called ue_from_js: " + as_message)
Return "PowerBuilder received ~"" + as_message + "~" at " + String(Now(), "hh:mm:ss")
end event

event navigationstart;// The browser is fully initialized once navigation starts - register the JS callback now
If Not ib_EventRegistered Then
	If This.RegisterEvent("ue_from_js") = 1 Then
		ib_EventRegistered = True
		of_log("Registered ue_from_js for JavaScript callbacks")
	End If
End If
end event

event titletextchanged;of_log("Page title: " + titletext)
end event

type st_js from statictext within w_webbrowser
integer x = 37
integer y = 1340
integer width = 400
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "JavaScript:"
boolean focusrectangle = false
end type

type sle_js from singlelineedit within w_webbrowser
integer x = 439
integer y = 1324
integer width = 2111
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "document.title + ' | ' + location.href"
borderstyle borderstyle = stylelowered!
end type

type cb_eval from commandbutton within w_webbrowser
integer x = 2568
integer y = 1320
integer width = 614
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&EvaluateJavascriptSync"
end type

event clicked;Integer	li_Rc
String	ls_Result, ls_Error

li_Rc = wb_1.EvaluateJavascriptSync(sle_js.Text, ls_Result, ls_Error)
If li_Rc = 1 Then
	of_log("Result: " + ls_Result)
Else
	of_log("Error " + String(li_Rc) + ": " + ls_Error)
End If
end event

type mle_log from multilineedit within w_webbrowser
integer x = 37
integer y = 1440
integer width = 3145
integer height = 360
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

type cb_close from commandbutton within w_webbrowser
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
