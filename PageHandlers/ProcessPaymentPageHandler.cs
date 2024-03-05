using System.Collections.Generic;
using System.Linq;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;

namespace KLEANPAK.PageHandlers
{
    public class ProcessPaymentPageHandler : CommonPageHandler
    {
        #region " Overrides... "

        public override void PostProcessPageActions()
        {

            if(DtmContext.Version == 1)
            {
                var shippingZip = Order.ShippingIsSameAsBilling ? Order.BillingZip : Order.ShippingZip;
                var shippingCountry = Order.ShippingIsSameAsBilling ? Order.BillingCountry : Order.ShippingCountry;
                var shippingResult = CalculateShipping(shippingZip, shippingCountry);

                if (shippingResult != null)
                {
                    var shippingItem = Order.Items[CommonPageHandler.SHIPPING_CODE];
                    var mainItem = Order.Items[CommonPageHandler.MAIN_CODE];
                    shippingItem.Shipping = shippingResult.ShippingPrice * mainItem.Quantity;
                    shippingItem.Description = shippingResult.ShippingDesc;
                    shippingItem.ProductSku = shippingResult.ShippingSku;
                    Order.AddOrderCode(shippingResult.ShippingDesc.Replace("UPS", string.Empty), CommonPageHandler.SHIPPING_METHOD_CODE);
                }
            }
            
        }
        #endregion
    }
}
