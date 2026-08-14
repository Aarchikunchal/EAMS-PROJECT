@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE PLANT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zi_plant_1 as select from zeams_plant

{
    key plant as Plant,
    plant_name as PlantName,
    plant_type as PlantType,
    state as State,
    city as City,
    plant_manager as PlantManager,
    created_at as CreatedAt,
    created_by as CreatedBy,
    local_last_changed_at as LocalLastChangedAt
    
    
}
