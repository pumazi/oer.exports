#!/bin/bash
TEMPDIR="tmp-generate-epub"
ZIPNAME="tmp.zip"
COLID_VER_PATH=${1:-"col11406/1.7"}
COLID_VER=${COLID_VER_PATH/\//-}
HOST=${HOST:-"cnx.org"}
URL=${URL:-"http://${HOST}/content/${COLID_VER_PATH}/complete"}

rm -rf ${TEMPDIR}
mkdir ${TEMPDIR}
touch ${COLID_VER}-epub.start
cd ${TEMPDIR}
curl -o ${ZIPNAME} ${URL}
unzip ${ZIPNAME}
# Unzip creates a col123_complete dir and puts everything underneath.
# Just move all those files back up
rm ${ZIPNAME}
mv */* .

cd ..

./scripts/module2epub.sh "Connexions" ${TEMPDIR} ${COLID_VER}.epub $COLID xsl/dbk2epub.xsl static/content.css
touch ${COLID_VER}-epub.done
