@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VENDOR CONSUMPTION VIEW'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_VENDOR_ as projection on ZI_VENDOR_
{
    key VendorId,
    VendorName,
    ContactNumber,
    Email,
    ServiceType,
    Status,
    CreatedAt,
    CreatedBy,
    LocalLastChangedAt
}
