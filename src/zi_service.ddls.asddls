@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE VIEW OF SERVICE'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_SERVICE as select from zeams_service
composition[1..*] of ZI_REPAIR as _item 
association to ZI_VENDOR_ as _vendor on $projection.VendorId =_vendor.VendorId
association to ZI_EAMS_ASSET as _asset on $projection.AssetId = _asset.AssetId
{   
   key service_uuid as Serviceuuid,
    service_id as ServiceId,
    asset_id as AssetId,
    request_date as RequestDate,
    failure_description as FailureDescription,
    priority as Priority,
    status as Status,
    requested_by as RequestedBy,
    vendor_id as VendorId,
    required_service as RequiredService,
    date_of_completion as DateOfCompletion,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt,
    _item ,
    _vendor,
    _asset,
    _asset.AssetImageUrl as AssetImageUrl
}
