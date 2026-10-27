# Code Examples help sources

The sources for the Code Examples help, which is built in two formats:

- `..\exampl.pdf` is the help that the application opens, because HTML Help is deprecated. It has the topics in contents order, a linked contents page, PDF bookmarks, and named destinations: each topic's `topic-<page>` and the window names of its index keywords, in lower case. The Help menu and F1 open it at `exampl.pdf#nameddest=<window>` (`f_open_help` and `n_cst_help`), in the application's help window (a WebBrowser control) or, with *Show the help in my PDF viewer* in Settings, in the user's PDF viewer.
- `..\exampl.chm` is the HTML Help file, from the same sources. The application falls back to it when `exampl.pdf` is missing.

## Files

| Path | What it is |
|---|---|
| `doc\html\*.html` | One topic per page |
| `doc\image\*.png` | Images used by the topics |
| `styles\examples.css` | Topic stylesheet (`default.css` is kept for reference) |
| `exampl.hhp` | HTML Help project: options, window and the list of files to compile |
| `exampl.hhc` | Contents: topic titles and order, also used for the PDF |
| `exampl.hhk` | Index: keywords, including each example's window name for F1 |
| `build_help.ps1` | Builds both files into the repository root |
| `build_pdf.js` | Joins the topics into one HTML book, prints it to PDF with Microsoft Edge, and adds the named destinations with `pdfnames.js` |
| `pdfnames.js` | Gives a PDF a `/Names /Dests` name tree (the form Edge's and WebView2's PDF viewer read) from its `/Dests` dictionary, plus aliases |

## Building

```powershell
.\build_help.ps1            # both
.\build_help.ps1 -NoPdf     # CHM only
.\build_help.ps1 -NoChm     # PDF only
```

You need:

- HTML Help Workshop (`hhc.exe`) for the CHM.
- Node.js and Microsoft Edge for the PDF.

## Adding or changing a topic

1. Add or edit the page in `doc\html`.
2. For a new page, list it under `[FILES]` in `exampl.hhp`, add it to `exampl.hhc` (contents) and add its keywords to `exampl.hhk`. To make F1 open it, include the example's window name as a keyword: it becomes the topic's named destination in the PDF.
3. Run `build_help.ps1` and commit `exampl.chm` and `exampl.pdf` together with the sources.
