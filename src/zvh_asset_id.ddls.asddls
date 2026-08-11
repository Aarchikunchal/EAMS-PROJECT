@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'AssetId'
define view entity zvh_asset_id
  as select from zeams_asset
{
  key asset_id as AssetId,
  asset_name as AssetName,
  asset_status as AssetStatus

}
where asset_status <> 'RET' 
and asset_status <> 'SCR'
