@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity zvh_plant_loc
 as select from zeams_plant_loc
  {
 key plant as Plant,
 key location as Location,
 location_name as LocationNumber,
 floor_number as FloorNumber,
 building_code as BuildingCode,
 capacity as Capacity,
 supervisior as Supervisior
 
   }
