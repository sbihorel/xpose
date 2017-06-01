;; 1. Based on:          000
;; 2. Description:       
;;    Run for testthat
$PROBLEM    xpose test run
$INPUT      ID OCC XAT2=DROP DGRP=DROP DOSE FLAG=DROP ONO=DROP
            XIME=DROP DVO=DROP NEUY=DROP SCR AGE SEX CLASS WT DROP ACE
            MED1 MED2 NUMB=DROP TAD TIME VIDD=DROP CLCR AMT SS II DROP
            CMT=DROP CONO=DROP DV EVID=DROP OVID=DROP DROP SHR2=DROP
$DATA      mx19_1.csv IGNORE=@
$ABBREVIATED DERIV2=NO COMRES=6
$SUBROUTINE ADVAN2 TRANS1
$PK 

   TVCL  = THETA(1)*(1+THETA(6)*(CLCR-65))
   TVV   = THETA(2)*WT
   CL    = TVCL*EXP(ETA(1))
   V     = TVV*EXP(ETA(2))  
   KA    = THETA(3)*EXP(ETA(3))
   ALAG1 = THETA(4)
   K     = CL/V
   S2    = V

$ERROR 
     A1    = A(1)
     A2    = A(2)
     IPRED = LOG(.025)
     W     = THETA(5)
     IF(F.GT.0) IPRED = LOG(F)
     IRES  = IPRED-DV
     IWRES = IRES/W
     Y     = IPRED+ERR(1)*W

$THETA  (0,27.5) ; TVCL
$THETA  (0,1.565) ; TVV
$THETA  (0,2.1) ; TVKA
$THETA  (0,.254) ; LAG
$THETA  (0,.23) ; RES ERR
$THETA  (0,.008,.02941) ; CRCL on CL
$OMEGA  .3  ;     IIV CL
$OMEGA  .3  ;      IIV V
$OMEGA  .3  ;     IIV KA
$SIGMA  1  FIX

$ESTIMATION METHOD=1 INTER MAXEVALS=9999 PRINT=5 NOABORT
$COVARIANCE PRINT=E
$TABLE      ID OCC DOSE AMT SS II TIME TAD IPRED CWRES CPRED IWRES 
            EVID ONEHEADER NOPRINT FILE=sdtab001
$TABLE      ID SEX MED1 MED2 ONEHEADER NOPRINT FILE=catab001
$TABLE      ID CLCR AGE WT ONEHEADER NOPRINT FILE=cotab001
$TABLE      ID KA CL V ALAG1 ETAS(1:LAST) ONEHEADER NOPRINT FILE=patab001
