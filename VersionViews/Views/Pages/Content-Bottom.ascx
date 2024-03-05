<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%
	var EnableOrderForm = SettingsManager.ContextSettings["Order.EnableOrderform", true];
	var ShowMobileOrderForm = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.ShowOrderFormOnMobile", false];
	var renderOfferDetailsAboveAcceptOffer = SettingsManager.ContextSettings["Order.RenderOfferDetailsAboveAcceptOffer", false];
	var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>


<section aria-label="Order <%= productName %>" class="view view--section view--form">
	<div id="order" class="view__anchor"></div>
	<div class="view__in">
		<div class="form-title">
			<span class="form-title__not-available">THIS OFFER IS NOT AVAILABLE IN STORES!</span>
			<span class="form-title__fill-out">Fill out the form below to order your <strong><%= productName %></strong> now.</span>
		</div>

		<% if ( EnableOrderForm ) { %>

			<%-- // Displays the order form --%>
			<% Html.RenderPartial("OrderForm", Model); %>

		<% } %>
	</div>
</section>