# Changes from the Appeon repository

This fork ([bruce-armstrong/PowerBuilder-Example](https://github.com/bruce-armstrong/PowerBuilder-Example)) branched from [Appeon/PowerBuilder-Example](https://github.com/Appeon/PowerBuilder-Example) at commit `fc373e3`, "Update to PowerBuilder 2022 R3 GA(3289)" (January 2024). This file lists everything changed since then.

Update this file with every change that is committed to the fork. Add each change to the topic sections and to the commit log at the end. A commit cannot contain its own hash, so a new log row says "(pending)" until the next commit fills it in.

## Before and after

The Enhanced Pie Graph example (Graphs > Enhanced Pie Graph w/ Explode) after these changes, in PowerBuilder 2025 R2 (25.1) with the Flat Design Dark theme, the SVG icons and Segoe UI:

![Enhanced Pie Graph after the changes](docs/screenshots/enhanced_pie_graph_after.png)

The same example before the changes, in PowerBuilder 2022 R3 (22.2):

![Enhanced Pie Graph before the changes](docs/screenshots/enhanced_pie_graph_before.png)

## PowerBuilder 2025 solution

- The PowerBuilder 2022 workspace and target were migrated to the PowerBuilder 2025 R2 solution format:
  - `pbexamples.pbsln` is the solution and `PB Examples.pbproj` is the project.
  - Each library is now a folder of source files (`*.pbl` with a `.pblmeta`) instead of a binary PBL.
- `.gitignore` ignores the IDE's cache folders, the per-user `.usr.opt` files and the migration log.
- The pipeline objects (`.srp`) no longer start with the `//objectcomments` line and no longer end with the NUL byte the migration left behind.
  - In the solution format, that comment line is compiled into the pipeline syntax. Every pipeline's `Start` then returned -1 ("pipe open failed").

## New examples: Modern PowerBuilder (`pbexamnf.pbl`)

Ten examples of native PowerScript features from PowerBuilder 2017 to 2025, with no PFC:

- In the example tree they are under "Modern PowerBuilder" categories, which have their own icons.
- The "Modern (2017+)" filter shows only these examples.
- They are documented in the README, and each has a help topic.

| Example | Window | Feature |
|---|---|---|
| JSONParser & JSONGenerator | `w_json_parser_generator` | JSONParser, JSONGenerator |
| DataWindow ExportJson & ImportJson | `w_dw_json` | DataWindow JSON |
| RESTClient & HTTPClient | `w_rest_client` | RESTClient, HTTPClient (needs internet access) |
| Encoding, Hashing & AES Encryption | `w_crypter_coder` | CoderObject, CrypterObject |
| Zip & Unzip Files | `w_compressor` | CompressorObject, ExtractorObject |
| WebBrowser (WebView2) | `w_webbrowser` | WebBrowser control, JavaScript ↔ PowerScript |
| RibbonBar | `w_ribbonbar` | RibbonBar control built from PowerScript and JSON |
| Placeholders & OpenURL | `w_modern_inputs` | Placeholder text, OpenURL |
| PDF Builder | `w_pdf_builder` | PDF Builder, native DataWindow PDF export |
| Sending Email with SMTPClient | `w_smtp_client` | SMTPClient |

## Help (`exampl.chm`)

- Added a topic page for each of the ten new examples. The pages are indexed by window name, so F1 (`ShowHelp` with `KeyWord!`) opens the right page. Help is turned on (`exhelp`) for these examples.
- The overview pages now list `PBEXAMNF.PBL` and the "Modern (2017+)" filter.
- The two MAPI mail topics have a "Deprecated" section (see [MAPI mail](#mapi-mail-deprecated)).
- Help now works when the examples are run from the IDE.
  - `f_open_help` builds the full path from `gs_ExampleDir` instead of passing the bare file name.
  - Before, the bare name was looked up in the IDE's directory.
- **Help sources:** the topic pages, images, stylesheet and HTML Help project (`exampl.hhp`, `.hhc`, `.hhk`) are in `help`, with `build_help.ps1` to build `exampl.chm` and `exampl.pdf` (see `help/README.md`).
- **PDF help:** HTML Help is deprecated, so the help is also published as `exampl.pdf`. It is generated from the same topic sources, in the CHM's contents order, with a linked contents page and PDF bookmarks.
- **Help opens the PDF at the topic:** the Help menu and F1 (`f_open_help`) now open `exampl.pdf` instead of the CHM, at the topic of the example: the PDF has a named destination for each window name in the help index (`exampl.pdf#nameddest=w_dwtostr`), added by `help/pdfnames.js` as a `/Names` tree, the form Edge's and WebView2's viewer read. `n_cst_help` shows it in a new help window, `w_help_viewer` (a WebBrowser control), or, with the new *Show the help in my PDF viewer* setting (`HelpViewer` in `exampleapp.ini`), in the user's PDF viewer: Edge, Chrome, Firefox, Brave, Acrobat, Acrobat Reader and SumatraPDF open it at the topic, others at its start. Without `exampl.pdf`, the CHM is shown as before. It works the same way as the PDF help in PFC 2025.
- Topics brought up to date with the examples: PictureListBox Picture Browser (SVG images), PowerPuzzle (new picture), Graphs and Shared DataWindows (flat column graph), ShareData With DataStores (first DataStore shown), Query Mode (Retrieve accepts the current field; removed a garbled duplicate of its example table), DataWindow to Structure Utility (solution libraries) and The Code Example Files (the solution layout and libraries, the build projects, and the Benchmarks application not being included).
- The 16-colour help images were replaced: every topic's Code Examples picture (`exhelp.png`) is the application tile icon, and the new/enhanced/settings markers use the app's Fluent icons. The unused logo of the product's former owner was removed and the stylesheet renamed to `examples.css`.

## User interface

- **Ribbon:**
  - The menu can be shown as a ribbon (RibbonView). `w_main` lays out the panels, tabbed bar and MDI client below the ribbon so they aren't hidden.
  - Settings has a new option, "Display the menu as a ribbon bar". It applies immediately and is saved as `RibbonBar` in `exampleapp.ini`.
  - The Run and Settings menus have sub-items, so they show ribbon buttons.
  - Example Report and Current Example Help follow the selected example. The menus enabled them in their own Clicked event, when they dropped down, which a ribbon never does, so on the ribbon Current Example Help stayed disabled; `w_main.of_refresh_info` now sets both when the selection changes.
  - The examples' help flags (`exhelp` in `d_examples`) match the help index: Printer, System and File System Enhancements, Progress Bar Controls, Track Bar Controls and Hyperlink Controls have topics and now enable Current Example Help; Working with Executables has none.
- **Themes:**
  - Added the PowerBuilder 2025 R2 HighDPI themes in `theme\`.
  - The default theme is Flat Design Dark (`exampleapp.ini`).
- **Icons:**
  - The menu, ribbon, example trees, status filter and the interface bitmaps now use Microsoft Fluent UI System Icons as SVG, in `images\`. These icons are MIT-licensed; the licence is in `images\LICENSE-fluentui-system-icons.txt`.
  - The replaced bitmaps include:
    - toolbar buttons
    - text style buttons (regular icon for off, filled for on)
    - drives and folders
    - calendar arrows
    - DataWindow buttons
    - registry and program icons
    - the bitmap catalogue
  - Eleven tree and list examples used PowerBuilder's built-in pictures; these were replaced with Fluent SVG icons (people, customers, orders, folders, departments, tables and functions).
    - Selected tree items keep their own icon.
  - The ten product pictures (the 64 x 64 bitmaps named in `product.picture_name`, such as `tshirtw.bmp`) were redrawn as SVG in `images\products`, with a 64 px PNG of each.
    - The ListView and TreeView examples (Sales Order ListView, Data Explorer, Data Manager, TreeView / DataWindow Linking) load the SVG through the new `f_product_picture` function.
    - The DataWindows that show the picture (`d_add_sales_order_items`, `d_salesorder_items`, `d_product_info`, `d_mode_median`, `d_products`) hide the bitmap-name column and show the PNG in a `bitmap()` computed field.
    - The database isn't changed; a product without a redrawn picture still shows its bitmap. The PowerClient and PowerServer projects deploy the new images.
  - The example menus' toolbars (DataWindow Buffers, Item Status, Presentation Styles, Nested Reports, Dynamic User Objects, the Dynamic SQL, graph, notepad, OLE and toolbar examples, and others) used PowerBuilder's built-in toolbar pictures. All 171 now use Fluent SVG icons.
  - DataWindow buttons that showed the default action pictures (Contact Maintenance's scroll buttons, Report With DataWindow Buttons) now have Fluent SVGs. The report's button bar no longer paints a silver strip.
  - Row pointers (`indicatr.bmp`, `indicat2.bmp`) in Conditional Bitmaps, Nested Reports, Row Focus Indicators and the customer picker are now Fluent arrows. The directory tree's connector bitmaps are SVGs (`images\tree_*.svg`) and its tab pages use SVGs instead of built-in pictures. Both About boxes show the application icon (`pbex.ico`) instead of `exampl.bmp`.
  - The examples that point at the current row with PowerBuilder's built-in Hand! (Item Status, Add and Update Sales Order, Menu Functions, Undelete Row) use a Fluent arrow instead: a hidden picture control, `p_rowfocus`, in each of those windows. Row Focus Indicators still offers Hand!, since it demonstrates the built-in choices.
    - The picture was first added to their common ancestor `w_center`. That is also the ancestor of the MDI frame examples, and an MDI frame with controls of its own no longer sizes its MDI client, so Data Manager, DataWindow Buffers, Presentation Styles, Nested Reports and Dynamic User Objects showed an empty frame. Fixed by moving the picture into the five windows.
  - `pbex.ico`, `tutorial.ico`, `emp.ico`, `row.ico` and `rows.ico` are now multi-image icons with images from 16 to 256 px.
  - Fixed the search tree's picture list, which was one icon off from "DataWindows - Updating" onwards.
- Files the examples no longer use were moved to `_archive\`. The PowerClient and PowerServer project file lists were updated to match.
- **Example list:**
  - The WebBrowser and RibbonBar examples are listed once, under Modern PowerBuilder.
  - Removed dated "PB7"/"PB8" title prefixes and old PowerBuilder and Windows version references.
  - The WebBrowser control is described as WebView2 instead of Chromium.
- **Resize Example:** the panels show departments, employees and products instead of empty white DataWindows.
- **ShareData With DataStores:** the first DataStore is selected when the example opens, instead of an empty white DataWindow. The DataWindow-to-HTML window (`w_dw_html`, not listed as an example) starts with its tabular DataWindow the same way.
- **Resizing Controls on a Window:** the picture is now an SVG beach and the graph is a flat pie.
- **Fonts:** the windows, user objects and DataWindows used MS Sans Serif, a bitmap font that renders blocky and does not scale on high-DPI screens, plus some Arial, Tahoma and Helv. They now use Segoe UI, at the same point sizes: about 3,200 font settings in 351 objects, the application's default fonts, and the DataWindows that the Query Painter builds at run time. Fonts inside documents (the mail-merge letter), the font list in the text style bar and print fonts are unchanged. Because Segoe UI is wider and taller, the layouts were checked in the dark theme and fixed where text was cut off: two-line DataWindow headings are taller (64 text objects in 22 DataWindows, with their bands); labels that no longer fit are wider (133 DataWindow text objects and about 80 window check boxes, radio buttons and labels, without running into the next control); wrapped labels are taller; the opening paragraph of the newer examples (PDF Builder, Zip, Crypter, JSON, REST, RibbonBar, SMTP, WebBrowser) has room for a third line; the mailing-label DataWindows use a smaller font so three lines fit a label; and a few labels were reworded or widened by hand (Nested Report Reference, Phone Directory, Multiple Table Update, Pipeline, PopulateError, Resizing Controls, the CPU counter); the MAPI inbox and Evaluate headings had stray carriage returns in their line breaks, which pushed the second line out of view.
- **ListView headers in the dark theme:** the ListView column headers (Data Explorer, Data Manager, Registry Functions and the three Runtime Functions examples) stayed white in the dark theme; f_listview_dark_header gives them the dark header style. The Data Explorer and Data Manager columns are also wider.
- **Former company names:** apart from the licence notice of the PFC objects (`pfc_u_st`, `pfc_u_st_splitbar`), which credits the original author, the examples no longer name the product's former owners:
  - The settings are kept under `HKEY_CURRENT_USER\Software\Appeon\PowerBuilder\<version>\Code Examples`, where PFC's examples keep theirs. The first time, the new `f_migrate_settings` copies the settings saved under the old key (the database connection, toolbars and example settings), and leaves the old key as it is.
  - Comments, the hyperlink example's control names (`shl_link_appeon`, `phl_link_appeon`), the stored-procedure update function for SAP ASE (`wf_update_ase`) and the `pbexamsy` library comment (SQL Anywhere) were renamed, and the help's old stylesheet (`default.css`) was deleted.
  - Left as they are: the PSR report files' header (`.psr`), a file-format signature that PowerBuilder writes in every saved report; the old registry key in `f_migrate_settings`'s call, which it copies from; and the `Powersoft Logo` record ID in `sql\ole_samples`, which the database update needs.
- **Pictures missing after Settings or a file dialog:** the examples load their pictures by relative path (`images\...`), so they showed red crosses once the current directory had moved. Opening Settings moved it to the `Theme` folder (its theme list uses `DirList` and never changed back), and file dialogs and several examples move it too. Settings now restores it, and the main window returns to the application's directory before it opens an example.
- **Dark theme colours:**
  - With a theme, PowerBuilder themes a DataWindow's static system colours. A colour returned by an expression is used as is, so a system colour there resolves to its light-mode value, while the text is themed light.
  - Colour expressions now return colours that read in both themes: transparent (the themed background shows through), a tint drawn with background transparency, or mid-tone text colours.
  - Enhanced Crosstab's detail band and a decorative row rectangle in DataWindow Expressions painted light colours that the theme doesn't change; both are now transparent.
  - The examples affected are CurrentRow() (blue tint on the current row), Contact Maintenance, Sales Order items and Dates in DataWindows (grey tint on read-only rows), Mode & Median (mid-green bar on alternate rows, the others transparent), Item Status, Computed attributes and Attribute Expressions.
- **Graphs:**
  - Every graph uses Segoe UI instead of the bitmap font MS Sans Serif, has a white background, and uses a flat type instead of a 3D one.
  - Graphs using Shared DataWindows shows its three graphs without the classic caption bars; the captions are the graph titles.
- **Example fixes:**
  - DataWindow buttons aren't drawn by the theme. The new `f_dw_theme_buttons` gives a DataWindow's buttons a dark face and light text when a dark theme is active; Report With DataWindow Buttons and Contact Maintenance call it. Picture buttons still get a light frame from PowerBuilder.
  - Placeholders & OpenURL and Zip & Unzip: their group boxes came first in `Control[]`, so PowerBuilder painted them over the controls inside and the examples looked empty. The group boxes now come last.
  - Resizing Controls on a Window: dragging the window edge now rescales the controls. The resize code hid the window and forced it back to its original proportions on every resize, which ended the drag, so only maximizing worked. It now scales the controls to the workspace under `SetRedraw`, and the hint says to drag a window edge.
  - Registry Editor: with a dark theme, the value list's column header (a Windows header control the theme does not paint) gets the Windows dark style through `SetWindowTheme(..., "DarkMode_ItemsView")` instead of a white bar, and the second column is titled "Value" instead of a second "Name".
  - Progress Bar Controls: Start steps both bars on a 0.1-second timer (from the minimum again if they are full) and Stop stops it. The old loop made every step before the bars could repaint.
  - Window titles that contained " & " (Placeholders & OpenURL, Mode & Median and eight more) say " and ": the tabbed MDI bar treats "&" as a shortcut marker, so the tabs showed an underlined letter instead.
  - PictureListBox Picture Browser: a new "SVG images (.svg)" picture type, selected by default, lists the app's SVG images from `images\`; Bitmaps and Icons go back to the examples folder.
  - DataWindow Query Painter: the Selected Columns grid shows a blank DataWindow in the themed window colour until columns are chosen, instead of a white square.
  - Row Focus Indicators: the bitmap list is always enabled; picking a bitmap switches to the Picture indicator.
  - Query Mode: Retrieve accepts the criteria still being typed (`AcceptText`) before it retrieves.
  - DataWindow to Structure: Select PBL also accepts a solution library (the `.pblmeta` file in a library folder); the DataWindows are listed from the folder's `.srd` files and read from their source.
  - Report With DataWindow Buttons and Contact Maintenance: the DataWindows' picture buttons were 20 x 20 pixels, too small to tell apart. They are 30 x 28 pixels now, and what was below them moved down.
  - Snake and Sliding Columns: in the dark theme, print preview drew the second and third newspaper columns in the theme's colours (light text in dark boxes) on the white page. The report's objects now have transparent backgrounds and their text colour is an expression (`RGB(0,0,0)`), which the theme leaves alone, so every column is black on white.
  - Draw() Aquarium Fish and Draw() Train: `Draw()` paints each bitmap straight onto the window, and the examples relied on the window's BackColor (navy, and white for the track), which a theme replaces. The fish swam in a growing navy trail and the train drew a white strip. Each window now paints its background (the aquarium, the track) after the window paints (`pbm_paint`).
  - Print Examples: the sample picture was a 1990s grey column bitmap; it is a new SVG, `images\print_sample.svg`.
  - Registry Editor: opens at `HKEY_CURRENT_USER\Software\Appeon` (Software if there is no Appeon key). Before, it looped forever when the key wasn't there.
  - OLE Example: an OLE object whose server isn't installed gave a System Error; it now shows a message. The PB Logo AVI file row, which needs the Video Clip server of old Windows versions, is filtered out of the list.
  - OLE Example sample objects: `sql\ole_samples\appeon_logo.bmp` (an Appeon logo, replacing a 1990s company logo) and `sql\ole_samples\letter.docx` (the payment-reminder letter, dated 2026 instead of 1994). The `ole` table stores PowerBuilder's OLE `ObjectData`, so they are loaded with the example itself; `sql\ole_samples\README.md` has the steps. They are loaded in the SQL Server EASDEMO database used for testing; the SQL Anywhere demo database that Appeon supplies still needs the update.
  - Spellcheck with OLE and Excel: Excel's Spelling dialog didn't appear while Excel was hidden, so the application seemed to hang. Excel is shown during the check (`Visible = True`), and the window lets it bring its dialog to the front (`AllowSetForegroundWindow`).
  - PowerBuilder Aquarium: the example's title had two spaces.
  - DataWindow button icons: PowerBuilder fits a picture button's SVG into the button and draws a white frame around it in every background mode, so the frame stays. The icons of Report With DataWindow Buttons and Contact Maintenance are copies in `imagesdwbutton` with the empty margin trimmed, so the symbol is larger; with a dark theme, `f_dw_theme_buttons` swaps in lighter blue copies from `imagesdwbuttondark`.
  - DataWindow to Structure: picking a solution library's `.pblmeta` file listed no DataWindows, because the extension check compared 9 characters with the 8-character `.pblmeta`. The PBL box now turns a `.pblmeta` path into its folder (typed paths too), says so when a library has no DataWindows, and changes the current directory back after listing the folder.
- **Saved reports (`.psr`):** a PSR file doesn't hold its pictures; it names them, and the PSR Viewer loads them from the examples folder.
  - `bitmap.psr` listed about 80 PowerBuilder 6 toolbar bitmaps, 66 of which no longer exist (most are in `_archive\`), so most rows had no picture. It was rebuilt through PowerBuilder (its layout created as a DataWindow, the rows imported, and saved with `SaveAs(..., PSReport!)`): it now lists the 152 SVG pictures in `images\` and `images\products\`, in Segoe UI, with room for 24-pixel pictures.
  - The product pictures that `comprep.psr` names (`capb.bmp` to `visorw.bmp`) are redrawn from `images\products\` under the same names, and `nestrep.psr`'s row arrow (`indicat2.bmp`) from the new `images\indicator_arrow.svg`. `btnrept.psr`'s Exit and Help buttons named `exit1.bmp` and `help.bmp`, which didn't exist; they are new 16-pixel pictures. `comprep.psr` keeps its product picture column just past the edge of its nested report, so it doesn't show them.
  - The PSR Viewer changes the current directory back after its file dialog, so a report finds its pictures from whichever folder it was opened. The replaced files are in `_archive\` (`bitmap_pb6.psr` and the old bitmaps).
- **Sliding-picture puzzle:** the 25 tiles were slices of a 1990s company logo. The puzzle, its solution thumbnail and the Zip example now use a new landscape picture drawn for it, `images\puzzle\puzzle.png`, cut into `tile11.png` to `tile55.png` at 2x resolution. The old bitmaps are in `_archive\`.
- **RTE DataWindow Mail Merge:** the letterhead has Appeon's logo and mailing address (Appeon Inc., 425 1st Street, Unit 1507, San Francisco, CA 94105) instead of the 1990s company's.

## Database: SQL Server support

The examples were written for the SQL Anywhere demo database. They now also work against an EASDEMO database on SQL Server; see "Using SQL Server instead of SQL Anywhere" in the README.

- **Table and column lists:** for SQL Server interfaces, the list functions query `INFORMATION_SCHEMA`.
- **SQL syntax:**
  - `w_mode_median` uses `DATEFROMPARTS`.
  - `w_select_from_list` joins strings with `+`.
  - `w_orders_graph_list_sheet` (Stats by Cust # - Using Graph Object) names the months with `FORMAT` instead of SQL Anywhere's `dateformat`, which gave a "not a recognized built-in function name" error. On both databases it shows the first year with orders instead of 1995, which the demo data doesn't have.
- **Stored procedures:** run `sql\sqlserver\easdemo_example_procedures.sql` to create the stored procedures the examples use, if the database doesn't have them.
- **Scratch tables:**
  - The new `f_table_not_found` function recognises "table not found" errors from SQL Anywhere, SQL Server, Oracle and PostgreSQL.
  - The three pipeline examples use it, so dropping a scratch table that was never created isn't reported as an error. Before, `w_pipeline_blob` showed an error when dropping `ole_copy` on SQL Server.
- **Pipelines:** `emp_pipe_transaction` is created with `varchar`/`char` columns instead of SQL Anywhere's `long varchar`.
- **Saved settings:**
  - Fixed `f_get_profile`, which read `<regkey>\Code Examples<section>`, without the backslash.
  - Saved settings (database connection, toolbar options, benchmark settings) were never read back, so they always used their defaults.

## MAPI mail (deprecated)

- MAPI needs a MAPI mail client such as classic Outlook for Windows, which Microsoft supports until at least 2029 ([Microsoft's announcement](https://techcommunity.microsoft.com/blog/outlook/new-outlook-for-windows-a-guide-to-product-availability/4078895)). The new Outlook for Windows doesn't provide MAPI.
- The following are marked deprecated in the example list (their titles end in "(deprecated)"), the source, the help and the README:
  - "MAPI Mail - Send Mail" (`w_mail_send`)
  - "MAPI Mail - Receive Mail" (`w_mail_receive`)
  - RichPad's Send command (`w_rte.of_send`)
- The notes say to send mail with SMTPClient (`w_smtp_client`) instead.
- **Planned removal:** remove `w_mail_send` and `w_mail_receive`, their `d_examples` rows and help topics. Switch RichPad's Send to SMTPClient or remove it.

## Commit log

| Date | Commit | Summary |
|---|---|---|
| 2026-10-24 | `88f066b` | Migrate to PowerBuilder 2025 solution and add modern feature examples |
| 2026-10-24 | `1a7b93d` | Add help topics for the Modern PowerBuilder examples |
| 2026-10-24 | `0b803e0` | Fix f_get_profile reading the wrong registry key |
| 2026-10-24 | `1de68bd` | Open the help file by full path so Help works from the IDE |
| 2026-10-25 | `427a3a1` | Modernize images, add ribbon setting, and fix examples on SQL Server |
| 2026-10-25 | `19e1245` | Use the Flat Design Dark theme by default |
| 2026-10-25 | `cfbd017` | Fix the pipeline examples and more examples on SQL Server; replace remaining bitmaps |
| 2026-10-25 | `49bcadc` | Mark the MAPI mail examples as deprecated |
| 2026-10-25 | `041e5a3` | Add CHANGES.md describing all changes since the fork |
| 2026-10-25 | `c32b2d9` | Redraw product pictures and toolbar icons, fix DataWindow colours in the dark theme, flatten the graphs, and rebrand the mail-merge letter |
| 2026-10-25 | `e46d622` | Replace the old logo puzzle with new artwork |
| 2026-10-25 | `11472af` | Fix the blank MDI frames, darker DataWindow buttons, and example fixes |
| 2026-10-25 | `274a976` | Fix Placeholders & OpenURL, Resizing Controls, Progress Bar, Registry Editor header, SVG in the picture browser |
| 2026-10-25 | `2d1ceac` | Update the help, publish it as a PDF too, and add the help sources |
| 2026-10-27 | `cdb5f70` | Switch the fonts to Segoe UI and fix the layouts it affected |
| 2026-10-27 | `f0556d6` | Open the PDF help at the example's topic |
| 2026-10-27 | `5580ba7` | Fix pictures missing after Settings or a file dialog |
| 2026-10-27 | `468798c` | Bigger DataWindow buttons, Draw() backgrounds, and more example fixes |
| 2026-10-27 | `2f22c6f` | New OLE sample objects, hide the AVI sample, show Excel for the spellcheck |
| 2026-10-27 | `1e43ce1` | Move the OLE sample objects to sql\ole_samples with a note for the SQL Anywhere database |
| 2026-10-27 | `310458c` | Remove the former company names (only the help's old stylesheet deletion landed in this commit) |
| 2026-10-27 | `63309f2` | Remove the former company names; keep the settings under Software\Appeon |
| 2026-10-27 | `689c96d` | Bigger, lighter DataWindow button icons; fix DataWindow to Structure for solution libraries |
| 2026-10-27 | `5156e05` | Rebuild bitmap.psr from the current pictures; new pictures for the saved reports |
| 2026-10-27 | `b7d3f60` | Add before and after screenshots to CHANGES.md |
| 2026-10-27 | (pending) | Enable Current Example Help and Example Report for the selected example on the ribbon; fix the help flags |
