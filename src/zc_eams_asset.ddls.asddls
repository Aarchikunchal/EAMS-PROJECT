@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMPTION ASSET'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_EAMS_ASSET
  as projection on ZI_EAMS_ASSET
{
  key AssetId,
      AssetName,
      @Consumption.valueHelpDefinition: [{entity:
      {name: 'ZVH_ASSET_CAT',
      element: 'AssetCategory'}}]
      AssetCategory,
      @Consumption.valueHelpDefinition: [{ entity:{
      name:'zvh_plant',
      element: 'Plant'
       }}]
      Plant,
      Department,
      @Consumption.valueHelpDefinition: [{
      entity: {
      name    : 'zvh_plant_loc',
      element : 'Location'
      },
      additionalBinding: [{
      localElement : 'Plant',
      element      : 'Plant'
      }]
      }]
      Location,
      Manufacturer,
      PurchaseDate,
      WarrentyEnd,
      @Consumption.valueHelpDefinition: [
      {  entity: {
      name: 'ZVH_ASSET_STATUS',
      element: 'AssetStatus'

      }} ]
      AssetStatus,
      @Semantics.imageUrl: true
      AssetImageUrl,
      CreatedAt,
      CreatedBy,
      LocalLastChangedAt
}
