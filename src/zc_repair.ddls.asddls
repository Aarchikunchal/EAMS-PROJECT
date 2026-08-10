@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMPTION OF REPAIR'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_repair
  as projection on ZI_REPAIR
{
  key Serviceuuid,
  key Activityuuid,
      ActivityNo,
      ActivityDate,
      @Consumption.valueHelpDefinition: [{
         entity: {
         name: 'ZVH_ACTIVITY_DONE',
         element: 'ActivityDone'}}]
      ActivityDone,
      Remark,
      CreatedAt,
      CreatedBy,
      LocalLastChangedAt,
      /* Associations */
      _header : redirected to parent ZC_SERVICE
}
