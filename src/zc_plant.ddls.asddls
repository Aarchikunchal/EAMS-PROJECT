@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_Plant
  as projection on ZI_PLANT
{
  key Werks,
      Matnr,
      Vbeln,
      Posnr,
      Erdat,
      Ernam,
      Name,

      /* Associations */
      _Item     : redirected to ZC_SALE_ORDER_ITEM,
      _Material : redirected to parent ZC_MATERIAL,
      _Order    : redirected to ZC_SALE_ORDER
}
