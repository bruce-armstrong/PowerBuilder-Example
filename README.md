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
	WebBrowser (Chromium) control with JavaScript <-> PowerScript calls (w_webbrowser) - needs the Microsoft Edge WebView2 runtime
	RibbonBar control built from PowerScript and JSON (w_ribbonbar)
	Placeholders & OpenURL (w_modern_inputs)
•	PDF & Email
	PDF Builder and native DataWindow PDF export (w_pdf_builder)
	Sending Email with SMTPClient (w_smtp_client) - point it at any SMTP server, or a local test server such as smtp4dev or Papercut
