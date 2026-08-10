@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PLANT LOC CDS VIEW'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_PLANT_LOC 
as select from zeams_plant_loc
{

    key plant as Plant,
    key location as Location
}
