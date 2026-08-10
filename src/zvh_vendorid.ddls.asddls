@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'VendorId'
define view entity zvh_vendorid
as select from zeams_vendor
{
key vendor_id as VendorId,
vendor_name as VendorName
}
where status = 'ACTIVE'
