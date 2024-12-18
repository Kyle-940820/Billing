*&---------------------------------------------------------------------*
*& Include          ZBRSD0050_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_DATA1 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE GET_DATA1 OUTPUT.
  PERFORM GET_DATA1.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV1 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE INIT_ALV1 OUTPUT.
  IF GO_DOCK IS INITIAL.
    PERFORM CREATE_OBJECT_1.
    PERFORM SET_ALV1.
    PERFORM SET_ALV2.

  ELSE.
    PERFORM REFRESH_ALV1.
    PERFORM REFRESH_ALV2.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0110 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0110 OUTPUT.
 SET PF-STATUS 'S110'.
 SET TITLEBAR 'T110'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_DATA3 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE GET_DATA3 OUTPUT.
  PERFORM GET_DATA3.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_ALV3 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE INIT_ALV3 OUTPUT.
  IF GO_CUST3 IS INITIAL.
    PERFORM CREATE_OBJECT_3.
    PERFORM SET_LAYOUT_ALV3.
    PERFORM SET_FIELDCAT_ALV3.
    PERFORM INIT_ALV3.

  ELSE.
    PERFORM REFRESH_ALV3.
  ENDIF.
ENDMODULE.