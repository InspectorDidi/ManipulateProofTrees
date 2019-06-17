#!/bin/bash

PROOFS="./ProofSourceFiles"
LIB=$1
OUTDIR="./ProofTrees/StdLib/${LIB}"
BASE="/home/scottviteri/LocalSoftware/coq/theories"
for X in ${BASE}/${LIB}/*.v;
do
 for THEOREM in $(cat $X | grep "^Theorem" | awk '{print $2}');
 do
  cat ${PROOFS}/ExportProofBase.v > ${PROOFS}/ExportProof.v
  echo "Require Import ${LIB}." >> ${PROOFS}/ExportProof.v
  echo "PrintAST ${THEOREM} with depth 2." >> ${PROOFS}/ExportProof.v
  mkdir -p $OUTDIR
  coqc ${PROOFS}/ExportProof.v > ${OUTDIR}/${THEOREM}.txt
 done
done

#Currently only matching on Theorem at beginning of line
