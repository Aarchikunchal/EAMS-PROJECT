@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PLANT
  as select from zplant as _Plant
  association to ZI_SALE_ORDER as _Order on $projection.Vbeln = _Plant.vbeln
  association to ZI_SALE_ORDER_ITEM as _Item on $projection.Vbeln = _Plant.vbeln
  association to parent ZI_MATERIAL as _Material on $projection.Matnr = _Material.Matnr
                                                 and $projection.Vbeln = _Material.Vbeln 
                                                 and $projection.Posnr = _Material.Posnr
{
  key werks as Werks,
      matnr as Matnr,
      vbeln as Vbeln,
      posnr as Posnr,
      erdat as Erdat,
      ernam as Ernam,
      name  as Name,

      _Material,
      _Order,
      _Item
}
