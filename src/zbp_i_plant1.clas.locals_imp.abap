CLASS lhc_ZI_PLANT DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_plant RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_plant RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_plant.

ENDCLASS.

CLASS lhc_ZI_PLANT IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA: lv_max_plant TYPE zeams_plant-plant,
        lv_number       TYPE i.

  SELECT SINGLE
         MAX( plant )
    FROM zeams_plant
    INTO @lv_max_plant.

  IF lv_max_plant IS INITIAL.
    lv_number = 1.
  ELSE.
    TRY.
        lv_number = lv_max_plant+2(2).
        lv_number = lv_number + 1.
      CATCH cx_sy_conversion_no_number.
        lv_number = 1.
    ENDTRY.
  ENDIF.

  LOOP AT entities INTO DATA(ls_entity).

    APPEND VALUE #(
      %cid    = ls_entity-%cid
      plant = |P{ lv_number WIDTH = 3 PAD = '0' }|
    ) TO mapped-zi_plant.

    lv_number += 1.

  ENDLOOP.

  ENDMETHOD.



ENDCLASS.
