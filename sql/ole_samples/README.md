# OLE example sample objects: database update needed

> **For Appeon:** the SQL Anywhere demo database that ships with the Code Examples still needs these records updated. They have been updated in the SQL Server EASDEMO database used for this fork's testing.

The OLE 2.0 Control example (`w_ole_example`) shows OLE objects stored in the demo database's `ole` table. Two of those objects date from the 1990s, a Powersoft logo and a letter dated 1994. This folder has their replacements:

| File | Record in the `ole` table | Description | OLE type |
|---|---|---|---|
| `appeon_logo.bmp` | `Appeon Logo` (new; replaces `Powersoft Logo`, which is deleted) | Appeon logo in BMP format | Paintbrush Picture |
| `letter.docx` | `Letter Word Format` (object replaced) | Letter composed in Word | Microsoft Word Document |

The example also hides the `PB Logo AVI file` record, because it needs the Video Clip OLE server of old Windows versions, which no longer exists. That record can stay in the database or be deleted.

## Updating a database

The `object` column holds each object the way PowerBuilder stores an OLE control's `ObjectData`, not the file itself. That means the files can't be loaded with SQL; they have to go through PowerBuilder. The OLE example can do it:

1. Connect the Code Examples to the database, open **OLE 2.0 Control**, choose **File > Open File...** and pick `appeon_logo.bmp`.
2. Type the title `Appeon Logo` and the description `Appeon logo in BMP format`, then choose **File > Save to Database**.
3. Do the same with `letter.docx`, titled `Letter Word Format`. Saving an existing title replaces its object, but not its description.
4. Finish with SQL:

```sql
DELETE FROM ole WHERE id = 'Powersoft Logo';
UPDATE ole SET description = 'Letter composed in Word' WHERE id = 'Letter Word Format';
COMMIT;
```

To check the result, open **OLE 2.0 Control** and pick each record in the list.
