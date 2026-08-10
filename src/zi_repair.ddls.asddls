@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'REPAIR INTERFACE'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZI_REPAIR  as select from zeams_repair
 association to parent ZI_SERVICE as _header
  on $projection.Serviceuuid = _header.Serviceuuid
{
    key service_uuid  as Serviceuuid,
    key activity_uuid as Activityuuid,
    activity_no as ActivityNo,
    activity_date as ActivityDate,
    activity_done as ActivityDone,
    remark as Remark,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt,
    _header
}
