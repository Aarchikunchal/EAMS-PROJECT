@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE VIEW FOR VENDOR'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_VENDOR_ as select from zeams_vendor

{
    key vendor_id as VendorId,
    vendor_name as VendorName,
    contact_number as ContactNumber,
    email as Email,
    service_type as ServiceType,
    status as Status,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt
 
}
