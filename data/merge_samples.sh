DATA_DIR=data/KS_16RNA_S-21-0440_FA280
OUT_DIR=data/processed

rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}

# Merge samples from different lanes
for SAMPLE in KB1 KB2 KB3 WB1 WB2 WB3 KL1 KL2 KL3 WL1 WL2 WL3 KB4 WB4 KL4 WL4; do
  echo "Processing ${SAMPLE}..."
  # Create out file
  OUT_FILE=${OUT_DIR}/${SAMPLE}.fastq
  touch ${OUT_FILE}

  # Merge
  FILES=${DATA_DIR}/${SAMPLE}*.fastq.gz
  for FILE in ${FILES}; do
    gunzip -c ${FILE} >> ${OUT_FILE}
  done

  # Create gzip
  gzip ${OUT_FILE}
done
