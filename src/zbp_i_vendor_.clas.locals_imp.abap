CLASS lhc_ZI_VENDOR_ DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_vendor_ RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_vendor_ RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_vendor_ RESULT result.

    METHODS active FOR MODIFY
      IMPORTING keys FOR ACTION zi_vendor_~active RESULT result.

    METHODS inactive FOR MODIFY
      IMPORTING keys FOR ACTION zi_vendor_~inactive RESULT result.
    METHODS setdefaultstatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_vendor_~setdefaultstatus.
    METHODS ValidateContactNumber FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_vendor_~ValidateContactNumber.
    METHODS ValidateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_vendor_~ValidateEmail.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_vendor_.

ENDCLASS.

CLASS lhc_ZI_VENDOR_ IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA: lv_max_vendor_id TYPE zeams_vendor-vendor_id,
          lv_number        TYPE i.

    SELECT SINGLE MAX( vendor_id )
      FROM zeams_vendor
      INTO @lv_max_vendor_id.

    IF lv_max_vendor_id IS INITIAL.

      lv_number = 10.  " First ID will be VI0010

    ELSE.

      TRY.
          lv_number = lv_max_vendor_id+2(4).  "Extract 0010
          lv_number = lv_number + 1.

        CATCH cx_sy_conversion_no_number.
          lv_number = 10.
      ENDTRY.

    ENDIF.

    LOOP AT entities INTO DATA(ls_entity).

      APPEND VALUE #(
        %cid     = ls_entity-%cid
        vendorid = |VI{ lv_number WIDTH = 4 PAD = '0' ALIGN = RIGHT }|
      ) TO mapped-zi_vendor_.

      lv_number += 1.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zi_vendor_
        IN LOCAL MODE
        ENTITY zi_vendor_
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_vendor).

    LOOP AT lt_vendor INTO DATA(ls_vendor).

      APPEND VALUE #(
        %tky = ls_vendor-%tky

        %action-Active =
          COND #(
            WHEN ls_vendor-Status = 'ACTIVE'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled
          )

        %action-InActive =
          COND #(
            WHEN ls_vendor-Status = 'INACTIVE'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled
          )

      ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD Active.

    MODIFY ENTITIES OF zi_vendor_
        IN LOCAL MODE
        ENTITY zi_vendor_
        UPDATE
        FIELDS ( Status )
        WITH VALUE #(
            FOR key IN keys
            (
                %tky   = key-%tky
                Status = 'ACTIVE'
            )
        ).

    READ ENTITIES OF zi_vendor_
         IN LOCAL MODE
         ENTITY zi_vendor_
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_result).

    result = VALUE #(
         FOR ls IN lt_result
         (
            %tky   = ls-%tky
            %param = ls
         )
    ).

  ENDMETHOD.


  METHOD InActive.

    MODIFY ENTITIES OF zi_vendor_
        IN LOCAL MODE
        ENTITY zi_vendor_
        UPDATE
        FIELDS ( Status )
        WITH VALUE #(
            FOR key IN keys
            (
                %tky   = key-%tky
                Status = 'INACTIVE'
            )
        ).

    READ ENTITIES OF zi_vendor_
         IN LOCAL MODE
         ENTITY zi_vendor_
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_result).

    result = VALUE #(
         FOR ls IN lt_result
         (
            %tky   = ls-%tky
            %param = ls
         )
    ).

  ENDMETHOD.
  METHOD SetDefaultStatus.
    MODIFY ENTITIES OF zi_vendor_
        IN LOCAL MODE
        ENTITY zi_vendor_
        UPDATE
        FIELDS ( Status )
        WITH VALUE #(
            FOR key IN keys
            (
               %tky   = key-%tky
               Status = 'ACTIVE'
            )
        ).

  ENDMETHOD.

  METHOD ValidateContactNumber.

    READ ENTITIES OF zi_vendor_
      IN LOCAL MODE
      ENTITY zi_vendor_
      FIELDS ( ContactNumber )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_vendor).

    LOOP AT lt_vendor INTO DATA(ls_vendor).

      DATA(lv_contact) = ls_vendor-ContactNumber.

      "Check for all zeros
      IF lv_contact = '0000000000'.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
        ) TO failed-zi_vendor_.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
          %msg = new_message(
                    id       = 'ZMSG_SERVICE'
                    number   = '007'
                    severity = if_abap_behv_message=>severity-error
                   )
          %element-ContactNumber = if_abap_behv=>mk-on
        ) TO reported-zi_vendor_.

      ENDIF.

      "Should not start with 0
      IF lv_contact+0(1) = '0'.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
        ) TO failed-zi_vendor_.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
          %msg = new_message(
                    id       = 'ZMSG_SERVICE'
                    number   = '008'
                    severity = if_abap_behv_message=>severity-error
                    v1       = 'Contact number cannot start with 0' )
          %element-ContactNumber = if_abap_behv=>mk-on
        ) TO reported-zi_vendor_.

      ENDIF.

      "Must start with 6,7,8 or 9
      IF lv_contact+0(1) NA '6789'.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
        ) TO failed-zi_vendor_.

        APPEND VALUE #(
          %tky = ls_vendor-%tky
          %msg = new_message(
                    id       = 'ZMSG_SERVICE'
                    number   = '009'
                    severity = if_abap_behv_message=>severity-error
                    v1       = 'Number must start with 6,7,8 or 9' )
          %element-ContactNumber = if_abap_behv=>mk-on
        ) TO reported-zi_vendor_.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateEmail.
    LOOP AT keys INTO DATA(ls_key).

      READ ENTITY IN LOCAL MODE zi_vendor_
        FIELDS ( Email )
         WITH VALUE #( ( %tky = ls_key-%tky ) )

         RESULT DATA(lt_vendor).

      READ TABLE lt_vendor INTO DATA(ls_vendor) INDEX 1.
      IF sy-subrc = 0.

        IF ls_vendor-Email IS INITIAL
        OR ls_vendor-Email NS '@'
        OR ls_vendor-Email NS '.'.


          APPEND VALUE #(
            %tky = ls_key-%tky
          ) TO failed-zi_vendor_.

          APPEND VALUE #(
            %tky = ls_key-%tky
            %msg = new_message(
                     id       = 'ZMSG_SERVICE'
                     number   = '010'
                     severity = if_abap_behv_message=>severity-error )
            %element-Email = if_abap_behv=>mk-on
          ) TO reported-zi_vendor_.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.



ENDCLASS.
