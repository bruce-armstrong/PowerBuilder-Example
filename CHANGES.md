# Changes from the Appeon repository

This fork ([bruce-armstrong/PowerBuilder-Example](https://github.com/bruce-armstrong/PowerBuilder-Example)) branched from [Appeon/PowerBuilder-Example](https://github.com/Appeon/PowerBuilder-Example) at commit `fc373e3`, "Update to PowerBuilder 2022 R3 GA(3289)" (January 2024). This file lists everything changed since then.

Update this file with every change that is committed to the fork. Add each change to the topic sections and to the commit log at the end. A commit cannot contain its own hash, so a new log row says "(pending)" until the next commit fills it in.

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

## User interface

- **Ribbon:**
  - The menu can be shown as a ribbon (RibbonView). `w_main` lays out the panels, tabbed bar and MDI client below the ribbon so they aren't hidden.
  - Settings has a new option, "Display the menu as a ribbon bar". It applies immediately and is saved as `RibbonBar` in `exampleapp.ini`.
  - The Run and Settings menus have sub-items, so they show ribbon buttons.
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
  - Row pointers (`indicatr.bmp`, `indicat2.bmp`) in Conditional Bitmaps, Nested Reports, Row Focus Indicators and the customer picker are now Fluent arrows. The directory tree's connector bitmaps are SVGs (`images\tree_*.svg`), and its tab pages and the About box use SVGs instead of built-in pictures and `exampl.bmp`.
  - The examples that point at the current row with PowerBuilder's built-in Hand! (Item Status, Add and Update Sales Order, Menu Functions, Undelete Row) use a Fluent arrow instead. It is a hidden picture control, `p_rowfocus`, in their ancestor `w_center`. Row Focus Indicators still offers Hand!, since it demonstrates the built-in choices.
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
- **Dark theme colours:**
  - With a theme, PowerBuilder themes a DataWindow's static system colours. A colour returned by an expression is used as is, so a system colour there resolves to its light-mode value, while the text is themed light.
  - Colour expressions now return colours that read in both themes: transparent (the themed background shows through), a tint drawn with background transparency, or mid-tone text colours.
  - Enhanced Crosstab's detail band and a decorative row rectangle in DataWindow Expressions painted light colours that the theme doesn't change; both are now transparent.
  - The examples affected are CurrentRow() (blue tint on the current row), Contact Maintenance, Sales Order items and Dates in DataWindows (grey tint on read-only rows), Mode & Median (mid-green bar on alternate rows, the others transparent), Item Status, Computed attributes and Attribute Expressions.
- **Graphs:**
  - Every graph uses Segoe UI instead of the bitmap font MS Sans Serif, has a white background, and uses a flat type instead of a 3D one.
  - Graphs using Shared DataWindows shows its three graphs without the classic caption bars; the captions are the graph titles.
- **RTE DataWindow Mail Merge:** the letterhead has Appeon's logo and mailing address (Appeon Inc., 425 1st Street, Unit 1507, San Francisco, CA 94105) instead of Powersoft's.

## Database: SQL Server support

The examples were written for the SQL Anywhere demo database. They now also work against an EASDEMO database on SQL Server; see "Using SQL Server instead of SQL Anywhere" in the README.

- **Table and column lists:** for SQL Server interfaces, the list functions query `INFORMATION_SCHEMA`.
- **SQL syntax:**
  - `w_mode_median` uses `DATEFROMPARTS`.
  - `w_select_from_list` joins strings with `+`.
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
- The following are marked deprecated in the example list, the source, the help and the README:
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
| 2026-10-25 | (pending) | Redraw product pictures and toolbar icons, fix DataWindow colours in the dark theme, flatten the graphs, and rebrand the mail-merge letter |
