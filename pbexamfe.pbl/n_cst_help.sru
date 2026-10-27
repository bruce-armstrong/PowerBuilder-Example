//objectcomments Shows the help: exampl.pdf at the topic of a window, or exampl.chm
forward
global type n_cst_help from nonvisualobject
end type
end forward

global type n_cst_help from nonvisualobject autoinstantiate
end type

type prototypes
Function longptr FindExecutableW(string lpFile, string lpDirectory, ref string lpResult) Library "shell32.dll"
Function longptr ShellExecuteW(longptr hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) Library "shell32.dll"
end prototypes

type variables
// The help files, in the examples folder.  HTML Help (exampl.chm) is deprecated: the PDF edition
// is shown when it is there.
Constant String PDFHELPFILE = "exampl.pdf"
Constant String CHMHELPFILE = "exampl.chm"
// Where the PDF is shown: the HelpViewer setting in exampleapp.ini ([Application]), set in the
// Settings window
Constant String INAPP = "App"
Constant String PDFVIEWER = "PDFViewer"
end variables

forward prototypes
public function integer of_showhelp (string as_key)
public function string of_getviewer ()
public function string of_geturl (string as_path, string as_destination)
public function string of_getviewercommand (string as_viewer, string as_path, string as_destination)
protected function string of_cleandestination (string as_destination)
protected function integer of_showinapp (string as_url)
protected function integer of_showinviewer (string as_path, string as_destination)
end prototypes

public function integer of_showhelp (string as_key);//////////////////////////////////////////////////////////////////////
//
// Function: of_ShowHelp
//
// Purpose: shows the help topic of a window
//
//	Arguments: as_key		the window name; "" for the start of the help
//
//	Returns:  1		success
//				-1		the help couldn't be shown
//
//	The PDF help has a named destination for the topic of each window (its name in lower
//	case, from the keyword index of the HTML Help), so exampl.pdf#nameddest=w_dwtostr opens
//	it at that topic.  Without the PDF, the HTML Help is shown with ShowHelp.
//
//////////////////////////////////////////////////////////////////////
String	ls_folder, ls_path, ls_dest

If IsNull(as_key) Then as_key = ""
ls_folder = gs_ExampleDir
If Len(ls_folder) > 0 And Right(ls_folder, 1) <> "\" Then ls_folder += "\"

ls_path = ls_folder + PDFHELPFILE
If Len(ls_folder) = 0 Or Not FileExists(ls_path) Then
	// No PDF: the HTML Help, as before
	ls_path = ls_folder + CHMHELPFILE
	If Len(ls_folder) = 0 Or Not FileExists(ls_path) Then ls_path = CHMHELPFILE
	If as_key = "" Then Return ShowHelp(ls_path, Index!)
	Return ShowHelp(ls_path, KeyWord!, as_key)
End If

ls_dest = of_CleanDestination(Lower(as_key))
If of_GetViewer() = PDFVIEWER Then Return of_ShowInViewer(ls_path, ls_dest)
If of_ShowInApp(of_GetURL(ls_path, ls_dest)) = 1 Then Return 1
// The browser control couldn't show it (no WebView2 runtime): the PDF viewer
Return of_ShowInViewer(ls_path, ls_dest)
end function

public function string of_getviewer ();// Where the PDF help is shown: INAPP (the default) or PDFVIEWER
If ProfileString(gs_CurrentDirectory + "\exampleapp.ini", "Application", "HelpViewer", INAPP) = PDFVIEWER Then Return PDFVIEWER
Return INAPP
end function

public function string of_geturl (string as_path, string as_destination);// The file: URL of a file, with #nameddest=<destination> when a destination is given
String	ls_url, ls_char, ls_dest
Long		ll_pos

If IsNull(as_path) Or IsNull(as_destination) Then Return ""

// The characters that have a meaning in a URL are escaped
For ll_pos = 1 To Len(as_path)
	ls_char = Mid(as_path, ll_pos, 1)
	Choose Case ls_char
		Case "\"
			ls_url += "/"
		Case "%"
			ls_url += "%25"
		Case " "
			ls_url += "%20"
		Case "#"
			ls_url += "%23"
		Case "?"
			ls_url += "%3F"
		Case Else
			ls_url += ls_char
	End Choose
Next

// A UNC path (\\server\share) becomes file://server/share
If Left(ls_url, 2) = "//" Then
	ls_url = "file:" + ls_url
Else
	ls_url = "file:///" + ls_url
End If

ls_dest = of_CleanDestination(as_destination)
If ls_dest <> "" Then ls_url += "#nameddest=" + ls_dest
Return ls_url
end function

public function string of_getviewercommand (string as_viewer, string as_path, string as_destination);// The command line that opens a PDF file at a destination in the program that opens PDF files
// (as_viewer, its full path), or "" for a program whose way of doing that isn't known here
String	ls_program, ls_dest

If IsNull(as_viewer) Or IsNull(as_path) Or IsNull(as_destination) Then Return ""
ls_dest = of_CleanDestination(as_destination)
ls_program = Lower(Mid(as_viewer, LastPos(as_viewer, "\") + 1))

Choose Case ls_program
	Case "msedge.exe", "chrome.exe", "firefox.exe", "brave.exe"
		// A browser takes the file's URL, with the destination
		Return '"' + as_viewer + '" "' + of_GetURL(as_path, ls_dest) + '"'
	Case "acrobat.exe", "acrord32.exe"
		If ls_dest = "" Then Return '"' + as_viewer + '" "' + as_path + '"'
		Return '"' + as_viewer + '" /A "nameddest=' + ls_dest + '" "' + as_path + '"'
	Case "sumatrapdf.exe"
		If ls_dest = "" Then Return '"' + as_viewer + '" "' + as_path + '"'
		Return '"' + as_viewer + '" -named-dest ' + ls_dest + ' "' + as_path + '"'
End Choose
Return ""
end function

protected function string of_cleandestination (string as_destination);// The letters, digits, and "_", "-" and "." of a destination: it goes into a URL and a command line
Constant String ALLOWED = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-."
String	ls_dest, ls_char
Long		ll_pos

If IsNull(as_destination) Then Return ""
For ll_pos = 1 To Len(as_destination)
	ls_char = Mid(as_destination, ll_pos, 1)
	If Pos(ALLOWED, ls_char) > 0 Then ls_dest += ls_char
Next
Return ls_dest
end function

protected function integer of_showinapp (string as_url);// Shows the PDF in the help window (w_help_viewer), which is opened if it isn't open
If as_url = "" Then Return -1

If Not IsValid(w_help_viewer) Then
	If Open(w_help_viewer) <> 1 Then Return -1
Else
	If w_help_viewer.WindowState = Minimized! Then w_help_viewer.WindowState = Normal!
	w_help_viewer.BringToTop = True
End If
Return w_help_viewer.of_Show(as_url)
end function

protected function integer of_showinviewer (string as_path, string as_destination);// Opens the PDF in the program that opens PDF files on this computer, at the destination when
// of_GetViewerCommand knows how that program does it, and otherwise at its start
String	ls_viewer, ls_command, ls_null
Longptr	llp_rc

SetNull(ls_null)
ls_viewer = Space(260)
llp_rc = FindExecutableW(as_path, ls_null, ls_viewer)
If llp_rc > 32 Then
	ls_command = of_GetViewerCommand(Trim(ls_viewer), as_path, as_destination)
	If ls_command <> "" Then
		If Run(ls_command) = 1 Then Return 1
	End If
End If

llp_rc = ShellExecuteW(0, "open", as_path, ls_null, ls_null, 1)
If llp_rc > 32 Then Return 1
Return -1
end function

on n_cst_help.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_help.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
