@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption of plant'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_PLANT_1 as projection on zi_plant_1
{  
     @Consumption.valueHelpDefinition: [{
      entity:{
          name: 'zvh_plant',
          element: 'Plant'
      }
       }]
    key Plant,
    PlantName,
    PlantType,
    State,
    City,
    PlantManager,
    CreatedAt,
    CreatedBy,
    LocalLastChangedAt
}
