@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE ASSET'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_EAMS_ASSET as select from zeams_asset
{
    key asset_id as AssetId,
    asset_name as AssetName,
    asset_category as AssetCategory,
    plant as Plant,
    department as Department,
    location as Location,
    manufacturer as Manufacturer,
    purchase_date as PurchaseDate,
    warrenty_end as WarrentyEnd,
    asset_status as AssetStatus,
    asset_image_url as AssetImageUrl,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt
  }
