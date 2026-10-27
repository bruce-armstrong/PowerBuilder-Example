//objectcomments Shows the PDF help (exampl.pdf) in a browser control
forward
global type w_help_viewer from window
end type
type wb_help from webbrowser within w_help_viewer
end type
end forward

global type w_help_viewer from window
integer width = 3200
integer height = 2640
boolean titlebar = true
string title = "PowerBuilder Code Examples Help"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "pbex.ico"
boolean center = true
wb_help wb_help
end type
global w_help_viewer w_help_viewer

type variables
// The page shown
String	is_url
end variables

forward prototypes
public function integer of_show (string as_url)
end prototypes

public function integer of_show (string as_url);// Shows a help file: the URL of exampl.pdf, with #nameddest=<window> for the topic of a window
// (n_cst_help.of_GetURL).  The browser control (Microsoft Edge WebView2) opens the PDF at the
// destination.
If IsNull(as_url) Or as_url = "" Then Return -1
is_url = as_url
If wb_help.Navigate(is_url) <> 1 Then Return -1
Return 1
end function

on w_help_viewer.create
this.wb_help=create wb_help
this.Control[]={this.wb_help}
end on

on w_help_viewer.destroy
destroy(this.wb_help)
end on

event resize;wb_help.Move(0, 0)
wb_help.Resize(newwidth, newheight)
end event

type wb_help from webbrowser within w_help_viewer
integer width = 3163
integer height = 2540
end type
