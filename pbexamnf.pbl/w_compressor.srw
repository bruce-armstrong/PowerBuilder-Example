//objectcomments PB 2019+ CompressorObject and ExtractorObject
forward
global type w_compressor from w_center
end type
type st_intro from statictext within w_compressor
end type
type st_files from statictext within w_compressor
end type
type lb_files from listbox within w_compressor
end type
type cb_add from commandbutton within w_compressor
end type
type cb_clear from commandbutton within w_compressor
end type
type st_password from statictext within w_compressor
end type
type sle_password from singlelineedit within w_compressor
end type
type st_zip from statictext within w_compressor
end type
type sle_zip from singlelineedit within w_compressor
end type
type cb_zip from commandbutton within w_compressor
end type
type st_contents from statictext within w_compressor
end type
type lb_contents from listbox within w_compressor
end type
type cb_list from commandbutton within w_compressor
end type
type cb_extract from commandbutton within w_compressor
end type
type gb_blob from groupbox within w_compressor
end type
type cb_blob from commandbutton within w_compressor
end type
type st_status from statictext within w_compressor
end type
type cb_close from commandbutton within w_compressor
end type
end forward

global type w_compressor from w_center
integer width = 3255
integer height = 2060
string title = "Zip and Unzip (Compressor / Extractor)"
st_intro st_intro
st_files st_files
lb_files lb_files
cb_add cb_add
cb_clear cb_clear
st_password st_password
sle_password sle_password
st_zip st_zip
sle_zip sle_zip
cb_zip cb_zip
st_contents st_contents
lb_contents lb_contents
cb_list cb_list
cb_extract cb_extract
gb_blob gb_blob
cb_blob cb_blob
st_status st_status
cb_close cb_close
end type
global w_compressor w_compressor

forward prototypes
public function string of_temp_dir ()
public subroutine of_add_file (string as_file)
end prototypes

public function string of_temp_dir ();// Returns the user's TEMP folder using the Keyword context service
ContextKeyword	lcxk_Keyword
String			ls_Values[]

If GetContextService("Keyword", lcxk_Keyword) = 1 Then
	lcxk_Keyword.GetContextKeywords("TEMP", ls_Values)
End If

If UpperBound(ls_Values) > 0 Then
	If Len(ls_Values[1]) > 0 Then Return ls_Values[1]
End If

Return GetCurrentDirectory()
end function

public subroutine of_add_file (string as_file);If FileExists(as_file) Then lb_files.AddItem(as_file)
end subroutine

on w_compressor.create
int iCurrent
call super::create
this.st_intro=create st_intro
this.st_files=create st_files
this.lb_files=create lb_files
this.cb_add=create cb_add
this.cb_clear=create cb_clear
this.st_password=create st_password
this.sle_password=create sle_password
this.st_zip=create st_zip
this.sle_zip=create sle_zip
this.cb_zip=create cb_zip
this.st_contents=create st_contents
this.lb_contents=create lb_contents
this.cb_list=create cb_list
this.cb_extract=create cb_extract
this.cb_blob=create cb_blob
this.st_status=create st_status
this.cb_close=create cb_close
this.gb_blob=create gb_blob
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_intro
this.Control[iCurrent+2]=this.st_files
this.Control[iCurrent+3]=this.lb_files
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_clear
this.Control[iCurrent+6]=this.st_password
this.Control[iCurrent+7]=this.sle_password
this.Control[iCurrent+8]=this.st_zip
this.Control[iCurrent+9]=this.sle_zip
this.Control[iCurrent+10]=this.cb_zip
this.Control[iCurrent+11]=this.st_contents
this.Control[iCurrent+12]=this.lb_contents
this.Control[iCurrent+13]=this.cb_list
this.Control[iCurrent+14]=this.cb_extract
this.Control[iCurrent+15]=this.cb_blob
this.Control[iCurrent+16]=this.st_status
this.Control[iCurrent+17]=this.cb_close
this.Control[iCurrent+18]=this.gb_blob
end on

on w_compressor.destroy
call super::destroy
destroy(this.st_intro)
destroy(this.st_files)
destroy(this.lb_files)
destroy(this.cb_add)
destroy(this.cb_clear)
destroy(this.st_password)
destroy(this.sle_password)
destroy(this.st_zip)
destroy(this.sle_zip)
destroy(this.cb_zip)
destroy(this.st_contents)
destroy(this.lb_contents)
destroy(this.cb_list)
destroy(this.cb_extract)
destroy(this.gb_blob)
destroy(this.cb_blob)
destroy(this.st_status)
destroy(this.cb_close)
end on

event open;call super::open;String	ls_Dir

// Start with a few of the example application's own files
ls_Dir = GetCurrentDirectory() + "\"
of_add_file(ls_Dir + "example.bmp")
of_add_file(ls_Dir + "images\puzzle\puzzle.png")
of_add_file(ls_Dir + "exampl.chm")
of_add_file(ls_Dir + "README.md")

sle_zip.Text = of_temp_dir() + "\pb_examples_demo.zip"
end event

type st_intro from statictext within w_compressor
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
string text = "CompressorObject creates ZIP, 7Z, GZIP and TAR archives (optionally AES-256 password protected) from files, folders or blobs.  ExtractorObject lists and extracts archive contents.  Both replace the third-party DLLs PowerBuilder applications used to need for this."
boolean focusrectangle = false
long bordercolor = 134217728
end type

type st_files from statictext within w_compressor
integer x = 37
integer y = 240
integer width = 1500
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Files to compress:"
boolean focusrectangle = false
end type

type lb_files from listbox within w_compressor
integer x = 37
integer y = 308
integer width = 1550
integer height = 680
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean hscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_add from commandbutton within w_compressor
integer x = 37
integer y = 1008
integer width = 500
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Files..."
end type

event clicked;String	ls_Path, ls_Files[]
Integer	li_Index

If GetFileOpenName("Select Files to Compress", ls_Path, ls_Files, "", "All Files (*.*),*.*", GetCurrentDirectory()) <> 1 Then Return

If UpperBound(ls_Files) = 1 Then
	of_add_file(ls_Path)
Else
	For li_Index = 1 To UpperBound(ls_Files)
		of_add_file(ls_Path + "\" + ls_Files[li_Index])
	Next
End If
end event

type cb_clear from commandbutton within w_compressor
integer x = 555
integer y = 1008
integer width = 500
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&lear List"
end type

event clicked;lb_files.Reset()
end event

type st_password from statictext within w_compressor
integer x = 37
integer y = 1152
integer width = 504
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password (optional):"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_compressor
integer x = 549
integer y = 1136
integer width = 1038
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
boolean password = true
end type

type st_zip from statictext within w_compressor
integer x = 37
integer y = 1264
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
string text = "Archive file:"
boolean focusrectangle = false
end type

type sle_zip from singlelineedit within w_compressor
integer x = 549
integer y = 1248
integer width = 1038
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
end type

type cb_zip from commandbutton within w_compressor
integer x = 37
integer y = 1368
integer width = 1550
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Compress to ZIP"
end type

event clicked;CompressorObject	lnv_Compressor
String				ls_Sources[]
Integer				li_Index, li_Rc

If lb_files.TotalItems() = 0 Then
	MessageBox("Compress", "Add at least one file first.")
	Return
End If

For li_Index = 1 To lb_files.TotalItems()
	ls_Sources[li_Index] = lb_files.Text(li_Index)
Next

SetPointer(HourGlass!)
lnv_Compressor = Create CompressorObject
If Len(sle_password.Text) > 0 Then lnv_Compressor.Password = sle_password.Text

li_Rc = lnv_Compressor.Compress(ls_Sources, sle_zip.Text, ArchiveFormatZIP!)
If li_Rc = 1 Then
	st_status.Text = "Created " + sle_zip.Text + " (" + String(FileLength64(sle_zip.Text), "#,##0") + " bytes)."
	cb_list.Event Clicked()
Else
	st_status.Text = "Compress failed with code " + String(li_Rc)
End If

Destroy lnv_Compressor
end event

type st_contents from statictext within w_compressor
integer x = 1632
integer y = 240
integer width = 1500
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Archive contents (ExtractorObject.GetFilesList):"
boolean focusrectangle = false
end type

type lb_contents from listbox within w_compressor
integer x = 1632
integer y = 308
integer width = 1550
integer height = 680
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean hscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_list from commandbutton within w_compressor
integer x = 1632
integer y = 1008
integer width = 500
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "L&ist Contents"
end type

event clicked;ExtractorObject	lnv_Extractor
String				ls_List[]
Integer				li_Index, li_Rc

lb_contents.Reset()
lnv_Extractor = Create ExtractorObject
If Len(sle_password.Text) > 0 Then lnv_Extractor.Password = sle_password.Text

li_Rc = lnv_Extractor.GetFilesList(sle_zip.Text, ls_List)
If li_Rc = 1 Then
	For li_Index = 1 To UpperBound(ls_List)
		lb_contents.AddItem(ls_List[li_Index])
	Next
Else
	st_status.Text = "GetFilesList failed with code " + String(li_Rc)
End If

Destroy lnv_Extractor
end event

type cb_extract from commandbutton within w_compressor
integer x = 2150
integer y = 1008
integer width = 640
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Extract To Folder..."
end type

event clicked;ExtractorObject	lnv_Extractor
String				ls_Folder
Integer				li_Rc

If GetFolder("Extract the archive to", ls_Folder) <> 1 Then Return

SetPointer(HourGlass!)
lnv_Extractor = Create ExtractorObject
If Len(sle_password.Text) > 0 Then lnv_Extractor.Password = sle_password.Text

li_Rc = lnv_Extractor.Extract(sle_zip.Text, ls_Folder)
If li_Rc = 1 Then
	st_status.Text = "Extracted " + sle_zip.Text + " to " + ls_Folder
Else
	st_status.Text = "Extract failed with code " + String(li_Rc)
End If

Destroy lnv_Extractor
end event

type gb_blob from groupbox within w_compressor
integer x = 1632
integer y = 1136
integer width = 1550
integer height = 340
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "In-memory compression"
end type

type cb_blob from commandbutton within w_compressor
integer x = 1673
integer y = 1228
integer width = 1468
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Compress a &Blob with GZIP and Back"
end type

event clicked;// Blobs can be compressed and extracted without touching the file system
CompressorObject	lnv_Compressor
ExtractorObject	lnv_Extractor
Blob					lblb_Original, lblb_Compressed, lblb_Restored
String				ls_Text

ls_Text = Fill("PowerBuilder 2025 native compression. ", 20000)
lblb_Original = Blob(ls_Text, EncodingUTF8!)

lnv_Compressor = Create CompressorObject
lnv_Extractor = Create ExtractorObject

lnv_Compressor.Compress(lblb_Original, lblb_Compressed, ArchiveFormatGZip!)
lnv_Extractor.Extract(lblb_Compressed, lblb_Restored, ArchiveFormatGZip!)

st_status.Text = String(Len(lblb_Original), "#,##0") + " bytes compressed to " + &
	String(Len(lblb_Compressed), "#,##0") + " bytes; round trip identical: " + &
	String(String(lblb_Restored, EncodingUTF8!) = ls_Text)

Destroy lnv_Compressor
Destroy lnv_Extractor
end event

type st_status from statictext within w_compressor
integer x = 37
integer y = 1508
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
string text = ""
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_compressor
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
