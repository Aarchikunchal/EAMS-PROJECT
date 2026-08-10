CLASS lhc_zi_repair DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS SetActivityno FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_repair~SetActivityno.
    METHODS SetActivityDone FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_repair~SetActivityDone.
    METHODS UpdateServiceStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_REPAIR~UpdateServiceStatus.

ENDCLASS.

CLASS lhc_zi_repair IMPLEMENTATION.

  METHOD SetActivityNo.

    DATA: lv_max_activityno TYPE zeams_repair-activity_no,
          lv_number         TYPE i.

    SELECT SINGLE MAX( activity_no )
      FROM zeams_repair
      INTO @lv_max_activityno.

    IF lv_max_activityno IS INITIAL.
      lv_number = 1.
    ELSE.
      lv_number = CONV i( lv_max_activityno+2 ).
      lv_number = lv_number + 1.
    ENDIF.

    LOOP AT keys INTO DATA(ls_key).

      MODIFY ENTITIES OF zi_service IN LOCAL MODE
        ENTITY zi_repair
        UPDATE FIELDS ( ActivityNo )
        WITH VALUE #(
          (
            %tky       = ls_key-%tky
            ActivityNo = |AN{ lv_number WIDTH = 4 PAD = '0' ALIGN = RIGHT }|
          )
        ).

      lv_number += 1.

    ENDLOOP.

  ENDMETHOD.

  METHOD SetActivityDone.
    READ ENTITIES OF zi_service IN LOCAL MODE
    ENTITY zi_repair
    FIELDS ( ActivityDone )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_repair).

    LOOP AT lt_repair INTO DATA(ls_repair).

      SELECT SINGLE value_low
        FROM ddcds_customer_domain_value_t(
               p_domain_name = 'ZDM_REPAIR_DONE' )
        WHERE value_low = @ls_repair-ActivityDone
        INTO @DATA(lv_value).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_repair-%tky
        ) TO failed-zi_repair.

        APPEND VALUE #(
          %tky = ls_repair-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '006'
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_repair.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD UpdateServiceStatus.

  READ ENTITIES OF zi_service IN LOCAL MODE
    ENTITY zi_repair
    FIELDS ( Serviceuuid ActivityDone )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_activity).

  LOOP AT lt_activity INTO DATA(ls_activity).

    "If Activity Done = YES
    IF ls_activity-ActivityDone = 'YES'.

      MODIFY ENTITIES OF zi_service IN LOCAL MODE
        ENTITY zi_service
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %key-Serviceuuid = ls_activity-Serviceuuid
            Status    = 'COMP'
          )
        ).

    ELSE.

      "Activity exists but not completed
      MODIFY ENTITIES OF zi_service IN LOCAL MODE
        ENTITY zi_service
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %key-Serviceuuid = ls_activity-Serviceuuid
            Status    = 'INPR'
          )
        ).

    ENDIF.

  ENDLOOP.

ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_SERVICE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_service RESULT result.
    METHODS setserviceid FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_service~setserviceid.
    METHODS SetDefaultDates FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_service~SetDefaultDates.
    METHODS ValidatePriority FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_service~ValidatePriority.
    METHODS ValidateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_service~ValidateStatus.
    METHODS ValidateAssetId FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_service~ValidateAssetId.
    METHODS ValidateVendorId FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_service~ValidateVendorId.
    METHODS SetRequiredService FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_service~SetRequiredService.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_service RESULT result.

    METHODS OPEN FOR MODIFY
      IMPORTING keys FOR ACTION zi_service~OPEN RESULT result.

    METHODS INPROGRESS FOR MODIFY
      IMPORTING keys FOR ACTION zi_service~INPROGRESS RESULT result.

    METHODS COMPLETED FOR MODIFY
      IMPORTING keys FOR ACTION zi_service~COMPLETED RESULT result.
    METHODS ValidateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_service~ValidateDates.
    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_service~SetInitialStatus.




ENDCLASS.

CLASS lhc_ZI_SERVICE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD SetServiceId.

    DATA: lv_max_serviceid TYPE zeams_service-service_id,
          lv_number        TYPE i.

    SELECT SINGLE MAX( service_id )
      FROM zeams_service
      INTO @lv_max_serviceid.

    IF lv_max_serviceid IS INITIAL.
      lv_number = 1.
    ELSE.

      TRY.
          lv_number = lv_max_serviceid+2(4).
          lv_number = lv_number + 1.
        CATCH cx_sy_conversion_no_number.
          lv_number = 1.
      ENDTRY.

    ENDIF.

    LOOP AT keys INTO DATA(ls_key).

      MODIFY ENTITIES OF zi_service IN LOCAL MODE
        ENTITY zi_service
        UPDATE FIELDS ( ServiceId )
        WITH VALUE #(
          (
            %tky      = ls_key-%tky
            ServiceId = |SI{ lv_number WIDTH = 4 PAD = '0' ALIGN = RIGHT }|
          )
        ).

      lv_number += 1.

    ENDLOOP.

  ENDMETHOD.


  METHOD SetDefaultDates.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( RequestDate Priority )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    MODIFY ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      UPDATE FIELDS ( DateOfCompletion )
      WITH VALUE #(

        FOR ls_service IN lt_service

        (
          %tky = ls_service-%tky

          DateOfCompletion =
            COND d(

              WHEN ls_service-Priority = 'HIGH'
                THEN ls_service-RequestDate + 5

              WHEN ls_service-Priority = 'MEDIUM'
                THEN ls_service-RequestDate + 10

              WHEN ls_service-Priority = 'LOW'
                THEN ls_service-RequestDate + 15

              ELSE ls_service-RequestDate

            )
        )

      ).

  ENDMETHOD.



  METHOD ValidatePriority.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( Priority )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    LOOP AT lt_service INTO DATA(ls_service).

      SELECT SINGLE value_low
        FROM ddcds_customer_domain_value_t(
               p_domain_name = 'ZDM_SERVICE_PRIORITY' )
        WHERE value_low = @ls_service-priority
        INTO @DATA(lv_value).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.

        APPEND VALUE #(
          %tky = ls_service-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '002'
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_service.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateStatus.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    LOOP AT lt_service INTO DATA(ls_service).

      SELECT SINGLE status
        FROM zvh_status
        WHERE status = @ls_service-Status
        INTO @DATA(lv_status).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.

        APPEND VALUE #(
          %tky = ls_service-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '003'
                   v1 = CONV #( ls_service-Status )
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_service.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD ValidateAssetId.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( AssetId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    LOOP AT lt_service INTO DATA(ls_service).

      SELECT SINGLE asset_id, asset_status
        FROM zeams_asset
        WHERE asset_id = @ls_service-AssetId
        INTO @DATA(lv_asset).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.

        APPEND VALUE #(
          %tky = ls_service-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '004'
                   v1       = CONV #( ls_service-AssetId )
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_service.

      ELSEIF lv_asset-asset_status <> 'IU'
      AND lv_asset-asset_status <> 'NIU'
      AND lv_asset-asset_status <> 'RET'.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.
        APPEND VALUE #(
  %tky = ls_service-%tky
  %msg = new_message(
           id       = 'ZMSG_SERVICE'
           number   = '016'
           v1       = CONV #( ls_service-AssetId )
           severity = if_abap_behv_message=>severity-error
         )
) TO reported-zi_service.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



  METHOD ValidateVendorId.
    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( VendorId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    LOOP AT lt_service INTO DATA(ls_service).

      SELECT SINGLE vendor_id
        FROM zeams_vendor
        WHERE vendor_id = @ls_service-VendorId
        INTO @DATA(lv_vendorid).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.

        APPEND VALUE #(
          %tky = ls_service-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '004'
                   v1       = CONV #( ls_service-VendorId )
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_service.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD SetRequiredService.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( VendorId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    DATA lt_update TYPE TABLE FOR UPDATE zi_service.

    LOOP AT lt_service INTO DATA(ls_service).

      SELECT SINGLE service_type
        FROM zeams_vendor
        WHERE vendor_id = @ls_service-VendorId
        INTO @DATA(lv_service_type).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky            = ls_service-%tky
          RequiredService = lv_service_type
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zi_service IN LOCAL MODE
        ENTITY zi_service
        UPDATE FIELDS ( RequiredService )
        WITH lt_update.

    ENDIF.

  ENDMETHOD.



  METHOD get_instance_features.
    READ ENTITIES OF zi_service
      ENTITY zi_service
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    LOOP AT lt_service INTO DATA(ls_service).

      APPEND VALUE #(
        %tky = ls_service-%tky

        %action-OPEN =
          COND #(
            WHEN 1 = 1
            THEN if_abap_behv=>fc-o-disabled

          )

        %action-INPROGRESS =
          COND #(
            WHEN ls_service-Status = 'OPEN'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled
          )
             %action-COMPLETED =
          COND #(
            WHEN ls_service-Status = 'OPEN'
            OR ls_service-Status = 'INPR'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled
          )


      ) TO result.

    ENDLOOP.
  ENDMETHOD.

  METHOD OPEN.

    MODIFY ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'OPEN'
        )
      ).

  ENDMETHOD.


  METHOD INPROGRESS.

    MODIFY ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'INPR'
        )
      ).

  ENDMETHOD.

  METHOD COMPLETED.

    MODIFY ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'COMP'
        )
      ).

  ENDMETHOD.


  METHOD ValidateDates.

    READ ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      FIELDS ( RequestDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_service).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_service INTO DATA(ls_service).

      IF ls_service-RequestDate > lv_today.

        APPEND VALUE #(
          %tky = ls_service-%tky
        ) TO failed-zi_service.

        APPEND VALUE #(
          %tky = ls_service-%tky
          %msg = new_message(
                   id       = 'ZMSG_SERVICE'
                   number   = '001'
                   severity = if_abap_behv_message=>severity-error
                 )
        ) TO reported-zi_service.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD SetInitialStatus.

    MODIFY ENTITIES OF zi_service IN LOCAL MODE
      ENTITY zi_service
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky   = key-%tky
          Status = 'OPEN'
        )
      ).

  ENDMETHOD.

ENDCLASS.
