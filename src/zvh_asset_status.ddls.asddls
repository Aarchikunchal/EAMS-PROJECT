@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZVH_ASSET_STATUS
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name: 'ZDM_ASSET_STATUS_1'
  )
{
  key value_low as AssetStatus,
 
  @Semantics.text: true
  text as statusText
}
 