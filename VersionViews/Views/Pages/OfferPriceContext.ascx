<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    var product = DtmContext.CampaignProducts.Where(cp => cp.ProductTypeId == 1).FirstOrDefault();
    if (product != null)
    {
        var price = product.Price.ToString("#");
        var shipping = product.Shipping;
        var shippingDisclaimer = "Plus Shipping";

        if (shipping == 0)
        {
            shippingDisclaimer = "Free Shipping";
        }

        var offer = new ViewDataDictionary
        {
            { "label", String.Format("Now Only ${0} {1}", price, shippingDisclaimer) },
            { "standfirst", "Now Only" },
            { "dollar", price },
            { "disclaimer", shippingDisclaimer }
        };
        Html.RenderPartial("Offer", offer);
    }
%>