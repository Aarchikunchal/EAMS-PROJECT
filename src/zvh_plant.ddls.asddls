@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'Plant'
define view entity zvh_plant
  as select from zeams_plant
{
  key plant as Plant,
  plant_name as PlantName
}
