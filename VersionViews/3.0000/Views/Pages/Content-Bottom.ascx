<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%
	var EnableOrderForm = SettingsManager.ContextSettings["Order.EnableOrderform", true];
	var ShowMobileOrderForm = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.ShowOrderFormOnMobile", false];
	var renderOfferDetailsAboveAcceptOffer = SettingsManager.ContextSettings["Order.RenderOfferDetailsAboveAcceptOffer", false];
	var productName = SettingsManager.ContextSettings["Label.ProductName"];
	var url = string.Format("/{0}/{1}/Index.dtm" ,DtmContext.OfferCode , DtmContext.Version );
%>	


<section aria-label="Order <%= productName %>" class="view view--section view--form">
	<div id="order" class="view__anchor"></div>
	<div class="view__in">

		<div id="lead" class="c-view">
            <div class="c-view__overlay">
                <div class="c-view__underlay"></div>
                <div class="c-view__in">
                    <button type="button" class="c-view__close"></button>
					<div class="form-title">
						<span class="form-title__not-available">Need More Info? We'd be happy to help answer your questions...</span>
						<small class="form-title__fill-out">Our representatives will be in touch shortly.</small>
					</div>
			
					<% if ( EnableOrderForm ) { %>
			
						<div class="c-brand--form form">
							<div id="vse-error" class="view__anchor"></div>
							<form id="leadForm" action="<%=url %>" method="post" data-processing-message="Submitting..." >
								<div class="group">
			
									<div class="group__row">
										<div class="vse" data-vse-scroll><%= Html.ValidationSummary("The following errors have occurred:") %></div>
			 
										<p data-required class="u-mar--bottom fn--center"><%= LabelsManager.Labels["RequiredFieldDisclaimer"] %></p>
										
										<fieldset id="referralInformation" class="form__fieldset">
						
											<div class="c-brand--form__legend u-vw--100">
												<h3 class="c-brand--form__headline">
													Tell Us About Yourself
												</h3>
											</div>
						
											<div class="form__group">
											<ul class="form__list group group--inline-form">
						
												<li class="form__field form__field--block">
													<label class="c-brand--form__label" data-required>First Name</label>
													<input id="BillingFirstName" name="BillingFirstName" type="text" placeholder="*First Name" aria-labelledby="FirstName" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
												</li>
						
												<li class="form__field form__field--block">
													<label class="c-brand--form__label" data-required>Last Name</label>
													<input id="BillingLastName" name="BillingLastName" type="text" placeholder="*Last Name" aria-labelledby="LastName" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
												</li>
						
												<li class="form__field form__field--block">
													<label class="c-brand--form__label">Company (optional)</label>
													<input id="Company" name="Company" type="text" placeholder="Company" aria-labelledby="Company" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
												</li>
			
												<li class="form__field form__field--block">
													<label class="c-brand--form__label" data-required>Phone</label>
													<input id="Phone" name="Phone" type="text" placeholder="*Phone" aria-labelledby="Phone" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
												</li>
			
												<li class="form__field form__field--block">
													<label class="c-brand--form__label" data-required>Email</label>
													<input id="Email" name="Email" type="text" placeholder="*Email" aria-labelledby="Email" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
												</li>	
			
											</ul>
											</div>
						
										</fieldset>
			
										<%-- // BEGIN #calltoAction --%>
										<fieldset id="calltoAction" class="c-brand--form__fieldset--borderless">
						
											<ul class="form__list @dv-u-pad--horz">
						
												<%-- // @PROCESS ORDER BUTTON --%>
												<li class="form__field u-mar--top">
													<button id="leadSubmit" name="leadSubmit" onclick="submitLead()" type="button" class="button button--order u-mar--center">
														Submit Information
													</button>
													<input type="hidden" value="none" name="OrderType" />
												</li>
						
												<%-- // @SSL BADGE --%>
												<li class="form__field u-mar--vert @x2-mar">
													<img src="/shared/images/PositiveSSL_tl_trans.png" alt="SSL" class="u-mar--center">
												</li>
						
											</ul>
					
						
										</fieldset>
										<%-- // END #calltoAction --%>
									</div>
			
								</div>
							</form>
							</div>
			
					<% } %>
                </div>
            </div>
        </div>

	</div>
</section>