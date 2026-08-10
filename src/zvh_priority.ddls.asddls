@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZVH_PRIORITY
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name: 'ZDM_SERVICE_PRIORITY'
  )
{
  key value_low as priority,
  @Semantics.text: true
  text as prioritytext
}
