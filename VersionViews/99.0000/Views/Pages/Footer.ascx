<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

	<footer class="l-footer o-box--none block @mv-u-pad--reset @print-only-hide">

    <div class="l-footer__in">
      <div class="group group--footer">
        Portable Mass Disinfection System &bull; MADE IN USA
        <div class="img footer__flag no-bkg" style="--aspect-ratio:24/45; --aspect-ratio-width: 45px">
          <img src="/images/usa-flag.jpg" alt="USA">
        </div> By
        <div class="img footer__tft no-bkg" style="--aspect-ratio:48/268; --aspect-ratio-width: 268px">
          <img src="/images/tft-logo.png" alt="USA">
        </div>
      </div>
    </div>

	</footer>




	<%-- // @JS-FOOTER --%>
	<% switch ( DtmContext.Page.IsStartPageType ) { %>

		<% case false: %>


			<% break; %>
		<% default: %>

			<% Html.RenderPartial("Scripts"); %>
			<%-- Html.RenderSnippet("ORDERFORMSCRIPT"); --%>

			<% break; %>

	<% } %>



	<%= Model.FrameworkVersion %>

	<div class="l-controls">
		<% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
		<% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>
		<% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>
	</div>

