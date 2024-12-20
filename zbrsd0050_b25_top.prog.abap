*&---------------------------------------------------------------------*
*& Include          ZBRSD0050_TOP
*&---------------------------------------------------------------------*

DATA: OK_CODE    TYPE SY-UCOMM,
      GS_VARIANT TYPE DISVARIANT.

TABLES: ZTBSD0030, " 판매오더 헤더
        ZTBSD0031, " 판매오더 아이템
        ZTBSD0040, " 출하오더
        ZTBSD0060, " 배송오더
        ZSBSD0050_ALV3.

" ALV1 DISPLAY TYPE & WA & ITAB
DATA: GS_DISPLAY1 TYPE ZTBSD0060,
      GT_DISPLAY1 LIKE TABLE OF GS_DISPLAY1.

" ALV1 WA & ITAB
DATA: GO_DOCK   TYPE REF TO CL_GUI_DOCKING_CONTAINER,
      GO_ESPLIT TYPE REF TO CL_GUI_EASY_SPLITTER_CONTAINER,
      GO_CONT1  TYPE REF TO CL_GUI_CONTAINER,
      GO_CONT2  TYPE REF TO CL_GUI_CONTAINER,
      GO_GRID1  TYPE REF TO CL_GUI_ALV_GRID,
      GO_GRID2  TYPE REF TO CL_GUI_ALV_GRID,
      GS_LAYO1  TYPE LVC_S_LAYO,
      GT_SORT1  TYPE LVC_T_SORT,
      GS_SORT1  TYPE LVC_S_SORT,
      GT_FCAT1  TYPE LVC_T_FCAT,
      GS_FCAT1  TYPE LVC_S_FCAT.

" ALV2 DISPLAY TYPE & WA & ITAB
DATA: GS_DISPLAY2 TYPE ZSBSD0050_ALV2,
      GT_DISPLAY2 LIKE TABLE OF GS_DISPLAY2.

" ALV2 WA & ITAB
DATA: GS_LAYO2  TYPE LVC_S_LAYO,
      GT_SORT2  TYPE LVC_T_SORT,
      GS_SORT2  TYPE LVC_S_SORT,
      GT_FCAT2  TYPE LVC_T_FCAT,
      GS_FCAT2  TYPE LVC_S_FCAT.

" ALV3 DISPLAY TYPE & WA & ITAB
DATA: GS_DISPLAY3 TYPE ZSBSD0050_ALV3,
      GT_DISPLAY3 LIKE TABLE OF GS_DISPLAY3.

" ALV3 WA & ITAB
DATA: GO_CUST3 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      GO_GRID3 TYPE REF TO CL_GUI_ALV_GRID,
      GS_LAYO3  TYPE LVC_S_LAYO,
      GT_FCAT3  TYPE LVC_T_FCAT,
      GS_FCAT3  TYPE LVC_S_FCAT.

* ALV1 SELECTED ROW ITAB & WA.
DATA: GT_ROW1 TYPE LVC_T_ROID,
      GS_ROW1 TYPE LVC_S_ROID.
