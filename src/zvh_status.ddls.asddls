@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZVH_STATUS
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name: 'ZDM_ASSET_STATUS_'
  )
{
  key value_low as status,
 
  @Semantics.text: true
  text as statusText
}
