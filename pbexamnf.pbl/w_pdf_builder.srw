//objectcomments PB 2022+ PDF Builder objects and native DataWindow PDF export
forward
global type w_pdf_builder from w_center
end type
type st_intro from statictext within w_pdf_builder
end type
type dw_1 from datawindow within w_pdf_builder
end type
type st_title from statictext within w_pdf_builder
end type
type sle_title from singlelineedit within w_pdf_builder
end type
type st_author from statictext within w_pdf_builder
end type
type sle_author from singlelineedit within w_pdf_builder
end type
type cbx_protect from checkbox within w_pdf_builder
end type
type sle_password from singlelineedit within w_pdf_builder
end type
type cbx_noprint from checkbox within w_pdf_builder
end type
type cb_builder from commandbutton within w_pdf_builder
end type
type cb_native from commandbutton within w_pdf_builder
end type
type st_status from statictext within w_pdf_builder
end type
type cb_close from commandbutton within w_pdf_builder
end type
end forward

global type w_pdf_builder from w_center
integer width = 3255
integer height = 2060
string title = "PDF Builder"
st_intro st_intro
dw_1 dw_1
st_title st_title
sle_title sle_title
st_author st_author
sle_author sle_author
cbx_protect cbx_protect
sle_password sle_password
cbx_noprint cbx_noprint
cb_builder cb_builder
cb_native cb_native
st_status st_status
cb_close cb_close
end type
global w_pdf_builder w_pdf_builder

forward prototypes
public function string of_temp_file (string as_name)
public subroutine of_offer_open (string as_file)
public function long of_build_pdf (string as_file)
public function integer of_save_native_pdf (string as_file)
end prototypes

public function string of_temp_file (string as_name);ContextKeyword	lcxk_Keyword
String			ls_Values[], ls_Dir

ls_Dir = GetCurrentDirectory()
If GetContextService("Keyword", lcxk_Keyword) = 1 Then
	lcxk_Keyword.GetContextKeywords("TEMP", ls_Values)
	If UpperBound(ls_Values) > 0 Then
		If Len(ls_Values[1]) > 0 Then ls_Dir = ls_Values[1]
	End If
End If

Return ls_Dir + "\" + as_name
end function

public subroutine of_offer_open (string as_file);st_status.Text = "Saved " + as_file
If MessageBox("PDF Created", "Saved:~r~n" + as_file + "~r~n~r~nOpen it now?", Question!, YesNo!) = 1 Then
	OpenUrl(as_file)
End If
end subroutine

public function long of_build_pdf (string as_file);// Builds a PDF with the PDF Builder objects and saves it to as_file.
// Returns the PDFDocument.Save return code (1 = success).
PDFDocument			lpdf_Doc
PDFPage				lpdf_Page
PDFText				lpdf_Title, lpdf_Date
PDFMultilineText	lpdf_Body
Long					ll_Rc

lpdf_Doc = Create PDFDocument
lpdf_Page = Create PDFPage
lpdf_Title = Create PDFText
lpdf_Date = Create PDFText
lpdf_Body = Create PDFMultilineText

// Cover page: title, date and a paragraph
lpdf_Title.Content = sle_title.Text
lpdf_Title.Font.FontSize = 28
lpdf_Title.Font.Bold = True
lpdf_Title.TextColor.RGB = RGB(0, 84, 147)
lpdf_Title.X = 50
lpdf_Title.Y = 60
lpdf_Page.AddContent(lpdf_Title)

lpdf_Date.Content = "Generated " + String(Today(), "mmmm d, yyyy") + " at " + String(Now(), "hh:mm")
lpdf_Date.X = 50
lpdf_Date.Y = 110
lpdf_Page.AddContent(lpdf_Date)

lpdf_Body.Content = "This document was created entirely in PowerScript with the PDF Builder objects. " + &
	"The cover page is made from PDFText and PDFMultilineText objects; the next page is the DataWindow " + &
	"on screen, added with PDFDocument.ImportDataWindow. Metadata, passwords and permissions are set " + &
	"through the Properties and Security objects."
lpdf_Body.X = 50
lpdf_Body.Y = 160
lpdf_Body.Width = 480
lpdf_Page.AddContent(lpdf_Body)
lpdf_Doc.AddPage(lpdf_Page)

// Then the DataWindow itself
lpdf_Doc.ImportDataWindow(dw_1)

// Metadata and security
lpdf_Doc.Properties.Title = sle_title.Text
lpdf_Doc.Properties.Author = sle_author.Text
lpdf_Doc.Properties.Subject = "PowerBuilder PDF Builder example"
If cbx_protect.Checked Then
	lpdf_Doc.Security.UserPassword = sle_password.Text
	lpdf_Doc.Security.MasterPassword = sle_password.Text + "-owner"
End If
If cbx_noprint.Checked Then
	If Len(lpdf_Doc.Security.MasterPassword) = 0 Then lpdf_Doc.Security.MasterPassword = "owner-" + String(Now(), "hhmmss")
	lpdf_Doc.Security.AllowPrint = False
	lpdf_Doc.Security.AllowCopy = False
End If

ll_Rc = lpdf_Doc.Save(as_file)

Destroy lpdf_Body
Destroy lpdf_Date
Destroy lpdf_Title
Destroy lpdf_Page
Destroy lpdf_Doc

Return ll_Rc
end function

public function integer of_save_native_pdf (string as_file);// One line export of a DataWindow using the built-in NativePDF engine
dw_1.Modify("DataWindow.Export.PDF.Method=2")
Return dw_1.SaveAs(as_file, PDF!, True)
end function

on w_pdf_builder.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.dw_1=create dw_1
this.st_title=create st_title
this.sle_title=create sle_title
this.st_author=create st_author
this.sle_author=create sle_author
this.cbx_protect=create cbx_protect
this.sle_password=create sle_password
this.cbx_noprint=create cbx_noprint
this.cb_builder=create cb_builder
this.cb_native=create cb_native
this.st_status=create st_status
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_title
this.Control[iCurrent+4]=this.sle_title
this.Control[iCurrent+5]=this.st_author
this.Control[iCurrent+6]=this.sle_author
this.Control[iCurrent+7]=this.cbx_protect
this.Control[iCurrent+8]=this.sle_password
this.Control[iCurrent+9]=this.cbx_noprint
this.Control[iCurrent+10]=this.cb_builder
this.Control[iCurrent+11]=this.cb_native
this.Control[iCurrent+12]=this.st_status
this.Control[iCurrent+13]=this.cb_close
end on

on w_pdf_builder.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.dw_1)
destroy(this.st_title)
destroy(this.sle_title)
destroy(this.st_author)
destroy(this.sle_author)
destroy(this.cbx_protect)
destroy(this.sle_password)
destroy(this.cbx_noprint)
destroy(this.cb_builder)
destroy(this.cb_native)
destroy(this.st_status)
destroy(this.cb_close)
end on

type st_intro from statictext within w_pdf_builder
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
string text = "The PDF Builder objects (PDFDocument, PDFPage, PDFText, PDFMultilineText, PDFImage, PDFSecurity ...) create PDF files in code: add text and images, import DataWindows and existing PDFs, and set metadata, passwords and permissions.  DataWindows can also be saved straight to PDF with the built-in NativePDF method - no Ghostscript needed."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type dw_1 from datawindow within w_pdf_builder
integer x = 37
integer y = 240
integer width = 3145
integer height = 860
integer taborder = 10
string title = "none"
string dataobject = "d_nf_employees"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_title from statictext within w_pdf_builder
integer x = 37
integer y = 1136
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
string text = "Document title:"
boolean focusrectangle = false
end type

type sle_title from singlelineedit within w_pdf_builder
integer x = 457
integer y = 1120
integer width = 1100
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Employee Report"
borderstyle borderstyle = stylelowered!
end type

type st_author from statictext within w_pdf_builder
integer x = 1632
integer y = 1136
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
string text = "Author:"
boolean focusrectangle = false
end type

type sle_author from singlelineedit within w_pdf_builder
integer x = 1952
integer y = 1120
integer width = 1230
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "PowerBuilder Examples"
borderstyle borderstyle = stylelowered!
end type

type cbx_protect from checkbox within w_pdf_builder
integer x = 37
integer y = 1240
integer width = 1100
integer height = 80
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Protect: require a password to open"
end type

type sle_password from singlelineedit within w_pdf_builder
integer x = 1150
integer y = 1232
integer width = 407
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "secret"
borderstyle borderstyle = stylelowered!
boolean password = true
end type

type cbx_noprint from checkbox within w_pdf_builder
integer x = 1632
integer y = 1240
integer width = 1100
integer height = 80
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Do not allow printing or copying"
end type

type cb_builder from commandbutton within w_pdf_builder
integer x = 37
integer y = 1364
integer width = 1100
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Build PDF with PDF Builder"
end type

event clicked;String	ls_File
Long		ll_Rc

ls_File = of_temp_file("pb_pdf_builder_demo.pdf")
ll_Rc = of_build_pdf(ls_File)
If ll_Rc = 1 Then
	of_offer_open(ls_File)
Else
	st_status.Text = "PDFDocument.Save failed with code " + String(ll_Rc)
End If
end event

type cb_native from commandbutton within w_pdf_builder
integer x = 1155
integer y = 1364
integer width = 1100
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "DataWindow &SaveAs NativePDF"
end type

event clicked;String	ls_File

ls_File = of_temp_file("pb_nativepdf_demo.pdf")
If of_save_native_pdf(ls_File) = 1 Then
	of_offer_open(ls_File)
Else
	st_status.Text = "SaveAs PDF failed."
End If
end event

type st_status from statictext within w_pdf_builder
integer x = 37
integer y = 1508
integer width = 3145
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

type cb_close from commandbutton within w_pdf_builder
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
