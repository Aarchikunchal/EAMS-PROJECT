@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity zvh_asset_cat
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T
                 ( p_domain_name: 'ZDM_ASSET_CATEGORY' )
{
  key value_low as AssetCategory,
      @Semantics.text: true
      text      as AssetCategoryText
}
