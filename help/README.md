# Code Examples help sources

The sources for the Code Examples help, which is built in two formats:

- `..\exampl.chm` is the HTML Help file. The Help menu and F1 open it, and F1 finds a topic by the example's window name through the index.
- `..\exampl.pdf` is a PDF edition, because HTML Help is deprecated. It has the same topics in contents order, a linked contents page and PDF bookmarks.

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
| `build_pdf.js` | Joins the topics into one HTML book and prints it to PDF with Microsoft Edge |

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
2. For a new page, list it under `[FILES]` in `exampl.hhp`, add it to `exampl.hhc` (contents) and add its keywords to `exampl.hhk`. To make F1 open it, include the example's window name as a keyword.
3. Run `build_help.ps1` and commit `exampl.chm` and `exampl.pdf` together with the sources.
