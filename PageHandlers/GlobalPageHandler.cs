using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;
using Dtm.Framework.Models.Ecommerce;
using Newtonsoft.Json.Linq;

namespace KLEANPAK.PageHandlers
{
    public class GlobalPageHandler : CommonPageHandler
    {

        #region " Overrides... "

        public override void PostValidate(ModelStateDictionary modelState)
        {
            if (DtmContext.Page.IsStartPageType && DtmContext.Version == 1)
            {
                var shippingSku = Form["UPSShippingSku"] ?? string.Empty;
                var shippingPriceStr = Form["UPSShippingPrice"] ?? string.Empty;
                var shippingDesc = Form["UPSShippingDesc"] ?? string.Empty;
                decimal shippingPrice = 0;

                if (string.IsNullOrEmpty(shippingSku) || string.IsNullOrEmpty(shippingDesc) || !decimal.TryParse(shippingPriceStr, out shippingPrice))
                {
                    modelState.AddModelError("Form", "There was a problem calculating your shipping price, please re-enter your zip code and try again.");
                }
            }
        }
        public override void PostSetOrderStatus()
        {
            if (DtmContext.Version == 3)
            {
                Order.OrderStatusId = 11;
            }
            if (DtmContext.Version == 2)
            {
                var formType = Form["FormType"] ?? null;

                if(formType == "Lead")
                {
                    Order.OrderStatusId = 11;
                }
            }
        }
        public override void PostProcessPageActions()
        {
            if (DtmContext.Page.IsStartPageType && DtmContext.Version == 1)
            {
                Trace.WriteLine("Processing post page actions...");

                var isCartPost = Form.AllKeys.ToList().Any(k => k.Contains("param_"));
                SetShippingPrice(isCartPost);
            }

            var formType = Form["FormType"] ?? null;
            var isLead = false;

            if (formType == "Lead")
            {
                isLead = true;
            }

            if (DtmContext.Page.IsStartPageType && (DtmContext.Version == 3 || (DtmContext.Version == 2 && isLead)) && !DtmContext.Order.VisitorSession.IsTestSession)
            {

                var toEmailAddress = new[] { "klean-pak@tft.com" };
                var bccEmailAddress = new[] { "jwright@digitaltargetmarketing.com" };
                var fromEmail = "noreply@digitaltargetmarketing.com";
                var subject = "Klean Pak Leads";
                var body = string.Format(@"<html>
                                        <head>
	                                        <title>Klean Pak Leads</title>
                                        </head>
                                        <body>
                                        <table width='700' border='0' cellspacing='0' cellpadding='0' bgcolor='#ffffff'>
                                        <tr>
                                        <td align='left' style='font-family: Helvetica, Arial, sans-serif;'>
                                        <p>First Name: {0}</p>
                                        <p>Last Name: {1}</p>
                                        <p>Company: {2}</p>
                                        <p>Phone: {3}</p>
                                        <p>Email: {4}</p>
                         
                                        </td>
                                        </tr>
                                        </table>
                                        </body>
                                   </html>", Order.BillingFirstName, Order.BillingLastName, Order.OrderCodes.Where(x => x.Label == "Company").Select(y => y.Code).FirstOrDefault(), Order.Phone, Order.Email);

                Send(toEmailAddress, new string[0], bccEmailAddress, new string[0], fromEmail, subject, body);
                Order.ConfirmationEmailSent = true;

                
            }
        }


        private void SetShippingPrice(bool isCartPost = false)
        {
            var prefix = isCartPost ? "param_" : string.Empty;
            var shippingSku = Form[prefix + "UPSShippingSku"] ?? string.Empty;
            var shippingPriceStr = Form[prefix + "UPSShippingPrice"] ?? string.Empty;
            var shippingDesc = Form[prefix + "UPSShippingDesc"] ?? string.Empty;
            decimal shippingPrice = 0;

            if (!isCartPost)
            {
                var upsShippingZip = Form["UPSShippingZip"] ?? string.Empty;
                var orderShipZip = Order.ShippingIsSameAsBilling ? Order.BillingZip : Order.ShippingZip;
                if (!string.IsNullOrWhiteSpace(orderShipZip) && !string.IsNullOrWhiteSpace(upsShippingZip) && !string.Equals(upsShippingZip, orderShipZip, StringComparison.InvariantCultureIgnoreCase))
                {
                    var shippingResult = CalculateShipping(orderShipZip, Order.ShippingIsSameAsBilling ? Order.BillingCountry : Order.ShippingCountry);

                    if (shippingResult != null)
                    {
                        shippingSku = shippingResult.ShippingSku;
                        shippingDesc = shippingResult.ShippingDesc;
                        shippingPriceStr = shippingResult.ShippingPrice.ToString();
                    }
                }
            }

            if (!string.IsNullOrEmpty(shippingSku) && !string.IsNullOrEmpty(shippingDesc) && decimal.TryParse(shippingPriceStr, out shippingPrice))
            {

                OrderManager.SetProductQuantity(CommonPageHandler.SHIPPING_CODE, 1);
                if (isCartPost)
                {
                    var item = DtmContext.ShoppingCart[CommonPageHandler.SHIPPING_CODE];
                    item.Shipping = shippingPrice * DtmContext.ShoppingCart[CommonPageHandler.MAIN_CODE].Quantity;
                    item.CampaignProduct.ProductName = shippingDesc;
                    item.ProductSku = shippingSku;
                }
                else
                {
                    var item = Order.OrderItems.Where(oi => string.Equals(oi.CachedProductInfo.ProductCode, CommonPageHandler.SHIPPING_CODE, System.StringComparison.InvariantCultureIgnoreCase)).FirstOrDefault();
                    item.Shipping = shippingPrice * Order.Items[CommonPageHandler.MAIN_CODE].Quantity;
                    item.Description = shippingDesc;
                    item.ProductSku = shippingSku;
                    Order.AddOrderCode(shippingDesc.Replace("UPS", string.Empty), CommonPageHandler.SHIPPING_METHOD_CODE);
                }
            }
        }
        public bool Send(string[] toEmailAddresses, string[] ccEmailAddresses, string[] bccEmailAddresses, string[] replyToAddresses, string fromEmailAddress, string subject, string body)
        {
            var message = new MailMessage
            {
                Subject = subject,
                BodyEncoding = Encoding.UTF8,
                IsBodyHtml = true,
                Body = body,
                From = new MailAddress(fromEmailAddress)
            };

            AddAddresses(message.Bcc, bccEmailAddresses);
            AddAddresses(message.To, toEmailAddresses);
            AddAddresses(message.ReplyToList, replyToAddresses);

            var client = new SmtpClient { Host = ConfigurationManager.AppSettings["SMTPServer"] };
            try
            {
                client.Send(message);
                return true;
            }
            catch (Exception ex)
            {
                new SiteExceptionHandler("Error Sending Email: " + ex);
            }
            return false;
        }

        private void AddAddresses(MailAddressCollection collection, IEnumerable<string> addresses)
        {
            foreach (var emailAddress in addresses)
            {
                if (!string.IsNullOrWhiteSpace(emailAddress))
                {
                    collection.Add(emailAddress);
                }
            }
        }

        #endregion
    }
}
