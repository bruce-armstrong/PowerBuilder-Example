//objectcomments Example of an OLE 2.0 control on a window
forward
global type w_ole_example from w_center
end type
type ole_1 from olecontrol within w_ole_example
end type
type lb_file from listbox within w_ole_example
end type
type st_1 from statictext within w_ole_example
end type
type st_5 from statictext within w_ole_example
end type
type st_4 from statictext within w_ole_example
end type
type st_3 from statictext within w_ole_example
end type
type st_2 from statictext within w_ole_example
end type
type st_type from statictext within w_ole_example
end type
type dw_ole from datawindow within w_ole_example
end type
type mle_desc from multilineedit within w_ole_example
end type
type sle_title from singlelineedit within w_ole_example
end type
end forward

global type w_ole_example from w_center
integer y = 164
integer width = 2917
integer height = 1604
string title = "OLE Example"
string menuname = "m_ole_example"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_loadfile pbm_custom01
event ue_loadobj pbm_custom02
event ue_pastespecial pbm_custom03
event ue_pastelink pbm_custom04
event ue_paste pbm_custom05
event ue_savetodb pbm_custom06
event ue_copy pbm_custom09
ole_1 ole_1
lb_file lb_file
st_1 st_1
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_type st_type
dw_ole dw_ole
mle_desc mle_desc
sle_title sle_title
end type
global w_ole_example w_ole_example

type variables
boolean ib_notsaved
end variables

forward prototypes
public function integer wf_save ()
public function integer wf_activate (omactivatetype aat_type)
end prototypes

on ue_loadfile;string ls_path,ls_filename
int li_rc, li_rc2

//this will prompt the user for a data file.
//using the insertfile() function, PowerBuilder will use the ole registry to determine which
//server is responsible for that data type.

//dont allow the user to lose object unless changes were 
//saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then Return
End If


GetFileOpenName("select file to open",ls_path,ls_filename)

If ls_filename ="" Then return

If ole_1.insertfile(ls_path) = 0 Then

	//reset controls
	sle_title.text = ""
	sle_title.displayonly = false
	
	mle_desc.text = ""
	mle_desc.displayonly = false
	
	st_type.text = ole_1.classlongname
	this.title = "OLE Example"
	ib_notsaved = true
End If

end on

on ue_loadobj;int li_rc, li_rc2
string ls_typename
//dont allow the user to lose object unless changes were 
//saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then Return
End If


// Using the ole funtion insertobject() the user will
// be prompted from a listing for avialable ole servers on their system.
// The ole control will then be loaded with a blank ole object of that type.
If ole_1.insertobject( ) = 0 Then
	//reset the controls.
	sle_title.text = ""
	sle_title.displayonly = false
	mle_desc.text = ""
	mle_desc.displayonly = false
	ls_typename = ole_1.classlongname
	st_type.text = ls_typename
	this.title = "OLE Example"
	ib_notsaved = true
End If
end on

on ue_pastespecial;int li_rc, li_rc2

//dont allow the user to lose object unless changes were 
//saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then Return
End If

//paste special allows the user to determine if when the object is pasted in the ole
//control whether it will be embeded or linked.
li_rc = ole_1.pastespecial() 
If li_rc <> 0 Then Messagebox("Paste Special","The contents was not copied to the OLE control")

sle_title.text = ""
sle_title.displayonly = false

mle_desc.text = ""
mle_desc.displayonly = false

st_type.text = ole_1.classlongname
this.title = "OLE Example"
ib_notsaved = true
end on

on ue_pastelink;int li_rc, li_rc2

//dont allow the user to lose object unless changes were 
//saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then Return
End If

//copy the contents to the ole control.. The server application must be running

li_rc = ole_1.pastelink() 
If li_rc <> 0 Then Messagebox("Paste Link","The contents was not linked to the OLE control")
sle_title.text = ""
sle_title.displayonly = false

mle_desc.text = ""
mle_desc.displayonly = false

st_type.text = ole_1.classlongname 
this.title = "OLE Example"
ib_notsaved = true
end on

on ue_paste;int li_rc, li_rc2

//dont allow the user to lose object unless changes were 
//saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then Return
End If

//copies the data in the clipboard to the ole control
li_rc = ole_1.paste( ) 
If li_rc <> 0 Then Messagebox("Paste","The contents was not copied to the OLE control")
sle_title.text = ""
sle_title.displayonly = false

mle_desc.text = ""
mle_desc.displayonly = false

st_type.text = ole_1.classlongname
this.title = "OLE Example"
ib_notsaved = true
end on

on ue_savetodb;//call window function save
wf_save ( )

end on

on ue_copy;int li_rc
//copy contents of the ole control to the clipboard
li_rc = ole_1.copy( )
If li_rc <> 0 Then Messagebox("Copy Error", "Error "+ String(li_rc) + " occured during copy to clipboard")
end on

public function integer wf_save ();int li_rc
blob lb_object

//check if a title was supplied
if sle_title.text = "" Then
	Messagebox("OLE SAVE","You must supply a title")
	return -1
end if

//get the data from the ole control
lb_object = ole_1.objectdata
//check if title already exists
  SELECT count(*)  
    INTO :li_rc
    FROM ole  
   WHERE ole.id = :sle_title.text   ;

//insert a new row if this is a new title
If li_rc = 0 Then
	//add the title, desc to the database
	  INSERT INTO ole  
      	   ( id,   
			object,
	           description )  
	  VALUES ( :sle_title.text,   
			' ',
      	     :mle_desc.text )  ;


	if SQLCA.SQLCode = -1 then
		MessageBox("SQL error",SQLCA.SQLErrText,Information!)
		return -1
	end if
End If

sqlca.autocommit = TRUE
//update the row just inserted adding the blob ole control now
 updateblob ole set object = :lb_object
 	where id = :sle_title.text;

if SQLCA.SQLCode = -1 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
	return -1
end if

commit;

//reset control features
sle_title.displayonly = True
mle_desc.displayonly = True
this.title = sle_title.text
ib_notsaved = false

sqlca.autocommit = FALSE
//have menu selection reflect changes
dw_ole.reset()
dw_ole.retrieve()

return 0
end function

public function integer wf_activate (omactivatetype aat_type);//Activate the control
If ole_1.activate(aat_Type) <> 0 Then
	Messagebox("OLE Activate","Unable to Activate")
	Return -1
End If

Return 1

end function

on w_ole_example.create
int iCurrent
call super::create
if this.MenuName = "m_ole_example" then this.MenuID = create m_ole_example
this.ole_1=create ole_1
this.lb_file=create lb_file
this.st_1=create st_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_type=create st_type
this.dw_ole=create dw_ole
this.mle_desc=create mle_desc
this.sle_title=create sle_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.lb_file
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_type
this.Control[iCurrent+9]=this.dw_ole
this.Control[iCurrent+10]=this.mle_desc
this.Control[iCurrent+11]=this.sle_title
end on

on w_ole_example.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ole_1)
destroy(this.lb_file)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_type)
destroy(this.dw_ole)
destroy(this.mle_desc)
destroy(this.sle_title)
end on

event open;call super::open;SetPointer(HourGlass!)

//set up transaction control for the datawindow listing the control objects
dw_ole.settransobject(sqlca)
dw_ole.retrieve()

end event

on closequery;int li_rc, li_rc2


//dont allow the user to quit unless changes were saved or abandon the control changes
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCancel!)
	If li_rc = 1 Then li_rc2 = wf_save()
	If li_rc2 = -1 or li_rc = 3 Then message.returnvalue = 1
End If


end on

event close;//reset the current working directory
lb_file.DirList(gs_ExampleDir,0)

end event

type ole_1 from olecontrol within w_ole_example
integer x = 78
integer y = 128
integer width = 1655
integer height = 1112
integer taborder = 20
borderstyle borderstyle = stylelowered!
long backcolor = 74481808
boolean focusrectangle = false
string binarykey = "w_ole_example.win"
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

event doubleclicked;// Activate the object
// If using 32-bit Windows, inplace activation is possible
If ge_Environment.Win16 Then
	wf_activate(offsite!)
Else
	wf_activate(inplace!)
End If

end event

type lb_file from listbox within w_ole_example
boolean visible = false
integer x = 1952
integer y = 396
integer width = 489
integer height = 356
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_ole_example
integer x = 82
integer y = 68
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "OLE Control:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_ole_example
integer x = 82
integer y = 1284
integer width = 120
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Type:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ole_example
integer x = 1856
integer y = 916
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Description:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ole_example
integer x = 1856
integer y = 708
integer width = 704
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Title:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ole_example
integer x = 1856
integer y = 52
integer width = 745
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Select OLE Objects in Database:"
boolean focusrectangle = false
end type

type st_type from statictext within w_ole_example
integer x = 210
integer y = 1284
integer width = 1193
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_ole from datawindow within w_ole_example
integer x = 1856
integer y = 128
integer width = 965
integer height = 540
integer taborder = 10
string dataobject = "d_ole_example_pick_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for dw_ole
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_title
blob ole_blob
int li_rc


//test if changes were made to the control that have not yet been saved
If ib_notsaved Then 
	li_rc = Messagebox("The current OLE Object has changed","Do you want to save?",Question!,YESNOCANCEL!)
	If li_rc = 1 Then li_rc = wf_save()
	If li_rc = -1 or li_rc = 3 Then Return
End If

If row <=0 Then return

//change selected row
this.selectrow(0, false)
this.selectrow(row, true)

ls_title = this.object.id[row]

//this will load the text and description into the sle and mle on screen
  SELECT ole.id,   
         ole.description  
    INTO :sle_title.text,   
         :mle_desc.text  
   FROM ole  
   WHERE ole.id = :ls_title   ;


if SQLCA.SQLCode = -1 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
end if

//this actually loads the ole control from the database into a blob variable
 selectblob object  into :ole_blob from ole
 	where id = :ls_title;

if SQLCA.SQLCode <> 0 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
end if

//assigning the blob data to the actual data control
ole_1.objectdata = ole_blob

//change the name to reflect the new ole object
parent.title = sle_title.text

//show the type of ole control at the bottom
st_type.text = ole_1.classlongname

//don't allow changes to be made
sle_title.displayonly = True
mle_desc.displayonly = True
ib_notsaved = False

end event

type mle_desc from multilineedit within w_ole_example
integer x = 1856
integer y = 980
integer width = 965
integer height = 260
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_title from singlelineedit within w_ole_example
integer x = 1856
integer y = 780
integer width = 965
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 41943040
boolean autohscroll = false
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

