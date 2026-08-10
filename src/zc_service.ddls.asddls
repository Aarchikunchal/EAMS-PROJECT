@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMPTION OF SERVICE'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SERVICE as projection on ZI_SERVICE
{

    key Serviceuuid,
    ServiceId,
      @Consumption.valueHelpDefinition: [{
      entity:{
          name: 'zvh_asset_id',
          element: 'AssetId'
      }
       }]
    AssetId,
    RequestDate,
    FailureDescription,
    @Consumption.valueHelpDefinition: [
      {  entity: {
      name: 'ZVH_PRIORITY',
      element: 'priority'
      
      }} ]
    Priority,
        @Consumption.valueHelpDefinition: [
      {  entity: {
      name: 'ZVH_STATUS',
      element: 'status'
      
      }} ]
    Status,
    RequestedBy,
    @Consumption.valueHelpDefinition: [{ 
    entity:{
    name: 'ZVH_VENDORID',
    element: 'VendorId'
    }}]
    VendorId,
    RequiredService,
    DateOfCompletion,
    CreatedAt,
    CreatedBy,
    LocalLastChangedAt,
    /* Associations */
    _asset : redirected to ZC_EAMS_ASSET,
    _item : redirected to composition child zc_repair,
    _vendor : redirected to ZC_VENDOR_
}
