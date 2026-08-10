@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS

define view entity zvh_activity_done
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
   p_domain_name : 'ZDM_REPAIR_DONE' )
{

 key value_low as ActivityDone,
 text as activitydonetext
}
