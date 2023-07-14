#!/bin/bash

BIGFILE=$1
OUTFILE=$2
PARTSIZE=$((1*1024*1024*1024)) # 1 GiB
FILESIZE=$(stat -c%s "$BIGFILE")
echo "Size of $BIGFILE = $FILESIZE bytes."

CHUNKS=$((FILESIZE / PARTSIZE))
if (( FILESIZE % PARTSIZE == 0 ))
then
    echo "CHUNKS = $CHUNKS"
else
    ((CHUNKS = CHUNKS + 1))
    echo "CHUNKS = $CHUNKS"
fi

for ((i=0;i<$CHUNKS;i++));
do
	echo "Transfer CHUNK $i out of $CHUNKS"
  dd if=$BIGFILE bs=$PARTSIZE skip=$i count=1 iflag=sync oflag=sync >> $OUTFILE
  sleep 10
  sync
done
