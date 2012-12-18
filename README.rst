===========
oer.exports
===========

Logic used to transform/package various pieces of Rhaptos/Connxions content to
other formats.

Installation
------------

These instructions assume you have ``python`` (version >= 2.6) and
``virtualenv`` installed.

Installation on Debian
~~~~~~~~~~~~~~~~~~~~~~

To install and get this package running on Debian, use the following commands::

    sudo apt-get install libxslt1-dev libxml2-dev # For lxml to compile
    sudo apt-get install librsvg2-bin             # To convert SVG and math to PNG
    sudo apt-get install otf-stix

    cd oer.exports
    virtualenv .
    source bin/activate
    easy_install lxml argparse pil

Installation on Mac
~~~~~~~~~~~~~~~~~~~

The following uses Homebrew to install the system level
dependencies. You may have to adjust if you use a different packaging
system.
::

    brew install libxml libxslt
    brew install librsvg
    brew install https://github.com/adamv/homebrew-alt/blob/master/non-free/princexml.rb
    brew install wkhtmltopdf

    cd oer.exports
    virtualenv .
    source bin/activate
    easy_install lxml argparse pil

Usage
-----

To generate a **PDF** use the following command. You will need PrinceXML
or wkhtmltopdf installed. By filling in the
``${path-to-wkhtml2pdf-or-princexml}`` value, with the binary location
for PrinceXML or wkhtmltopdf you will be able to run this command
against the test data in this repository.
::

    python collectiondbk2pdf.py -p ${path-to-wkhtml2pdf-or-princexml} -d test-ccap -s ccap-physics result.pdf

To generate an **EPUB** use the following command::

    ./scripts/module2epub.sh "Connexions" test-ccap test-ccap.epub col12345 xsl/dbk2epub.xsl static/content.css

An alternative script for generating an **EPUB**::

    # For a collection:
    python content2epub.py -c ./static/content.css -e ./xsl/dbk2epub.xsl -t "collection" -o ./test-ccap.epub ./test-ccap/
    
    # For just a module:
    python content2epub.py -c ./static/content.css -e ./xsl/dbk2epub.xsl -t "module" -o ./m123.epub -i "m123" ./test-ccap/m-section/
