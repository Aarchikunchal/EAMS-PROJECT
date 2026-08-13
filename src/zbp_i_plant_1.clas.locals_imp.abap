CLASS lhc_ZI_PLANT_1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_plant_1 RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_plant_1.

ENDCLASS.

CLASS lhc_ZI_PLANT_1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

  DATA: lv_max_plant TYPE zeams_plant-plant,
        lv_number    TYPE i.

  " Get highest existing Plant ID
  SELECT SINGLE MAX( plant )
    FROM zeams_plant
    INTO @lv_max_plant.

  IF lv_max_plant IS INITIAL.

    " First record
    lv_number = 100.

  ELSE.

    TRY.

        " Convert P100 -> 100
        lv_number = CONV i( lv_max_plant+1 ).

        " Next Number
        lv_number = lv_number + 1.

      CATCH cx_sy_conversion_no_number.

        lv_number = 100.

    ENDTRY.

  ENDIF.

  LOOP AT entities INTO DATA(ls_entity).

    APPEND VALUE #(
      %cid  = ls_entity-%cid
      plant = |P{ lv_number WIDTH = 3 PAD = '0' }|
    ) TO mapped-zi_plant_1.

    lv_number = lv_number + 1.

  ENDLOOP.

ENDMETHOD.


ENDCLASS.
