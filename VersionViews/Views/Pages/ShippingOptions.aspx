<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<Dtm.Framework.ClientSites.Web.ClientSiteViewData>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="c-brand--form form">
    <%Html.BeginForm(); %>

    <div class="hide">
        <input type="hidden" name="BillingZip" id="BillingZip" value="<%=Model.Order.BillingZip %>" />
        <input type="hidden" name="ShippingZip" id="ShippingZip" value="<%=Model.Order.ShippingZip %>" />
        <input type="hidden" name="BillingCountry" id="BillingCountry" value="<%=Model.Order.BillingCountry %>" />
        <input type="hidden" name="ShippingCountry" id="ShippingCountry" value="<%=Model.Order.ShippingCountry %>" />
        <input type="checkbox" name="ShippingIsDifferentThanBilling" id="ShippingIsDifferentThanBilling"
            <%if (!Model.Order.ShippingIsSameAsBilling)
            { %> checked <%} %> />
    </div>

    <div class="group group--form">
        <div class="form__item">
            <div class="form__scroll"> 
                <%=Html.Partial("UPSShippingOptions") %>
            </div>
         </div>

        <div class="form__item form__review">
            <div class="form__scroll">
                <%= Html.Partial("SummaryReview") %>
            </div>
        </div>

        <div class="group__row">
            <button id="AcceptOfferButton" name="acceptOffer" type="submit" class="button button--order u-mar--center">
                Process Order
            </button>
        </div>
    </div>

    <%Html.EndForm(); %>
</div>

</asp:Content>
