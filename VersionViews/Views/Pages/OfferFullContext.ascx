<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div class="group group--price">
    <%= Html.Partial("OfferPriceContext") %>
    <div class="group group--payment">
        <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-main" } }) %>
        <%= Html.Partial("GetPaymentIcons") %>
        <em>
            <span>Backed by our</span> 
            <span>one-year limited warranty</span>
        </em>
    </div>
</div>