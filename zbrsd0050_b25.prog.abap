*&---------------------------------------------------------------------*
*& Report ZBRSD0050
*&---------------------------------------------------------------------*
*&   [MM]
*&   개발자        : CL2 kdt-b-25 하정훈
*&   프로그램 개요   : 대금청구 생성 프로그램
*&   개발 시작일    :'2024.11.18'
*&   개발 완료일    :'2024.11.19
*&   개발상태      : 개발 완료.
*&---------------------------------------------------------------------*
REPORT ZBRSD0050_B25 MESSAGE-ID ZCOMMON_MSG.

INCLUDE ZBRSD0050_B25_TOP.
INCLUDE ZBRSD0050_B25_C01.
INCLUDE ZBRSD0050_B25_S01.
INCLUDE ZBRSD0050_B25_O01.
INCLUDE ZBRSD0050_B25_I01.
INCLUDE ZBRSD0050_B25_F01.

INITIALIZATION.

AT SELECTION-SCREEN.

START-OF-SELECTION.
  CALL SCREEN 100.
