*&---------------------------------------------------------------------*
*& Include          ZBRSD0050_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA1 .
* 조회조건에 해당하는 배송 데이터 취득
  SELECT *
    FROM ZTBSD0060 " 배송 테이블
   WHERE DELIVNUM IN @SO_DELI " 배송번호
     AND DONUM IN @SO_DONU " 출하오더번호
     AND SONUM IN @SO_SONU " 판매오더번호
     AND TRANSPORT IN @SO_TRAN " 배송방법
     AND EMPID IN @SO_EMPI " 배송데이터 생성 사원ID
     AND DELIVSDAT IN @SO_DDAT " 배송시작일
     AND STATUS EQ 'A' " 대금청구 생성 전
    ORDER BY DELIVNUM ASCENDING " 배송번호 기준 오름차순 정렬
    INTO CORRESPONDING FIELDS OF TABLE @GT_DISPLAY1.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT_1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT_1 .
  IF GO_DOCK IS INITIAL.

    CREATE OBJECT GO_DOCK
      EXPORTING
        REPID     = SY-REPID
        DYNNR     = SY-DYNNR
        SIDE      = GO_DOCK->DOCK_AT_TOP
*       side      = cl_gui_docking_container=>dock_at_top
        EXTENSION = 1000.

    CREATE OBJECT GO_ESPLIT
      EXPORTING
        PARENT        = GO_DOCK
        ORIENTATION   = 0   " 0 , 1
        SASH_POSITION = 500.

    GO_CONT1 = GO_ESPLIT->TOP_LEFT_CONTAINER.
    GO_CONT2 = GO_ESPLIT->BOTTOM_RIGHT_CONTAINER.

    CREATE OBJECT GO_GRID1
      EXPORTING
        I_PARENT = GO_CONT1.

    CREATE OBJECT GO_GRID2
      EXPORTING
        I_PARENT = GO_CONT2.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT_ALV1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT_ALV1 .
  CLEAR GS_LAYO1.

  GS_LAYO1-GRID_TITLE = '배송 리스트'.
  GS_LAYO1-ZEBRA = 'X'.
  GS_LAYO1-CWIDTH_OPT = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT_ALV1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_FIELDCAT_ALV1 .
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DELIVNUM'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-KEY = 'X'.
  GS_FCAT1-COLTEXT = '배송 번호'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DONUM'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-COLTEXT = '출하오더번호'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'SONUM'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-COLTEXT = '판매오더번호'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DELIVCO'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-COLTEXT = '배송업체'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DELIVFEE'.
  GS_FCAT1-JUST = 'R'.
  GS_FCAT1-COLTEXT = '배송비'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'CURRENCY'.
  GS_FCAT1-JUST = 'L'.
  GS_FCAT1-COLTEXT = '화폐단위'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'TRANSPORT'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-COLTEXT = '배송방법'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'EMPID'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-COLTEXT = '배송생성 사원'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DELIVSDAT'.
  GS_FCAT1-JUST = 'C'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'DELIVFDAT'.
  GS_FCAT1-JUST = 'C'.
  GS_FCAT1-NO_OUT = 'X'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.

  GS_FCAT1-FIELDNAME = 'STATUS'.
  GS_FCAT1-NO_OUT = 'X'.
  APPEND GS_FCAT1 TO GT_FCAT1.
  CLEAR GS_FCAT1.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_ALV1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INIT_ALV1 .
  CALL METHOD GO_GRID1->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME              = 'ZTBSD0060'
*     IS_VARIANT                    =
*     I_SAVE                        =
*     I_DEFAULT                     =
      IS_LAYOUT                     = GS_LAYO1
*     IT_TOOLBAR_EXCLUDING          = LT_EXCLUD
    CHANGING
      IT_OUTTAB                     = GT_DISPLAY1
      IT_FIELDCATALOG               = GT_FCAT1
*     IT_SORT                       =
*     IT_FILTER                     =
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC <> 0.
    MESSAGE S205 DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_ALV1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_ALV1 .
  DATA: LS_STABLE TYPE LVC_S_STBL.

  CALL METHOD GO_GRID1->GET_FRONTEND_LAYOUT
    IMPORTING
      ES_LAYOUT = GS_LAYO1.

  GS_LAYO1-CWIDTH_OPT = ABAP_ON.

  CALL METHOD GO_GRID1->SET_FRONTEND_LAYOUT
    EXPORTING
      IS_LAYOUT = GS_LAYO1.

  CALL METHOD GO_GRID1->REFRESH_TABLE_DISPLAY
    EXPORTING
      IS_STABLE = LS_STABLE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV1 .
  PERFORM SET_LAYOUT_ALV1.
  PERFORM SET_FIELDCAT_ALV1.
*    PERFORM SET_EVENT_ALV1.
  PERFORM INIT_ALV1.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV2 .
  PERFORM SET_LAYOUT_ALV2.
  PERFORM SET_FIELDCAT_ALV2.
*    PERFORM SET_EVENT_ALV2.
  PERFORM INIT_ALV2.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT_ALV2 .
  CLEAR GS_LAYO2.

  GS_LAYO2-GRID_TITLE = '대금청구문서 생성 완료 리스트'.
  GS_LAYO2-ZEBRA = 'X'.
  GS_LAYO2-CWIDTH_OPT = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INIT_ALV2 .
* DIALOG ALV DISPLAY.
  GS_VARIANT-REPORT = SY-CPROG.
  GS_VARIANT-VARIANT = '/LAYOUT2'.

  CALL METHOD GO_GRID2->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME              = 'ZSBSD0050_ALV2'
      IS_VARIANT                    = GS_VARIANT
      I_SAVE                        = 'A'
*     I_DEFAULT                     = 'X'
      IS_LAYOUT                     = GS_LAYO2
*     IT_TOOLBAR_EXCLUDING          = LT_EXCLUD
    CHANGING
      IT_OUTTAB                     = GT_DISPLAY2
      IT_FIELDCATALOG               = GT_FCAT2
      IT_SORT                       = GT_SORT2
*     IT_FILTER                     =
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC <> 0.
    MESSAGE S205 DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_ALV2 .
  DATA: LS_STABLE TYPE LVC_S_STBL.

  CALL METHOD GO_GRID2->GET_FRONTEND_LAYOUT
    IMPORTING
      ES_LAYOUT = GS_LAYO2.


  GS_LAYO2-CWIDTH_OPT = ABAP_ON.

  CALL METHOD GO_GRID2->SET_FRONTEND_LAYOUT
    EXPORTING
      IS_LAYOUT = GS_LAYO2.

  CALL METHOD GO_GRID2->REFRESH_TABLE_DISPLAY
    EXPORTING
      IS_STABLE = LS_STABLE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_FIELDCAT_ALV2 .
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'BILNUM'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-KEY = 'X'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'DELIVNUM'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '배송 번호'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'BILDAT'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '대금청구문서 생성일'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'BPCODE'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '고객사 코드'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'BPNAME'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '고객사 명'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'ZTERM'.
  GS_FCAT2-JUST = 'C'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'TERMTXT'.
  GS_FCAT2-JUST = 'C'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'EMPID'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '대금청구 생성 사원ID'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'DDATE'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-COLTEXT = '입금예정일'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'MATCODE'.
  GS_FCAT2-JUST = 'C'.
  GS_FCAT2-KEY = 'X'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'MATNAME'.
  GS_FCAT2-JUST = 'C'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'AMOUNTPRD'.
  GS_FCAT2-JUST = 'R'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'UNITCODE'.
  GS_FCAT2-JUST = 'L'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'TOTALPRD'.
  GS_FCAT2-JUST = 'R'.
  GS_FCAT2-COLTEXT = '제품별 금액'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

  GS_FCAT2-FIELDNAME = 'CURRENCY'.
  GS_FCAT2-JUST = 'L'.
  APPEND GS_FCAT2 TO GT_FCAT2.
  CLEAR GS_FCAT2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CONFIRM_SAVE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CONFIRM_SAVE .
  DATA: LV_ANSWER.

  CLEAR: GT_ROW1, GS_ROW1, GS_DISPLAY1, GS_DISPLAY3, GT_DISPLAY3.

  CALL METHOD GO_GRID1->GET_SELECTED_ROWS
    IMPORTING
      ET_ROW_NO = GT_ROW1.

* 선택한 행 정보.
  READ TABLE GT_ROW1 INTO GS_ROW1 INDEX 1.
  READ TABLE GT_DISPLAY1 INTO GS_DISPLAY1 INDEX GS_ROW1-ROW_ID.

  IF GS_DISPLAY1 IS INITIAL. " 데이터 선택안하고 눌렀을 때.
    MESSAGE S107 DISPLAY LIKE 'E'. " 배송 데이터를 선택해주세요.

  ELSE. " 데이터를 선택했을 때.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        TITLEBAR              = TEXT-T02 " 대금청구 생성 확인.
        TEXT_QUESTION         = TEXT-Q01 " 대금청구 생성을 진행하시겠습니까?
        TEXT_BUTTON_1         = 'YES'
        ICON_BUTTON_1         = 'ICON_OKAY'
        TEXT_BUTTON_2         = 'NO'
        ICON_BUTTON_2         = 'ICON_CANCEL'
        DEFAULT_BUTTON        = '1'
        DISPLAY_CANCEL_BUTTON = ''
      IMPORTING
        ANSWER                = LV_ANSWER.
    IF SY-SUBRC <> 0.
* Implement suitable error handling here
    ENDIF.

    IF LV_ANSWER = '2'. " 컨펌팝업에서 NO 눌렀을 때.
      MESSAGE S105. " 대금청구 생성을 취소하였습니다.

    ELSE. " 컨펌팝업에서 YES 눌렀을 때.
      MESSAGE S106. " 대금청구 내용을 확인해주세요.
      CALL SCREEN 110
        STARTING AT 20 5.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA3 .
  CLEAR ZSBSD0050_ALV3.

* 선택한 행에 대한 배송데이터 취득.
  SELECT SINGLE *
    FROM ZTBSD0060 " 배송오더 테이블
   WHERE DELIVNUM EQ @GS_DISPLAY1-DELIVNUM
    INTO CORRESPONDING FIELDS OF @GS_DISPLAY3.

  SELECT *
    FROM ZTBSD0030 AS A " 판매오더 헤더
    JOIN ZTBSD0031 AS B " 판매오더 아이템
      ON A~SONUM EQ B~SONUM
   WHERE A~SONUM EQ @GS_DISPLAY3-SONUM
   ORDER BY MATCODE ASCENDING
   INTO CORRESPONDING FIELDS OF TABLE @GT_DISPLAY3.

  LOOP AT GT_DISPLAY3 INTO GS_DISPLAY3.
    SELECT SINGLE MATNAME
      FROM ZTBMM1011 " 자재명 Text table
     WHERE MATCODE EQ @GS_DISPLAY3-MATCODE
      INTO @GS_DISPLAY3-MATNAME.

    MODIFY GT_DISPLAY3 FROM GS_DISPLAY3 INDEX SY-TABIX TRANSPORTING MATNAME.
  ENDLOOP.

  READ TABLE GT_DISPLAY3 INTO GS_DISPLAY3 INDEX 1.

  SELECT SINGLE *
    FROM ZTBSD0060 " 배송오더 테이블
   WHERE SONUM EQ @GS_DISPLAY3-SONUM
    INTO CORRESPONDING FIELDS OF @GS_DISPLAY3.

  SELECT SINGLE *
    FROM ZTBSD1051 AS A " 거래처명 Text table
    JOIN ZTBSD1050 AS B " 거래처 마스터
      ON A~BPCODE EQ B~BPCODE
   WHERE A~BPCODE EQ @GS_DISPLAY3-BPCODE
    INTO CORRESPONDING FIELDS OF @GS_DISPLAY3.

  SELECT SINGLE *
    FROM ZTBFI0040 " 지급조건 마스터
   WHERE ZTERM EQ @GS_DISPLAY3-ZTERM
    INTO CORRESPONDING FIELDS OF @GS_DISPLAY3.

  GS_DISPLAY3-BILDAT = SY-DATUM.

  CASE GS_DISPLAY3-ZTERM.
    WHEN 'Z001'.
      GS_DISPLAY3-DDATE = SY-DATUM + 30.
    WHEN 'Z002'.
      GS_DISPLAY3-DDATE = SY-DATUM + 60.
    WHEN OTHERS.
  ENDCASE.

  MOVE-CORRESPONDING GS_DISPLAY3 TO ZSBSD0050_ALV3.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT_3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT_3 .
  CREATE OBJECT GO_CUST3
    EXPORTING
      CONTAINER_NAME              = 'CUST3'
    EXCEPTIONS
      CNTL_ERROR                  = 1
      CNTL_SYSTEM_ERROR           = 2
      CREATE_ERROR                = 3
      LIFETIME_ERROR              = 4
      LIFETIME_DYNPRO_DYNPRO_LINK = 5
      OTHERS                      = 6.
  IF SY-SUBRC <> 0.
  ENDIF.

  CREATE OBJECT GO_GRID3
    EXPORTING
      I_PARENT          = GO_CUST3
    EXCEPTIONS
      ERROR_CNTL_CREATE = 1
      ERROR_CNTL_INIT   = 2
      ERROR_CNTL_LINK   = 3
      ERROR_DP_CREATE   = 4
      OTHERS            = 5.
  IF SY-SUBRC <> 0.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT_ALV3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_LAYOUT_ALV3 .
  CLEAR GS_LAYO3.

  GS_LAYO3-GRID_TITLE = '대금청구 자재 리스트'.
  GS_LAYO3-ZEBRA = 'X'.
  GS_LAYO3-CWIDTH_OPT = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT_ALV3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_FIELDCAT_ALV3 .
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'DELIVNUM'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'DONUM'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'SONUM'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'BILDAT'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'DDATE'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'ZTERM'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'TERMTXT'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'BPCODE'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'BPNAME'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-NO_OUT = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'MATCODE'.
  GS_FCAT3-JUST = 'C'.
  GS_FCAT3-KEY = 'X'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'MATNAME'.
  GS_FCAT3-JUST = 'C'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'AMOUNTPRD'.
  GS_FCAT3-JUST = 'C'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'UNITCODE'.
  GS_FCAT3-JUST = 'C'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'TOTALPRD'.
  GS_FCAT3-JUST = 'C'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

  GS_FCAT3-FIELDNAME = 'CURRENCY'.
  GS_FCAT3-JUST = 'C'.
  APPEND GS_FCAT3 TO GT_FCAT3.
  CLEAR GS_FCAT3.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form INIT_ALV3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM INIT_ALV3 .
  " DIALOG ALV DISPLAY.
  GS_VARIANT-REPORT = SY-CPROG.
  GS_VARIANT-VARIANT = '/LAYOUT3'.

  CALL METHOD GO_GRID3->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_STRUCTURE_NAME              = 'ZSBSD0050_ALV3'
      IS_VARIANT                    = GS_VARIANT
      I_SAVE                        = 'A'
*     I_DEFAULT                     = 'X'
      IS_LAYOUT                     = GS_LAYO3
*     IT_TOOLBAR_EXCLUDING          = LT_EXCLUD
    CHANGING
      IT_OUTTAB                     = GT_DISPLAY3
      IT_FIELDCATALOG               = GT_FCAT3
*     IT_SORT                       = GT_SORT3
*     IT_FILTER                     =
    EXCEPTIONS
      INVALID_PARAMETER_COMBINATION = 1
      PROGRAM_ERROR                 = 2
      TOO_MANY_LINES                = 3
      OTHERS                        = 4.
  IF SY-SUBRC <> 0.
    MESSAGE S205 DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_ALV3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_ALV3 .
  DATA: LS_STABLE TYPE LVC_S_STBL.

  CALL METHOD GO_GRID3->GET_FRONTEND_LAYOUT
    IMPORTING
      ES_LAYOUT = GS_LAYO3.

  GS_LAYO3-CWIDTH_OPT = ABAP_ON.

  CALL METHOD GO_GRID3->SET_FRONTEND_LAYOUT
    EXPORTING
      IS_LAYOUT = GS_LAYO3.

  CALL METHOD GO_GRID3->REFRESH_TABLE_DISPLAY
    EXPORTING
      IS_STABLE = LS_STABLE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SAVE_BILLING
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SAVE_BILLING .
  DATA: LV_ANSWER,
        LV_NR        TYPE NUM7,
        LV_NUMRANGE  TYPE C LENGTH 10,
        LV_NUMRANGE2 TYPE C LENGTH 10,
        LV_WRBTR     TYPE ZTBFI0031-WRBTR,
        LV_HWRBTR    TYPE ZTBFI0031-WRBTR,
        LV_BKPRNUM   TYPE NUM10.

  DATA: LS_ZTBSD0050 TYPE ZTBSD0050,
        LS_ZTBSD0051 TYPE ZTBSD0051.

  DATA: LS_ZTBFI0030 TYPE ZTBFI0030,
        LS_ZTBFI0031 TYPE ZTBFI0031.

  SELECT SINGLE EMPID
    FROM ZTBSD1030
   WHERE LOGID EQ @SY-UNAME
    INTO @DATA(LV_EMPID).

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = TEXT-T02 " 대금청구 생성 확인.
      TEXT_QUESTION         = TEXT-Q02 " 대금청구 생성을 하시겠습니까?
      TEXT_BUTTON_1         = 'YES'
      ICON_BUTTON_1         = 'ICON_OKAY'
      TEXT_BUTTON_2         = 'NO'
      ICON_BUTTON_2         = 'ICON_CANCEL'
      DEFAULT_BUTTON        = '1'
      DISPLAY_CANCEL_BUTTON = ''
    IMPORTING
      ANSWER                = LV_ANSWER.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

  IF LV_ANSWER = '2'. " 컨펌팝업에서 NO 눌렀을 때.
    MESSAGE S105. " 대금청구 생성을 취소하였습니다.

  ELSE. " 컨펌팝업에서 YES 눌렀을 때.
    "NUMBER RANGE 호출.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        NR_RANGE_NR             = '01'
        OBJECT                  = 'ZBBSD0050'
      IMPORTING
        NUMBER                  = LV_NR
      EXCEPTIONS
        INTERVAL_NOT_FOUND      = 1
        NUMBER_RANGE_NOT_INTERN = 2
        OBJECT_NOT_FOUND        = 3
        QUANTITY_IS_0           = 4
        QUANTITY_IS_NOT_1       = 5
        INTERVAL_OVERFLOW       = 6
        BUFFER_OVERFLOW         = 7
        OTHERS                  = 8.
    IF SY-SUBRC <> 0.
    ENDIF.

    CONCATENATE 'BIL' LV_NR INTO LV_NUMRANGE.

    MOVE-CORRESPONDING GT_DISPLAY3 TO GT_DISPLAY2.

    LOOP AT GT_DISPLAY2 INTO GS_DISPLAY2.
      GS_DISPLAY2-DELIVNUM = ZSBSD0050_ALV3-DELIVNUM.
      GS_DISPLAY2-BILDAT = ZSBSD0050_ALV3-BILDAT.
      GS_DISPLAY2-DDATE = ZSBSD0050_ALV3-DDATE.
      GS_DISPLAY2-ZTERM = ZSBSD0050_ALV3-ZTERM.
      GS_DISPLAY2-TERMTXT = ZSBSD0050_ALV3-TERMTXT.
      GS_DISPLAY2-BPCODE = ZSBSD0050_ALV3-BPCODE.
      GS_DISPLAY2-BPNAME = ZSBSD0050_ALV3-BPNAME.
      GS_DISPLAY2-BILNUM = LV_NUMRANGE.
      GS_DISPLAY2-EMPID = LV_EMPID.
      MODIFY GT_DISPLAY2 FROM GS_DISPLAY2 INDEX SY-TABIX.

* ZTBSD0051 대금청구문서 ITEM DATA CREATE
      MOVE-CORRESPONDING GS_DISPLAY2 TO LS_ZTBSD0051.
      INSERT ZTBSD0051 FROM LS_ZTBSD0051.
    ENDLOOP.

* ZTBMSD0060에서 대금청구를 완료한 행에 대해서 STATUS UPDATE.
    UPDATE ZTBSD0060
       SET STATUS = 'B'
     WHERE DELIVNUM = GS_DISPLAY2-DELIVNUM.

* ZTBSD0050 대금청구문서 HEADER DATA CREATE
    MOVE-CORRESPONDING GS_DISPLAY2 TO LS_ZTBSD0050.
    INSERT ZTBSD0050 FROM LS_ZTBSD0050.


* 대금청구로 발생한 전표 헤더 CREATE.
    " 전표 번호 NUMBER RANGE 호출.
    CLEAR LV_NUMRANGE2.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        NR_RANGE_NR             = '01'
        OBJECT                  = 'ZBBFI0030'
      IMPORTING
        NUMBER                  = LV_NUMRANGE2
      EXCEPTIONS
        INTERVAL_NOT_FOUND      = 1
        NUMBER_RANGE_NOT_INTERN = 2
        OBJECT_NOT_FOUND        = 3
        QUANTITY_IS_0           = 4
        QUANTITY_IS_NOT_1       = 5
        INTERVAL_OVERFLOW       = 6
        BUFFER_OVERFLOW         = 7
        OTHERS                  = 8.
    IF SY-SUBRC <> 0.
    ENDIF.

    CLEAR LS_ZTBFI0030.

    DATA(LV_MONTH) = SY-DATUM+4(2).
    DATA(LV_BPNAME) = ZSBSD0050_ALV3-BPNAME.

    CONCATENATE LV_MONTH '월' LV_BPNAME ' 제품매출 ' INTO LS_ZTBFI0030-BKTXT.

    LS_ZTBFI0030-BELNR = LV_NUMRANGE2.
    LS_ZTBFI0030-COMCODE = '1000'.
    LS_ZTBFI0030-GJAHR = SY-DATUM+0(4).
    LS_ZTBFI0030-BLART = 'DR'.
    LS_ZTBFI0030-BUDAT = SY-DATUM.
    LS_ZTBFI0030-BLDAT = SY-DATUM.
    LS_ZTBFI0030-XBLNR = LV_NUMRANGE.
    LS_ZTBFI0030-REVRS = SPACE.
    LS_ZTBFI0030-USNAM = LV_EMPID.
    LS_ZTBFI0030-STAMP_DATE_F = SY-DATUM.
    LS_ZTBFI0030-STAMP_TIME_F = SY-UZEIT.
    LS_ZTBFI0030-STAMP_USER_F = LS_ZTBFI0030-USNAM.

    INSERT ZTBFI0030 FROM LS_ZTBFI0030.

* 대금청구로 발생한 전표 아이템 CREATE.
    CLEAR LS_ZTBFI0031.

    LS_ZTBFI0031-BELNR = LV_NUMRANGE2.
    LS_ZTBFI0031-BUZEI = '1'.
    LS_ZTBFI0031-SHKZG = 'S'.
    LS_ZTBFI0031-ACODE = '10005'.
    LS_ZTBFI0031-ANAME = '외상매출금'.
    LS_ZTBFI0031-CURRENCY = 'KRW'.

    LS_ZTBFI0031-ITTXT = LS_ZTBFI0030-BKTXT.

    LS_ZTBFI0031-BPCODE = ZSBSD0050_ALV3-BPCODE.
    LS_ZTBFI0031-ZTERM = ZSBSD0050_ALV3-ZTERM.

    LOOP AT GT_DISPLAY2 INTO GS_DISPLAY2.
      LV_HWRBTR = LV_HWRBTR + GS_DISPLAY2-TOTALPRD.
    ENDLOOP.

    LS_ZTBFI0031-HWRBTR = LV_HWRBTR.
    LS_ZTBFI0031-CURRENCY_F = GS_DISPLAY2-CURRENCY.

    CASE LS_ZTBFI0031-CURRENCY_F.
      WHEN 'KRW'.
        LS_ZTBFI0031-WRBTR = LS_ZTBFI0031-HWRBTR.

      WHEN 'USD'.
        SELECT SINGLE BKPR
         FROM ZTBFI0050
        WHERE CUR_DATE EQ @SY-DATUM
          AND CUR_UNIT EQ 'USD'
         INTO @DATA(LV_BKPR).
        LV_BKPRNUM = LV_BKPR.
        LS_ZTBFI0031-WRBTR = ( LS_ZTBFI0031-HWRBTR * LV_BKPRNUM ) / 100.
      WHEN 'CNY'.
        SELECT SINGLE BKPR
         FROM ZTBFI0050
        WHERE CUR_DATE EQ @SY-DATUM
          AND CUR_UNIT EQ 'CNH'
         INTO @LV_BKPR.
        LV_BKPRNUM = LV_BKPR.
        LS_ZTBFI0031-WRBTR = ( LS_ZTBFI0031-HWRBTR * LV_BKPRNUM ) / 100.
      WHEN 'EUR'.
        SELECT SINGLE BKPR
         FROM ZTBFI0050
        WHERE CUR_DATE EQ @SY-DATUM
          AND CUR_UNIT EQ 'EUR'
         INTO @LV_BKPR.
        LV_BKPRNUM = LV_BKPR.
        LS_ZTBFI0031-WRBTR = ( LS_ZTBFI0031-HWRBTR * LV_BKPRNUM ) / 100.
    ENDCASE.

    LS_ZTBFI0031-CURRENCY = 'KRW'.
    LS_ZTBFI0031-STAMP_DATE_F = SY-DATUM.
    LS_ZTBFI0031-STAMP_TIME_F = SY-UZEIT.
    LS_ZTBFI0031-STAMP_USER_F = LS_ZTBFI0030-USNAM.

    INSERT ZTBFI0031 FROM LS_ZTBFI0031.

    LS_ZTBFI0031-BUZEI = '2'.
    LS_ZTBFI0031-SHKZG = 'H'.
    LS_ZTBFI0031-ACODE = '40001'.
    LS_ZTBFI0031-ANAME = '제품매출'.
    LS_ZTBFI0031-STAMP_DATE_F = SY-DATUM.
    LS_ZTBFI0031-STAMP_TIME_F = SY-UZEIT.
    LS_ZTBFI0031-STAMP_USER_F = LS_ZTBFI0030-USNAM.

    INSERT ZTBFI0031 FROM LS_ZTBFI0031.

* 대금청구문서 생성 완료 시 MESSAGE - 대금청구문서, 전표 번호 명시.
    MESSAGE S108 WITH LV_NUMRANGE LV_NUMRANGE2. " 대금청구문서 LV_NUMRANGE 를 성공적으로 생성하였습니다.
  ENDIF.

* 팝업 종료.
  LEAVE TO SCREEN 0.
ENDFORM.
