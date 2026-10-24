//objectcomments PB 2017 R3+ CoderObject and CrypterObject
forward
global type w_crypter_coder from w_center
end type
type st_intro from statictext within w_crypter_coder
end type
type st_text from statictext within w_crypter_coder
end type
type sle_text from singlelineedit within w_crypter_coder
end type
type st_key from statictext within w_crypter_coder
end type
type sle_key from singlelineedit within w_crypter_coder
end type
type cb_encode from commandbutton within w_crypter_coder
end type
type cb_hash from commandbutton within w_crypter_coder
end type
type cb_aes from commandbutton within w_crypter_coder
end type
type mle_output from multilineedit within w_crypter_coder
end type
type cb_close from commandbutton within w_crypter_coder
end type
end forward

global type w_crypter_coder from w_center
integer width = 3255
integer height = 2060
string title = "Encoding, Hashing & Encryption"
st_intro st_intro
st_text st_text
sle_text sle_text
st_key st_key
sle_key sle_key
cb_encode cb_encode
cb_hash cb_hash
cb_aes cb_aes
mle_output mle_output
cb_close cb_close
end type
global w_crypter_coder w_crypter_coder

forward prototypes
public subroutine of_show (string as_label, string as_value)
end prototypes

public subroutine of_show (string as_label, string as_value);mle_output.Text += Left(as_label + Fill(" ", 22), 22) + as_value + "~r~n"
end subroutine

on w_crypter_coder.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_text=create st_text
this.sle_text=create sle_text
this.st_key=create st_key
this.sle_key=create sle_key
this.cb_encode=create cb_encode
this.cb_hash=create cb_hash
this.cb_aes=create cb_aes
this.mle_output=create mle_output
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_text
this.Control[iCurrent+3]=this.sle_text
this.Control[iCurrent+4]=this.st_key
this.Control[iCurrent+5]=this.sle_key
this.Control[iCurrent+6]=this.cb_encode
this.Control[iCurrent+7]=this.cb_hash
this.Control[iCurrent+8]=this.cb_aes
this.Control[iCurrent+9]=this.mle_output
this.Control[iCurrent+10]=this.cb_close
end on

on w_crypter_coder.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_text)
destroy(this.sle_text)
destroy(this.st_key)
destroy(this.sle_key)
destroy(this.cb_encode)
destroy(this.cb_hash)
destroy(this.cb_aes)
destroy(this.mle_output)
destroy(this.cb_close)
end on

type st_intro from statictext within w_crypter_coder
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
string text = "CoderObject encodes and decodes Base64, Base64Url, Hex and URL text.  CrypterObject computes MD5, SHA-1/2/3 and HMAC digests and performs symmetric (AES, DES, Blowfish) and asymmetric encryption - no external DLLs or Windows API calls required.  Work with blobs and pick the text encoding explicitly (UTF-8 here)."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_text from statictext within w_crypter_coder
integer x = 37
integer y = 188
integer width = 500
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text to process:"
boolean focusrectangle = false
end type

type sle_text from singlelineedit within w_crypter_coder
integer x = 549
integer y = 172
integer width = 2633
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "PowerBuilder speaks modern crypto!"
borderstyle borderstyle = stylelowered!
end type

type st_key from statictext within w_crypter_coder
integer x = 37
integer y = 300
integer width = 500
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Secret key / passphrase:"
boolean focusrectangle = false
end type

type sle_key from singlelineedit within w_crypter_coder
integer x = 549
integer y = 284
integer width = 2633
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "my-demo-secret"
borderstyle borderstyle = stylelowered!
end type

type cb_encode from commandbutton within w_crypter_coder
integer x = 37
integer y = 412
integer width = 700
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Encode / Decode"
end type

event clicked;CoderObject	lnv_Coder
Blob			lblb_Data
String		ls_Base64

lnv_Coder = Create CoderObject
lblb_Data = Blob(sle_text.Text, EncodingUTF8!)

mle_output.Text = "CoderObject~r~n-----------~r~n"
ls_Base64 = lnv_Coder.Base64Encode(lblb_Data)
of_show("Base64Encode", ls_Base64)
of_show("Base64UrlEncode", lnv_Coder.Base64UrlEncode(lblb_Data))
of_show("HexEncode", lnv_Coder.HexEncode(lblb_Data))
of_show("UrlEncode", lnv_Coder.UrlEncode(lblb_Data))
of_show("Base64Decode", String(lnv_Coder.Base64Decode(ls_Base64), EncodingUTF8!))

Destroy lnv_Coder
end event

type cb_hash from commandbutton within w_crypter_coder
integer x = 755
integer y = 412
integer width = 700
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Hash / HMAC"
end type

event clicked;CoderObject		lnv_Coder
CrypterObject	lnv_Crypter
Blob				lblb_Data, lblb_Key

lnv_Coder = Create CoderObject
lnv_Crypter = Create CrypterObject
lblb_Data = Blob(sle_text.Text, EncodingUTF8!)
lblb_Key = Blob(sle_key.Text, EncodingUTF8!)

mle_output.Text = "CrypterObject digests (shown as hex)~r~n------------------------------------~r~n"
of_show("MD5", lnv_Coder.HexEncode(lnv_Crypter.MD5(lblb_Data)))
of_show("SHA1", lnv_Coder.HexEncode(lnv_Crypter.SHA(SHA1!, lblb_Data)))
of_show("SHA256", lnv_Coder.HexEncode(lnv_Crypter.SHA(SHA256!, lblb_Data)))
of_show("SHA512", lnv_Coder.HexEncode(lnv_Crypter.SHA(SHA512!, lblb_Data)))
of_show("SHA3-256", lnv_Coder.HexEncode(lnv_Crypter.SHA(SHA3_256!, lblb_Data)))
of_show("HMAC-SHA256 (key)", lnv_Coder.HexEncode(lnv_Crypter.HMAC(HMACSHA256!, lblb_Data, lblb_Key)))

Destroy lnv_Coder
Destroy lnv_Crypter
end event

type cb_aes from commandbutton within w_crypter_coder
integer x = 1473
integer y = 412
integer width = 900
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&AES-256 Encrypt + Decrypt"
end type

event clicked;// Derive a 32-byte AES-256 key from the passphrase with SHA-256.
// The IV is derived too, purely so the demo is repeatable - in real code use a random IV
// and store it alongside the cipher text.
CoderObject		lnv_Coder
CrypterObject	lnv_Crypter
Blob				lblb_Data, lblb_Key, lblb_IV, lblb_Encrypted, lblb_Decrypted

lnv_Coder = Create CoderObject
lnv_Crypter = Create CrypterObject

lblb_Data = Blob(sle_text.Text, EncodingUTF8!)
lblb_Key = lnv_Crypter.SHA(SHA256!, Blob(sle_key.Text, EncodingUTF8!))
lblb_IV = lnv_Crypter.MD5(Blob(sle_key.Text + "/iv", EncodingUTF8!))

lblb_Encrypted = lnv_Crypter.SymmetricEncrypt(AES!, lblb_Data, lblb_Key, OperationModeCBC!, lblb_IV, PKCSPadding!)
lblb_Decrypted = lnv_Crypter.SymmetricDecrypt(AES!, lblb_Encrypted, lblb_Key, OperationModeCBC!, lblb_IV, PKCSPadding!)

mle_output.Text = "AES-256 / CBC / PKCS padding~r~n----------------------------~r~n"
of_show("Key (hex)", lnv_Coder.HexEncode(lblb_Key))
of_show("IV (hex)", lnv_Coder.HexEncode(lblb_IV))
of_show("Cipher text (Base64)", lnv_Coder.Base64Encode(lblb_Encrypted))
of_show("Decrypted", String(lblb_Decrypted, EncodingUTF8!))

Destroy lnv_Coder
Destroy lnv_Crypter
end event

type mle_output from multilineedit within w_crypter_coder
integer x = 37
integer y = 540
integer width = 3145
integer height = 1240
integer taborder = 60
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

type cb_close from commandbutton within w_crypter_coder
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
