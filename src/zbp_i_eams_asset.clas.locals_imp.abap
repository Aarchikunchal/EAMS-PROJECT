CLASS lhc_ZI_EAMS_ASSET DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_eams_asset RESULT result.
    METHODS validateassetstatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_eams_asset~validateassetstatus.
    METHODS validateassetcategory FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_eams_asset~validateassetcategory.
    METHODS setwarrentyenddate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_eams_asset~setwarrentyenddate.
    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_eams_asset~validatedates.
    METHODS validateplant FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_eams_asset~validateplant.
    METHODS validatelocation FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_eams_asset~validatelocation.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_eams_asset.

ENDCLASS.

CLASS lhc_ZI_EAMS_ASSET IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


METHOD earlynumbering_create.

  DATA: lv_max_asset_id TYPE zeams_asset-asset_id,
        lv_number       TYPE i.

  SELECT SINGLE
         MAX( asset_id )
    FROM zeams_asset
    INTO @lv_max_asset_id.

  IF lv_max_asset_id IS INITIAL.
    lv_number = 1.
  ELSE.
    TRY.
        lv_number = lv_max_asset_id+2(8).
        lv_number = lv_number + 1.
      CATCH cx_sy_conversion_no_number.
        lv_number = 1.
    ENDTRY.
  ENDIF.

  LOOP AT entities INTO DATA(ls_entity).

    APPEND VALUE #(
      %cid    = ls_entity-%cid
      AssetId = |AS{ lv_number WIDTH = 8 PAD = '0' ALIGN = RIGHT }|
    ) TO mapped-zi_eams_asset.

    lv_number += 1.

  ENDLOOP.

ENDMETHOD.


  METHOD ValidateAssetStatus.
    READ ENTITIES OF zi_eams_asset IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( AssetStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    SELECT SINGLE AssetStatus
      FROM zvh_asset_status
      WHERE AssetStatus = @ls_asset-AssetStatus
      INTO @DATA(lv_asset).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '003'
                 v1 = CONV #( ls_asset-AssetStatus )
                 severity = if_abap_behv_message=>severity-error
               )
      ) TO reported-zi_eams_asset.

    ENDIF.

  ENDLOOP.

  ENDMETHOD.

  METHOD ValidateAssetCategory.
  READ ENTITIES OF zi_eams_asset IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( AssetCategory )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    SELECT SINGLE AssetCategory
      FROM zvh_asset_cat
      WHERE AssetCategory = @ls_asset-AssetCategory
      INTO @DATA(lv_asset).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '011'
                 v1 = CONV #( ls_asset-AssetCategory )
                 severity = if_abap_behv_message=>severity-error
               )
      ) TO reported-zi_eams_asset.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD SetWarrentyEndDate.

  READ ENTITIES OF zi_eams_asset
    IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( PurchaseDate WarrentyEnd )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    IF ls_asset-PurchaseDate IS NOT INITIAL.

      DATA(lv_warranty_date) = ls_asset-PurchaseDate + 365.

      MODIFY ENTITIES OF zi_eams_asset
        IN LOCAL MODE
        ENTITY zi_eams_asset
        UPDATE FIELDS ( WarrentyEnd )
        WITH VALUE #(
          (
            %tky            = ls_asset-%tky
            WarrentyEnd = lv_warranty_date
          )
        ).

    ENDIF.

  ENDLOOP.

ENDMETHOD.

  METHOD ValidateDates.

  DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

  READ ENTITIES OF zi_eams_asset
    IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( PurchaseDate WarrentyEnd )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    "Purchase date cannot be future
    IF ls_asset-PurchaseDate > lv_today.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '012'
                 severity = if_abap_behv_message=>severity-error )
        %element-PurchaseDate = if_abap_behv=>mk-on
      ) TO reported-zi_eams_asset.

    ENDIF.

    "Warranty date should be after purchase date
    IF ls_asset-WarrentyEnd <= ls_asset-PurchaseDate.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '013'
                 severity = if_abap_behv_message=>severity-error )
        %element-WarrentyEnd = if_abap_behv=>mk-on
      ) TO reported-zi_eams_asset.

    ENDIF.

  ENDLOOP.

ENDMETHOD.

  METHOD ValidatePlant.
   READ ENTITIES OF zi_eams_asset IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( Plant )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    SELECT SINGLE Plant
      FROM zvh_plant
      WHERE Plant = @ls_asset-Plant
      INTO @DATA(lv_asset).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '014'
                 v1 = CONV #( ls_asset-Plant )
                 severity = if_abap_behv_message=>severity-error
               )
      ) TO reported-zi_eams_asset.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD ValidateLocation.
  READ ENTITIES OF zi_eams_asset IN LOCAL MODE
    ENTITY zi_eams_asset
    FIELDS ( Location )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_asset).

  LOOP AT lt_asset INTO DATA(ls_asset).

    SELECT SINGLE Location
      FROM zvh_plant_loc
      WHERE Location = @ls_asset-Location
      INTO @DATA(lv_asset).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_asset-%tky
      ) TO failed-zi_eams_asset.

      APPEND VALUE #(
        %tky = ls_asset-%tky
        %msg = new_message(
                 id       = 'ZMSG_SERVICE'
                 number   = '015'
                 v1 = CONV #( ls_asset-Location )
                 severity = if_abap_behv_message=>severity-error
               )
      ) TO reported-zi_eams_asset.

    ENDIF.

  ENDLOOP.

  ENDMETHOD.

ENDCLASS.
