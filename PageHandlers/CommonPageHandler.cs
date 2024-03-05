using Dtm.Framework.ClientSites.Web;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;

namespace KLEANPAK.PageHandlers
{
    public class CommonPageHandler : PageHandler
    {
        public const string SHIPPING_CODE = "SHIPPING";
        public const string MAIN_CODE = "KP";
        public const string SHIPPING_METHOD_CODE = "UPSShippingMethod";

        public UPSServiceShippingResult CalculateShipping(string shippingZip, string countryCode)
        {
            UPSServiceShippingResult result = null;

            using (var client = new WebClient())
            {
                try
                {
                    var serviceUrl = string.Format("https://{0}/shared/services/ups.ashx", DtmContext.Domain.Domain);
                    var bytes = client.UploadValues(serviceUrl, new System.Collections.Specialized.NameValueCollection
                    {
                        {"postalCode", shippingZip },
                        {"countryCode", countryCode }
                    });

                    var response = client.Encoding.GetString(bytes);

                    var shippingInfo = JObject.Parse(response);

                    if (shippingInfo != null)
                    {
                        var statusCode = shippingInfo.Value<string>("StatusCode");
                        if (statusCode == "1")
                        {

                            var shippingOptions = shippingInfo.Value<JArray>("ShipmentQuotes");
                            var results = new List<UPSServiceShippingResult>();
                            foreach (var option in shippingOptions)
                            {
                                results.Add(new UPSServiceShippingResult
                                {
                                    ShippingPrice = option.Value<decimal>("Total"),
                                    ShippingDesc = option.Value<string>("ServiceDescription"),
                                    ShippingSku = option.Value<string>("ServiceCode")

                                });
                            }

                            result = results.OrderBy(r => r.ShippingPrice).FirstOrDefault();
                        }

                    }
                }
                catch (WebException we)
                {
                    new SiteExceptionHandler(we);
                }
                catch (Exception ex)
                {
                    new SiteExceptionHandler(ex);
                }
            }


            return result;
        }

        public class UPSServiceShippingResult
        {
            public decimal ShippingPrice { get; set; }

            public string ShippingSku { get; set; }

            public string ShippingDesc { get; set; }
        }

    }

}