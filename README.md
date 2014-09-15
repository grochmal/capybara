Style Based Drawn Artwork Image Classification
==============================================

README for the code and documentation files used in the Style Based Drawn
Artwork Image Classification work.


The Code Snippets and Documentation
-----------------------------------

All code snippets in this bundle are part of the Style Based Drawn Artwork
Image Classification work.  All documentation either in the form of typeset
documents or software manuals are part of the Style Based Drawn Artwork Image
Classification work.  Copying permissions vary between the snippets and
documentation see the appropriate `Copying` sections for details.


Copying Code Snippets
---------------------

Copyright (C) 2014 Michal Grochmal

This file is part of Style Based Drawn Artwork Image Classification.

All code snippets in this repository are free software; you can redistribute
and/or modify all or some of the snippets under the terms of the GNU General
Public License as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

The code snippets in this repository are distributed in the hope that they will
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
License for more details.

The COPYING file in the root directory of the project contains a copy of the
GNU General Public License. If you cannot find this file, see
<http://www.gnu.org/licenses/>.


Copying Documentation
---------------------

Copyright (C) 2014 Michal Grochmal

Documentation in this project are all files under the doc/ directory.

Permission is granted to copy, distribute and/or modify the documents under the
terms of the GNU Free Documentation License, Version 1.3 or any later version
published by the Free Software Foundation.

The COPYING file in the doc/ directory of the project contains a copy of the
GNU Free Documentation License. If you cannot find this file, see
<http://www.gnu.org/licenses/>.

Copying Datasets
----------------

The images in the datasets are Copyrighted by the Victoria and Albert Museum in
London and by the Visual Art Data Service.  The Copyright allows for the use of
these reduced images freely academic purposes.  Also the images can be used for
other purposes if the number of the images uses is less than 2000.

See the [Victoria and Albert Museum website](http://www.vam.ac.uk/) and the
[Visual Art Data Service website}(http://vads.ac.uk/) for more detailed
information.


Requirements to run the code (dependencies)
-------------------------------------------

To run the code several pieces of software are needed, all of them are
available under a Copyleft or an Open Source Licence.

The following software packages are needed to run the experiments:

* [ImageMagick](http://www.imagemagick.org/) 6.5.4-7 or later
* [libsvm](http://csie.ntu.edu.tw/~cjlin/libsvm/index) 3.18 or later
* [python](http://www.python.org/) 2.6.6 or later (but not python 3)
* [perl](http://www.perl.org/) 5.8.8 or later
* [bash](http://www.gnu.org/software/bash/index.html) 4.1.0 or later

Several extra modules for the Python programming language are needed as well,
all of the can be installed from [pypi](http://pypi.python.org/pypi/):

* [numpy](http://www.numpy.org/) 1.8.1 or later
* [scipy](http://www.scipy.org/) 0.14.0
* [matplotlib](http://matplotlib.org/) 0.99.1.1
* [pillow](http://github.com/python-pillow/Pillow) 2.5.1 or later
* [scikit-image](http://scikit-image.org/) 0.10.1
* [ipython](http://ipython.org/) 1.0.0 or later
* [pandas](http://pandas.pydata.org/) 0.14.1

The dataset acquisition phase of the work is not an automated process, yet
several scripts were developed during that phase.  The dependencies of those
scripts are described below, shall one wish to try them:

* [beautifulsoup4](http://www.crummy.com/software/BeautifulSoup/) 4.3.2
  or later
* [pyyaml](http://pyyaml.org/) 3.10 or later
* [git](http://www.git-scm.com/) 1.5.0 or later is needed to clone unixjsons
  from its repository
* [unixjsons](https://github.com/grochmal/unixjsons) 0.7 or later


How to run the code
-------------------

Ensure that you have all dependencies described above installed and clone this
repository into a directory on a file system that has at least 15GB of free
space.  Then go to `src/`

Acquisition and cleansing of the datasets is not covered because that process
is not automated.  To browse the code used to acquire the datasets go to the
directories `dataset-acquisition/vam` and `dataset-acquisition/nirp` for the
VAM and NIRP datasets respectively.

In `src/` run the scripts that normalise, separate and filter the images before
the extraction of features.

    ./step01-normalise.sh      # normalise to ~300 000 pixels
    ./step02-hsl-hsv.sh        # separates the channels
    ./step03-colourfulness.sh  # calculates the colourfulness
    ./step04-sobel.sh          # applies the Sobel filter
    ./step05-canny.sh          # applies the Canny filter
    ./step06-jpeg.sh           # compress the images

Next, run the feature extractors.  These scripts print the calculated features
to the *standard output stream* and log messages to the *standard error
stream*, therefore redirect the standard output to files.

    ./step07-kolmogorov.sh     > fe/kolmogorov.dat
    ./step08-glcm.sh           > fe/glcm.dat
    ./step09-itten12.sh        > fe/itten12.dat
    ./step10-itten-contrast.sh > fe/itten-contrast.dat
    ./step11-rule-of-3.sh      > fe/rule-of-3.dat
    ./step12-img-averages.sh   > fe/img-averages.dat

A last feature script that generates the metadata (artist, school and country)
of the image shall then be run.  This metadata is what we classify against.

    ./step13-metadata.sh > fe/meta.dat

Map the features to a format compatible with *LIBSVM* and run the classifiers
using the following scripts.  The results of the classifiers are printed to the
file `cls/output.dat`.

    ./step14-libsvm-format.sh
    ./step15-classify.sh

The last script combines the results from the classifiers with the file
containing the feature values for all images (the horizontal concatenation of
all `.dat` files) to produce the graphs and tables.

    ./step16-outputs.sh

