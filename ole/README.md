# OLE example sample objects

The OLE 2.0 Control example (`w_ole_example`) shows OLE objects stored in the demo database's `ole` table. Two of the objects there came from the 1990s: a Powersoft logo and a 1994 letter. This folder has their replacements:

| File | Row in the `ole` table | OLE type |
|---|---|---|
| `appeon_logo.bmp` | Appeon Logo (replaces Powersoft Logo) | Paintbrush Picture |
| `letter.docx` | Letter Word Format | Microsoft Word Document |

The table holds each object the way PowerBuilder stores an OLE control's `ObjectData`, not the file itself, so the files have to go through PowerBuilder. To load them into your database, use the example:

1. Open **OLE 2.0 Control** and choose **File > Open File...**, then pick the file.
2. Type the title and description, and choose **File > Save to Database**.
3. To remove the old Powersoft Logo row, delete it from the `ole` table: `DELETE FROM ole WHERE id = 'Powersoft Logo'`.

The example hides the PB Logo AVI file row: it needs the Video Clip OLE server of old Windows versions, which no longer exists.
