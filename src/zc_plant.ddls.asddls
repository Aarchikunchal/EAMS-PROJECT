@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMPTION VIEW OF PLANT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_PLANT as projection on ZI_PLANT
{
 @Consumption.valueHelpDefinition: [{
      entity:{
          name: 'zvh_plant',
          element: 'Plant'
      }
       }]
    key Plant,
    plant_name,
    plant_type,
    CreatedAt,
    CreatedBy,
    LocalLastChangedAt
}
