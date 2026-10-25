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
  - `pbex.ico`, `tutorial.ico`, `emp.ico`, `row.ico` and `rows.ico` are now multi-image icons with images from 16 to 256 px.
  - Fixed the search tree's picture list, which was one icon off from "DataWindows - Updating" onwards.
- Files the examples no longer use were moved to `_archive\`. The PowerClient and PowerServer project file lists were updated to match.
- **Example list:**
  - The WebBrowser and RibbonBar examples are listed once, under Modern PowerBuilder.
  - Removed dated "PB7"/"PB8" title prefixes and old PowerBuilder and Windows version references.
  - The WebBrowser control is described as WebView2 instead of Chromium.
- **Resize Example:** the panels show departments, employees and products instead of empty white DataWindows.
- **Resizing Controls on a Window:** the picture is now an SVG beach and the graph is a flat pie.

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
| 2026-10-25 | (pending) | Add CHANGES.md describing all changes since the fork |
