@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE PLANT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zi_plant_1 as select from zeams_plant

{
    key plant as Plant,
    plant_name as plant_name,
    plant_type as plant_type,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt
    
}
