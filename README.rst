===========
oer.exports
===========

Logic used to transform/package various pieces of Rhaptos/Connxions content to
other formats.

This package generates PDFs from complete zips of collections or zips
of modules by converting the collxml and cnxml to docbook and then using a
XHTML+CSS3 to PDF script.

Technologies used:

* Connexions  : http://cnx.org
* Docbook XSL : http://docbook.org
* Docbook RNG : http://docbook.org/rng
* xsltproc    : http://xmlsoft.org/XSLT
* Saxon 9     : http://saxon.sourceforge.net
* pmml2svg    : http://pmml2svg.sourceforge.net
* STIX Fonts  : http://stixfonts.org

Installation
------------

These instructions assume you have ``python`` (version >= 2.6) and
``virtualenv`` installed.

::

    git clone https://github.com/Connexions/oer.exports.git


Installation on Debian
~~~~~~~~~~~~~~~~~~~~~~

The following instructures can be used to install the various
dependencies on Debian. If you haven't already done so, please include
the contrib and non-free repositories::

    sed -i 's/$/ contrib non-free/' /etc/apt/sources.list
    apt-get update

And if you haven't already installed python, please use the following::

    apt-get install python

The following are system level dependencies required to run some parts
of these scripts::

    apt-get install python-lxml python-argparse python-imaging
    apt-get install sun-java6-bin docbook-xsl-ns librsvg2-bin libgif4
    apt-get install otf-stix

PrinceXML is not in the Debian repository, so you'll need to download
the deb manually. See `princexml.com`_ for the latest version.
::

    wget  http://www.princexml.com/download/prince_8.1-3_ubuntu12.04_i386.deb
    dpkg --install prince_8.1-3_ubuntu12.04_i386.deb

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
    brew install librsvg

And the following will need to be set up manually:

- `Inkscape <http://inkscape.org/download/>`_
- `DocBook XSL NS
  <http://sourceforge.net/projects/docbook/files/docbook-xsl-ns/>`_

The Docbook XSL NS package will need to be downloaded an placed
locally in the root of the workspace as the ``docbook-xsl`` directory.
At this time some scripts use the ``docbook-xsl-ns`` package, while
others use a ``ruby`` based alternative found in the
``docbook-xsl`` directory.
Depending on what you're working on, you may need to replace (or
symlink) the ``docbook-xsl-ns`` package with the existing ``ruby``
based alternative.

To set up the python environment and have it ready to the oer.export
commands::

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
