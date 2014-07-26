Dataset organisation
====================

Log of how the datasets were acquired and cleaned.  The crawlers for the
acquisition of files were very different for both datasets.

Victoria & Alber Museum - VAM
-----------------------------

VAM exposes a JSON API to retrieve metadata and image locations, the metadata
is organised as a small JSON structure for each museum item.

`vam-get-all.py` used to get metadata about all items in the category
painintins.  Yielding 2000 results.

Using `jgrep` the results were filtered into 878 items with an availlable
image.

Downloaded the images using `vam-img-get.py` and filtered the images by hand
removing 10 images that were not of painintgs.  Giving a final result of 868
images of paintings with metadata.

Visual Arts Data Service (Nice Paintings) - VADS NIRP
-----------------------------------------------------

Searched the alphabetical index of artists using `all-artists.py`, giving us
3222 artists.

Each artist was checked for works and artists without works (23 such artists
were present) were filtered out.  This was achieved with `curl` and `grep`.

The artist index on NIRP contains duplicate entries for the same artist and
names that are categories of artists (e.g. "French painters").  This result in
individual painitngs being listed several times, we deal with it later.

`by-artist.py` was used to retrieve detailed pages about all paintings of all
artists.  The duplicates were removed by simple `sort | uniq`.  Yielding 9181
unique paintings.

Finally `get-painting.py` crawls the detail page, retrieves the image for the
painting and converts the HTML representation of the metadata into a JSON
representation.

In a JSON representation the painings that do not have an image available were
filtered out using `jgrep`.

Further cleansing
-----------------

Semi automatic check for duplicated by checking if no two images have the same
sha1sum checksum.

