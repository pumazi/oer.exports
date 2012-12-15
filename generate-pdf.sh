#!/bin/bash
TEMPDIR="tmp-generate-pdf"
ZIPNAME="tmp.zip"
STYLE=${STYLE:-"ccap-physics"}
COLID_VER_PATH=${1:-"col11406/1.7"}
COLID_VER=${COLID_VER_PATH/\//-}
HOST=${HOST:-"cnx.org"}
URL=${URL:-"http://${HOST}/content/${COLID_VER_PATH}/complete"}

rm -rf ${TEMPDIR}
mkdir ${TEMPDIR}
touch ${COLID_VER}.start
cd ${TEMPDIR}
curl -o ${ZIPNAME} ${URL}
unzip ${ZIPNAME}
# Unzip creates a col123_complete dir and puts everything underneath.
# Just move all those files back up
rm ${ZIPNAME}
mv */* .

cd ..

python collectiondbk2pdf.py -p ${PRINCEXML_PATH} -s ${STYLE} -d ${TEMPDIR} ${COLID_VER}-local.pdf
touch ${COLID_VER}.done
