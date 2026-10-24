//objectcomments PB 2017 R2+ RESTClient and HTTPClient objects
forward
global type w_rest_client from w_center
end type
type st_intro from statictext within w_rest_client
end type
type st_url from statictext within w_rest_client
end type
type sle_url from singlelineedit within w_rest_client
end type
type cb_retrieve from commandbutton within w_rest_client
end type
type dw_users from datawindow within w_rest_client
end type
type cb_get from commandbutton within w_rest_client
end type
type cb_post from commandbutton within w_rest_client
end type
type cb_send_get from commandbutton within w_rest_client
end type
type mle_response from multilineedit within w_rest_client
end type
type st_status from statictext within w_rest_client
end type
type cb_close from commandbutton within w_rest_client
end type
end forward

global type w_rest_client from w_center
integer width = 3255
integer height = 2060
string title = "RESTClient & HTTPClient"
st_intro st_intro
st_url st_url
sle_url sle_url
cb_retrieve cb_retrieve
dw_users dw_users
cb_get cb_get
cb_post cb_post
cb_send_get cb_send_get
mle_response mle_response
st_status st_status
cb_close cb_close
end type
global w_rest_client w_rest_client

on w_rest_client.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_url=create st_url
this.sle_url=create sle_url
this.cb_retrieve=create cb_retrieve
this.dw_users=create dw_users
this.cb_get=create cb_get
this.cb_post=create cb_post
this.cb_send_get=create cb_send_get
this.mle_response=create mle_response
this.st_status=create st_status
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_url
this.Control[iCurrent+3]=this.sle_url
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.dw_users
this.Control[iCurrent+6]=this.cb_get
this.Control[iCurrent+7]=this.cb_post
this.Control[iCurrent+8]=this.cb_send_get
this.Control[iCurrent+9]=this.mle_response
this.Control[iCurrent+10]=this.st_status
this.Control[iCurrent+11]=this.cb_close
end on

on w_rest_client.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_url)
destroy(this.sle_url)
destroy(this.cb_retrieve)
destroy(this.dw_users)
destroy(this.cb_get)
destroy(this.cb_post)
destroy(this.cb_send_get)
destroy(this.mle_response)
destroy(this.st_status)
destroy(this.cb_close)
end on

type st_intro from statictext within w_rest_client
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
string text = "RESTClient.Retrieve calls a RESTful API and loads the JSON response straight into a DataWindow when the JSON keys match the column names.  HTTPClient gives full control of any HTTP request (method, headers, body, status).  This example uses the free test API at jsonplaceholder.typicode.com, so it needs internet access."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_url from statictext within w_rest_client
integer x = 37
integer y = 184
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
string text = "URL:"
boolean focusrectangle = false
end type

type sle_url from singlelineedit within w_rest_client
integer x = 201
integer y = 168
integer width = 2153
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "https://jsonplaceholder.typicode.com/users"
borderstyle borderstyle = stylelowered!
end type

type cb_retrieve from commandbutton within w_rest_client
integer x = 2372
integer y = 164
integer width = 809
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&RESTClient.Retrieve"
end type

event clicked;RestClient	lnv_Rest
Long			ll_Rows

SetPointer(HourGlass!)
lnv_Rest = Create RestClient
lnv_Rest.SetRequestHeader("Accept", "application/json")

ll_Rows = lnv_Rest.Retrieve(dw_users, sle_url.Text)
If ll_Rows >= 0 Then
	st_status.Text = "RESTClient.Retrieve returned " + String(ll_Rows) + " row(s)."
Else
	st_status.Text = "RESTClient.Retrieve failed with code " + String(ll_Rows) + " (see 'RESTClient error codes' in the help)."
End If

Destroy lnv_Rest
end event

type dw_users from datawindow within w_rest_client
integer x = 37
integer y = 284
integer width = 3145
integer height = 700
integer taborder = 30
string title = "none"
string dataobject = "d_nf_rest_users"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_get from commandbutton within w_rest_client
integer x = 37
integer y = 1008
integer width = 700
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "HTTPClient &GET"
end type

event clicked;HttpClient	lnv_Http
Integer		li_Rc
String		ls_Body

SetPointer(HourGlass!)
lnv_Http = Create HttpClient
lnv_Http.SetRequestHeader("Accept", "application/json")

li_Rc = lnv_Http.SendRequest("GET", sle_url.Text)
If li_Rc = 1 Then
	lnv_Http.GetResponseBody(ls_Body)
	st_status.Text = "GET " + sle_url.Text + "  ->  HTTP " + String(lnv_Http.GetResponseStatusCode()) + " " + lnv_Http.GetResponseStatusText()
	mle_response.Text = lnv_Http.GetResponseHeaders() + "~r~n" + ls_Body
Else
	st_status.Text = "SendRequest failed with code " + String(li_Rc)
End If

Destroy lnv_Http
end event

type cb_post from commandbutton within w_rest_client
integer x = 755
integer y = 1008
integer width = 700
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "HTTPClient &POST JSON"
end type

event clicked;// POST a JSON body built with JSONGenerator, then read the id the server assigned
HttpClient		lnv_Http
JsonGenerator	lnv_Gen
JsonParser		lnv_Parser
Integer			li_Rc
Long				ll_Root
String			ls_Json, ls_Body

SetPointer(HourGlass!)
lnv_Gen = Create JsonGenerator
ll_Root = lnv_Gen.CreateJsonObject()
lnv_Gen.AddItemString(ll_Root, "title", "Hello from PowerBuilder")
lnv_Gen.AddItemString(ll_Root, "body", "Sent with HTTPClient.SendRequest(~"POST~", ...)")
lnv_Gen.AddItemNumber(ll_Root, "userId", 1)
ls_Json = lnv_Gen.GetJsonString()

lnv_Http = Create HttpClient
lnv_Http.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")
li_Rc = lnv_Http.SendRequest("POST", "https://jsonplaceholder.typicode.com/posts", ls_Json)

If li_Rc = 1 Then
	lnv_Http.GetResponseBody(ls_Body)
	lnv_Parser = Create JsonParser
	If Len(lnv_Parser.LoadString(ls_Body)) = 0 Then
		st_status.Text = "POST -> HTTP " + String(lnv_Http.GetResponseStatusCode()) + &
			", new id = " + String(lnv_Parser.GetItemNumber(lnv_Parser.GetRootItem(), "id"))
	End If
	Destroy lnv_Parser
	mle_response.Text = "Request body:~r~n" + ls_Json + "~r~n~r~nResponse body:~r~n" + ls_Body
Else
	st_status.Text = "SendRequest failed with code " + String(li_Rc)
End If

Destroy lnv_Gen
Destroy lnv_Http
end event

type cb_send_get from commandbutton within w_rest_client
integer x = 1473
integer y = 1008
integer width = 700
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "RESTClient.&SendGetRequest"
end type

event clicked;RestClient	lnv_Rest
Integer		li_Rc
String		ls_Response

SetPointer(HourGlass!)
lnv_Rest = Create RestClient
li_Rc = lnv_Rest.SendGetRequest(sle_url.Text, ls_Response)
st_status.Text = "SendGetRequest returned " + String(li_Rc) + ", HTTP " + String(lnv_Rest.GetResponseStatusCode())
mle_response.Text = ls_Response
Destroy lnv_Rest
end event

type mle_response from multilineedit within w_rest_client
integer x = 37
integer y = 1132
integer width = 3145
integer height = 580
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
boolean displayonly = true
boolean hscrollbar = true
boolean autohscroll = true
end type

type st_status from statictext within w_rest_client
integer x = 37
integer y = 1736
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
string text = ""
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_rest_client
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
