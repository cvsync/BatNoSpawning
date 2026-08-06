#! /bin/sh

VER_MAJOR=1
VER_MINOR=0
VER_REV=0

MAX_PACK_FORMAT=115
MAX_PACK_FORMAT_MINOR=0

MIN_PACK_FORMAT=88
MIN_PACK_FORMAT_MINOR=0

UUID1=dd64c096-a364-410e-8c97-e15e4a1794a8
UUID2=d28535ad-3373-44f7-9202-0b9850ced6bb

RESOURCE_PACK_NAME=BatNoSpawning

RESOURCE_PACK_FILE_JAVA=${RESOURCE_PACK_NAME}.zip

TMPDIR=./tmp

rm -f -r ${VER_MAJOR}.${VER_MINOR}.${VER_REV}
mkdir -p ${VER_MAJOR}.${VER_MINOR}.${VER_REV}

#
# for Java Edition
#
TEXTURES_SRCDIR=${RESOURCE_PACK_NAME}/data/minecraft/tags/block
TEXTURES_DSTDIR=${TMPDIR}/data/minecraft/tags/block
rm -f ${RESOURCE_PACK_FILE_JAVA}
rm -f -r ${TMPDIR}
mkdir -p ${TMPDIR} ${TMPDIR}/data
mkdir -p ${TMPDIR}/data/minecraft ${TMPDIR}/data/minecraft/tags ${TMPDIR}/data/minecraft/tags/block
cp ${TEXTURES_SRCDIR}/bats_spawnable_on.json ${TEXTURES_DSTDIR}/bats_spawnable_on.json
#cp -R ${RESOURCE_PACK_NAME}/pack.png ${TMPDIR}/
_destfile=pack.mcmeta
cat ${RESOURCE_PACK_NAME}/${_destfile} | \
sed "s/XXXMAXPACKFORMATXXX/${MAX_PACK_FORMAT}/g" | \
sed "s/XXXMAXPACKFORMATMINORXXX/${MAX_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMINPACKFORMATXXX/${MIN_PACK_FORMAT}/g" | \
sed "s/XXXMINPACKFORMATMINORXXX/${MIN_PACK_FORMAT_MINOR}/g" | \
sed "s/XXXMAJORXXX/${VER_MAJOR}/g" | \
sed "s/XXXMINORXXX/${VER_MINOR}/g" | \
sed "s/XXXREVXXX/${VER_REV}/g" | \
sed "s/XXXUUID1XXX/${UUID1}/g" | \
sed "s/XXXUUID2XXX/${UUID2}/g" | \
sed "s///g" > ${TMPDIR}/${_destfile}
(cd ${TMPDIR}/ && sudo chown -R 0:0 .)
(cd ${TMPDIR}/ && zip -r ../${VER_MAJOR}.${VER_MINOR}.${VER_REV}/${RESOURCE_PACK_FILE_JAVA} . -i "*")
sudo rm -f -r ${TMPDIR}

ls -l ${VER_MAJOR}.${VER_MINOR}.${VER_REV}/
