@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONSUMPTION OF PLANT AND LOC'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_PLANT_LOC as projection on ZI_PLANT_LOC
{
      @Consumption.valueHelpDefinition: [{
      entity:{
          name: 'zvh_plant',
          element: 'Plant'
      }
       }]
    key Plant,
    key Location,
    LocationName,
    BuildingCode,
    FloorNumber,
    Supervisior,
    Capacity
}
