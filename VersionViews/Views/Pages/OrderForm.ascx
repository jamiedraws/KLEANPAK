<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% var productName = SettingsManager.ContextSettings["Label.ProductName"]; %>
<div class="c-brand--form form">
    <div id="vse-error" class="view__anchor"></div>
	<% using (Html.BeginForm()) { %>

        <% var renderOfferDetailsAboveAcceptOffer = SettingsManager.ContextSettings["Order.RenderOfferDetailsAboveAcceptOffer", false]; %>

        <div class="group">

            <div class="group__row">
                <div class="vse" data-vse-scroll><%= Html.ValidationSummary("The following errors have occurred:") %></div>
 
                <p data-required class="u-mar--bottom fn--center"><%= LabelsManager.Labels["RequiredFieldDisclaimer"] %></p>
        
                <!-- // BEGIN #productSelection -->
                <fieldset class="form__fieldset" id="productSelection">

                    <div class="c-brand--form__legend width-at-100">
                        <h3 class="c-brand--form__headline">
                            Select Your Quantity
                        </h3>
                    </div>

                    <div class="form__group">
                        <%-- Html.RenderSnippet("PRODUCTSELECTION"); --%>
                        <div class="group group--form-product">
                            <div class="picture picture--form-product">
                                <picture class="picture__img" style="--arp:243/208;--arp-max:243px" data-src-img="/images/1.0000/product.jpg" data-src-attr='{ "alt" : "<%= productName %>" }'>
                                    <noscript>
                                        <img src="/images/1.0000/product.jpg" alt="<%= productName %>">
                                    </noscript>
                                </picture>
                            </div>
                            <%= Html.Partial("OfferPriceContext") %>
                            <div class="form__copy">
                                <p><strong>How many <%= productName %> Portable Disinfection Systems would you like?</strong></p>

                                <!-- // Qty Option -->
                                <label class="row-to-center">
                                    <span class="col">
                                        <p class="no-margin" data-required>Qty:</p>
                                    </span>
                                    <span class="col left-right-padding">
                                        <select id="ActionQuantity0" name="ActionQuantity0">
                                          <option value="1">1</option>
                                          <option value="2">2</option>
                                          <option value="3">3</option>
                                          <option value="4">4</option>
                                          <option value="5">5</option>
                                          <option value="6">6</option>
                                          <option value="7">7</option>
                                          <option value="8">8</option>
                                          <option value="9">9</option>
                                          <option value="10">10</option>
                                          <option value="11">11</option>
                                          <option value="12">12</option>
                                          <option value="13">13</option>
                                          <option value="14">14</option>
                                          <option value="15">15</option>
                                          <option value="16">16</option>
                                        </select>
                                    <input id="ActionCode0" name="ActionCode0" type="hidden" value="KP">
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>

                </fieldset>
                <!-- // END #productSelection -->

            </div>

            <div class="group__row group group--form">
                <div class="form__item">
    
                    <div class="form__scroll">
                        <%-- // BEGIN #paymentForm --%>
                        <fieldset id="paymentForm" class="form__fieldset">
        
                            <%-- // @PAYMENT HEADLINE --%>
                            <div class="c-brand--form__legend u-vw--100">
                                <h3 class="c-brand--form__headline">
                                    <%= LabelsManager.Labels["PaymentHeadline"] %>
                                </h3>
                            </div>
        
                            <div class="form__group form__payment">
                                <ul class="form__list">
        
                                    <%-- // @PAYMENT ICONS --%>
                                    <li class="c-brand--form__item o-grid--vert--center u-vw--100">
                                        <div id="cc" class="c-brand--form__field o-grid__col @xs-u-bs--reset @xs-u-vw--100"></div>
                                    </li>
        
                                    <%-- // @PAYMENT TYPE --%>
                                    <li id="CardTypeCt" class="c-brand--form__item o-grid--vert--center u-vw--100">
                                        <label for="CardType" data-required class="c-brand--form__label">Type</label>
                                        <%= Html.DropDownList("CardType", new[]
                                                {
                                                new SelectListItem { Text = "Visa", Value = "V"},
                                                new SelectListItem { Text = "Mastercard", Value = "M"},
                                                new SelectListItem { Text = "Discover", Value = "D"},
                                                new SelectListItem { Text = "American Express", Value= "AX"}
                                            }, new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" })
                                        %>
                                    </li>
        
                                    <%-- // @PAYMENT NUMBER --%>
                                    <li id="CardNumberCt" class="c-brand--form__item o-grid--vert--center u-vw--100">
                                        <label id="CardNumberLabel" for="CardNumber" data-required class="c-brand--form__label o-grid__col @mv-u-vw--40 @dv-fn--right"><%= LabelsManager.Labels["CardNumber"] %></label>
                                        <input id="CardNumber" name="CardNumber" type="tel" value="<%= ViewData["CardNumber"] %>" placeholder="<%= LabelsManager.Labels["CardNumberPlaceholder"] %>" aria-labelledby="CardNumberLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @mv-u-vw--100 fx--animate">
                                    </li>
        
                                    <%-- // @PAYMENT EXP. DATE --%>
                                    <li id="CardExpirationCt" class="c-brand--form__item o-grid--vert--center u-vw--100">
                                        <label for="CardExpirationMonth" data-required class="c-brand--form__label o-grid__col @mv-u-vw--40 @dv-fn--right"><%= LabelsManager.Labels["ExpirationDate"] %></label>
                                        <div class="c-brand--form__field o-grid u-bs--reset">
                                            <div class="u-vw--50 u-pad--right">
                                                <%= Html.CardExpirationMonth("CardExpirationMonth", new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" }) %>
                                            </div>
                                            <div class="u-vw--50 u-pad--left">
                                                <%= Html.NumericDropDown("CardExpirationYear", DateTime.Now.Year, DateTime.Now.Year + 10, ViewData["CardExpirationYear"], new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" }) %>
                                            </div>
                                        </div>
                                    </li>
        
                                    <%-- // @PAYMENT CVV2 --%>
                                    <li id="CardCvv2Ct" class="c-brand--form__item o-grid--vert--center u-vw--100">
                                        <label id="CardCvv2Label" for="CardCvv2" data-required class="c-brand--form__label o-grid__col @mv-u-vw--40 @dv-fn--right"><%= LabelsManager.Labels["CVV2"] %></label>
                                        <div class="c-brand--form__field o-grid u-bs--reset">
                                            <div class="u-vw--50 u-bs--reset u-pad--right">
                                                <input id="CardCvv2" name="CardCvv2" type="tel" value="<%= ViewData["CardCvv2"] %>" maxlength="5" placeholder="<%= LabelsManager.Labels["CVV2Placeholder"] %>" aria-labelledby="CardCvv2Label" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                                            </div>
                                            <div class="u-vw--50 u-bs--reset u-pad--left">
                                                <a href="<%= LabelsManager.Labels["CVV2DisclaimerLink"] %>" title="<%= LabelsManager.Labels["CVV2DisclaimerLinkTitle"] %>" id="cvv2" class="c-brand--form__hint o-grid__col @xs-u-vw--100 u-pad u-push--left has-fancybox fancybox.ajax"><%= LabelsManager.Labels["CVV2Disclaimer"] %></a>
                                            </div>
                                        </div>
                                    </li>
        
                                </ul>
                            </div>
        
                        </fieldset>
                        <%-- // END #paymentForm --%>

                        <div class="form__fieldset" id="billingInformation">
        
                            <%-- // @BILLING HEADLINE --%>
                            <div class="c-brand--form__legend u-vw--100">
                                <h3 class="c-brand--form__headline">
                                    <%= LabelsManager.Labels["BillingHeadline"] %>
                                </h3>
                            </div>
        
                            <div class="form__group form__billing">
        
                            <%-- // BEGIN #billingInformation --%>
                            <fieldset>
                            <ul class="form__list">
        
                                <%-- // @BILLING FULL NAME --%>
                                <li id="BillingFullNameCt" class="form__field">
                                    <label id="BillingFullNameLabel" for="BillingFullName" data-required class="c-brand--form__label"><%= LabelsManager.Labels["FullName"] %></label>
                                    <input id="BillingFullName" maxlength="50" name="BillingFullName" type="text" value="<%= ViewData["BillingFullName"] %>" placeholder="<%= LabelsManager.Labels["FullNamePlaceholder"] %>" aria-labelledby="BillingFullNameLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <%-- // @BILLING STREET --%>
                                <li id="BillingStreetCt" class="form__field">
                                    <label id="BillingStreetLabel" for="BillingStreet" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Address"] %></label>
                                    <div class=" @xs-u-bs--reset fld">
                                        <input id="BillingStreet" name="BillingStreet" type="text" value="<%= ViewData["BillingStreet"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["AddressPlaceholder"] %>" aria-labelledby="BillingStreetLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </div>
                                </li>
        
                                <%-- // @BILLING STREET 2 --%>
                                <li id="BillingStreet2Ct" class="form__field">
                                    <label id="BillingStreet2Label" for="BillingStreet2" class="c-brand--form__label"><%= LabelsManager.Labels["Address2"] %></label>
                                    <input id="BillingStreet2" name="BillingStreet2" type="text" value="<%= ViewData["BillingStreet2"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["Address2Placeholder"] %>" aria-labelledby="BillingStreet2Label" aria-required="false" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <%-- // @BILLING CITY --%>
                                <li id="BillingCityCt" class="form__field">
                                    <label id="BillingCityLabel" for="BillingCity" data-required class="c-brand--form__label"><%= LabelsManager.Labels["City"] %></label>
                                    <input id="BillingCity" name="BillingCity" type="text" value="<%= ViewData["BillingCity"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["CityPlaceholder"] %>" aria-labelledby="BillingCityLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <%-- // @BILLING COUNTRY --%>
                                <li id="BillingCountryCt" class="form__field">
                                    <label id="BillingCountryLabel" for="BillingCountry" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Country"] %></label>
                                    <%= Html.DropDownListFor(m => m.BillingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName"), LabelsManager.Labels["CountryPlaceholder"], new { @class = "c-brand--form__select o-box o-shadow @xs-u-vw--100 fx--animate" }) %>
                                </li>
        
                                <%-- // @BILLING STATE --%>
                                <li id="BillingStateCt" class="form__field">
                                    <label id="BillingStateLabel" for="BillingState" data-required class="c-brand--form__label"><%= LabelsManager.Labels["State"] %></label>
                                    <%= Html.DropDownListFor(m => m.BillingState, new SelectList(Model.States, "StateCode", "StateName"), LabelsManager.Labels["StatePlaceholder"], new { @class = "c-brand--form__select o-box o-shadow @xs-u-vw--100 fx--animate" }) %>
                                </li>
        
                                <%-- // @BILLING ZIP --%>
                                <li id="BillingZipCt" class="form__field">
                                    <label id="BillingZipLabel" for="BillingZip" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Zip"] %></label>
                                    <input id="BillingZip" name="BillingZip" type="tel" value="<%= ViewData["BillingZip"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["ZipPlaceholder"] %>" aria-labelledby="BillingZipLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <%-- // @PHONE --%>
                                <li id="PhoneCt" class="form__field">
                                    <label id="PhoneLabel" for="Phone" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Phone"] %></label>
                                    <input id="Phone" name="Phone" type="tel" value="<%= ViewData["Phone"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["PhonePlaceholder"] %>" aria-labelledby="PhoneLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <%-- // @EMAIL --%>
                                <li id="EmailCt" class="form__field">
                                    <label id="EmailLabel" for="Email" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Email"] %></label>
                                    <input id="Email" name="Email" type="email" value="<%= ViewData["Email"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["EmailPlaceholder"] %>" aria-labelledby="EmailLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                </li>
        
                                <% if ( SettingsManager.ContextSettings["OrderFormReview.ShowPrivacyPolicy", false] ) { %>
                                <%-- // @PRIVACY POLICY --%>
                                <li id="PrivacyCt" class="form__field">
                                    <a href="<%= SettingsManager.ContextSettings["OrderFormReview.PrivacyPolicyLink"] %><%= Model.Extension %>" title="<%= SettingsManager.ContextSettings["Label.ProductName"] %> | <%= LabelsManager.Labels["PrivacyPolicyText"] %>">
                                        <%= LabelsManager.Labels["PrivacyPolicyText"] %>
                                    </a>
                                </li>
                                <% } %>
        
                            </ul>
                            </fieldset>
        
                            <hr>
        
                            <%-- // BEGIN #ShippingIsSame --%>
                            <label id="ShippingIsSame" for="ShippingIsDifferentThanBilling" class="o-grid--vert--center center-margin">
                                <div class="o-grid__col u-pad"><%= Html.CheckBoxFor(m => m.ShippingIsDifferentThanBilling) %></div>
                                <p class="o-grid__col u-pad"><%= LabelsManager.Labels["IsShippingDifferentFromBillingDisclaimer"] %></p>
                            </label>
                            <%-- // END #ShippingIsSame --%>
        
                            <%-- // BEGIN #shippingInformation --%>
                            <fieldset id="shippingInformation" class="u-mar--top">
        
                                <ul class="form__list">
        
                                    <%-- // @SHIPPING FULL NAME --%>
                                    <li id="ShippingFullNameCt" class="form__field">
                                        <label id="ShippingFullNameLabel" for="ShippingFullName" data-required class="c-brand--form__label"><%= LabelsManager.Labels["FullName"] %></label>
                                        <input id="ShippingFullName" name="ShippingFullName" type="text" value="<%= ViewData["ShippingFullName"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["FullNamePlaceholder"] %>" aria-labelledby="ShippingFullNameLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </li>
        
                                    <%-- // @SHIPPING STREET --%>
                                    <li id="ShippingStreetCt" class="form__field">
                                        <label id="ShippingStreetLabel" for="ShippingStreet" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Address"] %></label>
                                        <input id="ShippingStreet" name="ShippingStreet" type="text" value="<%= ViewData["ShippingStreet"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["AddressPlaceholder"] %>" aria-labelledby="ShippingStreetLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </li>
        
                                    <%-- // @SHIPPING STREET 2 --%>
                                    <li id="ShippingStreet2Ct" class="form__field">
                                        <label id="ShippingStreet2Label" for="ShippingStreet2" class="c-brand--form__label"><%= LabelsManager.Labels["Address2"] %></label>
                                        <input id="ShippingStreet2" name="ShippingStreet2" type="text" value="<%= ViewData["ShippingStreet2"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["Address2Placeholder"] %>" aria-labelledby="ShippingStreet2Label" aria-required="false" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </li>
        
                                    <%-- // @SHIPPING CITY --%>
                                    <li id="ShippingCityCt" class="form__field">
                                        <label id="ShippingCityLabel" for="ShippingCity" data-required class="c-brand--form__label"><%= LabelsManager.Labels["City"] %></label>
                                        <input id="ShippingCity" name="ShippingCity" type="text" value="<%= ViewData["ShippingCity"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["CityPlaceholder"] %>" aria-labelledby="ShippingCityLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </li>
        
                                    <%-- // @SHIPPING COUNTRY --%>
                                    <li id="ShippingCountryCt" class="form__field">
                                        <label for="ShippingCountry" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Country"] %></label>
                                        <%= Html.DropDownListFor(m => m.ShippingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName"), LabelsManager.Labels["CountryPlaceholder"], new { @class = "c-brand--form__select o-grid--col o-box o-shadow @xs-u-vw--100 fx--animate" })%>
                                    </li>
        
                                    <%-- // @SHIPPING STATE --%>
                                    <li id="ShippingStateCt" class="form__field">
                                        <label for="ShippingState" data-required class="c-brand--form__label"><%= LabelsManager.Labels["State"] %></label>
                                        <%= Html.DropDownListFor(m => m.ShippingState, new SelectList(Model.States, "StateCode", "StateName"), LabelsManager.Labels["StatePlaceholder"], new { @class = "c-brand--form__select o-grid--col o-box o-shadow @xs-u-vw--100 fx--animate" })%>
                                    </li>
        
                                    <%-- // @SHIPPING ZIP --%>
                                    <li id="ShippingZipCt" class="form__field">
                                        <label id="ShippingZipLabel" for="ShippingZip" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Zip"] %></label>
                                        <input id="ShippingZip" name="ShippingZip" type="tel" value="<%= ViewData["ShippingZip"] %>" maxlength="10" placeholder="<%= LabelsManager.Labels["ZipPlaceholder"] %>" aria-labelledby="ShippingZipLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                                    </li>
        
                                </ul>
        
                            </fieldset>
                            <%-- // END #shippingInformation --%>

                            <hr>

                            <%=Html.Partial("UPSShippingOptions") %>
        
                            </div>
        
                        </div>

                    </div>

                </div>
            
                <div class="form__item form__review">
                    <div class="form__scroll">
                        <%= Html.Partial("OrderFormReviewTable", Model) %>
                    </div>
                </div>
            </div>

            <div class="group__row">
                <%-- // BEGIN #referralInformation --%>
                <fieldset id="referralInformation" class="form__fieldset">

                    <div class="c-brand--form__legend u-vw--100">
                        <h3 class="c-brand--form__headline">
                            Referral Information
                        </h3>
                    </div>

                    <div class="form__group">
                    <ul class="form__list group group--inline-form">

                        <li class="form__field form__field--block">
                            <label class="c-brand--form__label">Referrer's Full Name</label>
                            <input id="ReferrerName" name="ReferrerName" type="text" placeholder="Referrer's Name" aria-labelledby="ReferrerName" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <li class="form__field form__field--block">
                            <label class="c-brand--form__label">Referrer's Company</label>
                            <input id="ReferrerCompany" name="ReferrerCompany" type="text" placeholder="Referrer's Company" aria-labelledby="ReferrerCompany" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <li class="form__field form__field--block">
                            <label class="c-brand--form__label">Dealer ID# (optional)</label>
                            <input id="ReferrerDealerId" name="ReferrerDealerId" type="text" placeholder="Dealer ID#" aria-labelledby="ReferrerDealerId" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                    </ul>
                    </div>

                </fieldset>
                <%-- // END #referralInformation --%>

                <%-- // BEGIN #calltoAction --%>
                <fieldset id="calltoAction" class="c-brand--form__fieldset--borderless">

                    <ul class="form__list @dv-u-pad--horz">

                        <%-- // @PROCESS ORDER BUTTON --%>
                        <li class="form__field u-mar--top">
                            <button id="AcceptOfferButton" name="acceptOffer" type="submit" class="button button--order u-mar--center">
                                Process Order
                            </button>
                        </li>

                        <%-- // @SSL BADGE --%>
                        <li class="form__field u-mar--vert @x2-mar">
                            <img src="/shared/images/PositiveSSL_tl_trans.png" alt="SSL" class="u-mar--center">
                        </li>

                    </ul>

                    <div class="l-disclaimer o-box @mv-u-vw--80 u-mar--center">
                        <% Html.RenderSnippet("OFFERDETAILS"); %>
                    </div>

                </fieldset>
                <%-- // END #calltoAction --%>
            </div>

        </div>

    <% } %>

</div>
