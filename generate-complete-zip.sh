#!/bin/bash
COLID_VER_PATH=${1:-"col11406/1.7"}
COLID_VER=${COLID_VER_PATH/\//_}
HOST=${HOST:-"cnx.org"}
URL=${URL:-"http://${HOST}/content/${COLID_VER_PATH}"}

COL_VER=$(curl -s ${URL}/getVersion)
DIRNAME=${COLID_VER}_complete

rm -rf ${DIRNAME}
mkdir ${DIRNAME}
touch ${COLID_VER}-completezip.start
cd ${DIRNAME}
curl -s -o collection.xml ${URL}/source_create
REPO=$(xsltproc ../xsl/getrepo.xsl collection.xml)
xsltproc ../xsl/getmods.xsl collection.xml  | while read MID VER
 do 
   MURL=$REPO"/"$MID"/"$VER
   #echo $MURL
   mkdir $MID
   curl -s ${MURL}/upgrade_cnxml >$MID/index_auto_generated.cnxml
   while read -r FNAME 
     do 
       # echo ${FNAME}
       curl -s "${MURL}/${FNAME}" >"${MID}/${FNAME}"
     done < <(curl -s ${MURL}/filenames)
 done 

cd ..
zip -q -r ${DIRNAME}.zip $DIRNAME
rm -rf ${DIRNAME}
