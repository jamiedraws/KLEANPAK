<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

	<header class="l-header no-padding @print-only-hide">

		<div class="disclaimer--temp">
			This is a temporary site. <span class="mobile-break"></span>Our e-commerce site is coming soon.
		</div>

		<div class="l-header__in">

			<div class="group group--header">

				<div class="header__logo no-bkg" style="--aspect-ratio:82/334; --aspect-ratio-width: 334px">
					<img src="/images/logo.png" alt="<%= SettingsManager.ContextSettings["Label.ProductName"] %> Task Force Tips ">
				</div>

				<div class="header__headline">
					<img src="/images/headline.png" alt="Portable Mass Disinfection System Patent Pending - Made in the USA">
				</div>

			</div>

		</div>

	</header>
