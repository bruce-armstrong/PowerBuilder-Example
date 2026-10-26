Confirming or adjusting the default PowerClient and PowerServer project settings:

The demo application contains default PowerClient and PowerServer projects. Please double check the project settings against your environment, to make sure the projects can work correctly.
With both the PowerClient and PowerServer projects: 

•	Setting up the local web server. The demo project is deployed to local web server by default. If you go with the local server, make sure:
	(1)	IIS is running on the current machine:
	(2)	The “local” web server profile is configured in the Web Server Profile configuration, and Cloud App Launcher is uploaded to the local server. 

With the PowerServer projects: 
•	License settings in the Web APIs tab
	Please import a valid license into the project settings using Auto Import (importing the current PowerBuilder CloudPro or trial license), or Import from File (file from the License Management page on https://account.appeon.com). 

•	Solution location in the Web APIs tab
	The default location is set to [current user]\source\repos. If it does not exist on the current machine, please select a valid one.

•	Web API URL in the Web APIs tab
	Make sure the port setting in the Web API URL is not occupied by another program. Also, if you plan to apply a web debugging proxy tool to debug the deployed application, avoid using “localhost” in the URL. Instead, change to the actual IP address. 

•	Database Configuration in the Web APIs tab
	If you use SQL Anywhere as the demo database, no change is needed to the database configuration. 
	If you use PostgreSQL as the demo database, the default login account is postgres (user)/postgres (password). Please double check the connection. 

Help:

The examples' help is in exampl.chm (opened by the Help menu and F1) and, because HTML Help is deprecated, also in exampl.pdf, generated from the same topics with a linked contents page and bookmarks. The sources and the build script (helpuild_help.ps1) are in the help folder; see helpREADME.md.

Changes in this fork:

CHANGES.md lists everything changed since this repository was forked from Appeon/PowerBuilder-Example.

Modern PowerBuilder examples (pbexamnf.pbl):

The pbexamnf.pbl library adds examples of native PowerBuilder features from PowerBuilder 2017 through 2025 (no PFC). They appear in the example tree under "Modern PowerBuilder", and the "Modern (2017+)" entry in the filter list shows only these examples. None of them need the demo database.

•	JSON & REST
	JSONParser & JSONGenerator (w_json_parser_generator)
	DataWindow ExportJson & ImportJson (w_dw_json)
	RESTClient & HTTPClient (w_rest_client) - calls jsonplaceholder.typicode.com, so it needs internet access
•	Security & Files
	Encoding, Hashing & AES Encryption - CoderObject / CrypterObject (w_crypter_coder)
	Zip & Unzip Files - CompressorObject / ExtractorObject (w_compressor)
•	User Interface
	WebBrowser (WebView2) control with JavaScript <-> PowerScript calls (w_webbrowser) - needs the Microsoft Edge WebView2 runtime
	RibbonBar control built from PowerScript and JSON (w_ribbonbar)
	Placeholders & OpenURL (w_modern_inputs)
•	PDF & Email
	PDF Builder and native DataWindow PDF export (w_pdf_builder)
	Sending Email with SMTPClient (w_smtp_client) - point it at any SMTP server, or a local test server such as smtp4dev or Papercut

MAPI mail is deprecated:

The "MAPI Mail - Send Mail" (w_mail_send) and "MAPI Mail - Receive Mail" (w_mail_receive) examples, and the Send command in RichPad (w_rte), use PowerBuilder's MAPI functions (mailSession). MAPI needs a MAPI mail client such as classic Outlook for Windows, which Microsoft supports until at least 2029 (https://techcommunity.microsoft.com/blog/outlook/new-outlook-for-windows-a-guide-to-product-availability/4078895). The new Outlook for Windows does not provide MAPI, so these examples fail to log on without classic Outlook. The MAPI examples are planned for removal; to send mail, use SMTPClient instead (w_smtp_client). PowerBuilder has no built-in replacement for reading a mailbox.

Icons and display settings:

•	The menu, ribbon and example tree use SVG icons from Microsoft Fluent UI System Icons (MIT licence), stored in the images folder together with their licence (images\LICENSE-fluentui-system-icons.txt). They are recoloured to #2B88D8 so they read well on both light and dark themes. SVG images require PowerBuilder 2025 R2 or later.
•	Settings has a "Display the menu as a ribbon bar" option. It is saved as RibbonBar=1/0 in the [Application] section of exampleapp.ini and takes effect immediately (open examples are closed first).
•	The theme list includes the HighDPI themes, which use SVG graphics so they stay sharp at high display scaling.

Using SQL Server instead of SQL Anywhere:

•	The examples run against a SQL Server copy of the EASDEMO database (for example, in a Docker container) using the MSOLEDBSQL interface: DBMS "MSOLEDBSQL SQL Server", DBParm "Database='EASDEMO',Provider='MSOLEDBSQL19'". Enter these in File > Change Database Connection.
•	A SQL Server copy of EASDEMO may not include the stored procedures some examples use. Run sql\sqlserver\easdemo_example_procedures.sql against EASDEMO once to add any that are missing; it never changes existing procedures.
