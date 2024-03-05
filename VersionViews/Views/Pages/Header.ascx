<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% 
	var isIndex = DtmContext.PageCode == "Index";
	var isMobile = DtmContext.IsMobile;
	var isDesktop = !isMobile;
    var isStartPage = DtmContext.Page.IsStartPageType && DtmContext.PageCode != "PaymentForm";
	var productName = SettingsManager.ContextSettings["Label.ProductName"];

    var ext = DtmContext.ApplicationExtension;
    var indexHref = "Index{0}{1}";

	var hashIndex = "#main";
	var hashFeatures = "#features";
	var hashHowItWorks = "#how-it-works";
    
	var linkIndex = isIndex ? hashIndex : String.Format(indexHref, ext, hashIndex);
	var linkFeatures = isIndex ? hashFeatures : String.Format(indexHref, ext, hashFeatures);
	var linkHowItWorks = isIndex  ? hashHowItWorks : String.Format(indexHref, ext, hashHowItWorks);

	var logo = "/images/1.0000/logo.svg";
	var logoNav = "/images/1.0000/logo--white.svg";
    var logoSize = "--arp: 235/90; max-width: 235px";
    var logoAlt = productName;

    var titleStrong = "Clean from 10,000 to 300,000 square feet between refills.";
    var titleSpan = "KLEAN/pak helps businesses, parks, industrial facilities and schools stay safe!";
%>

<% if (isDesktop) { %>
<header aria-labelledby="header-title" class="view header view--header">
	<div class="view__in">
		<div class="header__group">
			<a href="<%= linkIndex %>" id="header-logo" class="header__logo">
				<picture class="arp arp--logo" style="<%= logoSize %>">
					<img src="<%= logo %>" alt="<%= logoAlt %>">
				</picture>	
			</a>
			<h1 id="header-title" class="header__title title">
				<strong><%= titleStrong %></strong>
				<span><%= titleSpan %></span>
			</h1>
		</div>
	</div>
</header>
<% } %>


<nav aria-label="Website pages links" class="view nav">
	<% if (isMobile) { %>
	<a href="<%= linkIndex %>" id="nav-logo" class="nav__logo" style="<%= logoSize %>">
		<img src="<%= logo %>" alt="<%= logoAlt %>">
	</a>
	<% if (isStartPage) { %>
	<input class="nav__toggle" type="checkbox" id="nav__toggle">
	<label class="nav__label" for="nav__toggle" aria-label="Toggle Menu">
		<span></span>
	</label>
	<div class="nav__underlay" for="nav__toggle" role="presentation" aria-label="Hide Menu"></div>
	<% } %>
	<% } %>
	<% if (isStartPage) { %>
	<div class="nav__pane">
		<div class="nav__group">
			<div class="nav__list">
				<a href="<%= linkIndex %>" id="nav-logo" class="nav__logo" style="<%= logoSize %>">
					<img src="<%= logoNav %>" alt="<%= logoAlt %>">
				</a>
				<% if (isMobile) { %>
				<h1 class="nav__title title">
					<strong><%= titleStrong %></strong>
					<span><%= titleSpan %></span>
				</h1>
				<% } %>
				<a class="nav__link" href="<%= linkIndex %>" id="nav-home">
					<span>Home</span>
				</a>
				<a class="nav__link" href="<%= linkFeatures %>" id="nav-features-benefits">
					<span>Features &amp; Benefits</span>
				</a>
				<a class="nav__link" href="<%= linkHowItWorks %>" id="nav-how-it-works">
					<span>How It Works</span>
				</a>
				<a class="nav__link" href="FAQ<%= ext %>" id="nav-faq">
					<span>Frequently Asked Questions</span>
				</a>
				<%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-nav" } }) %>
			</div>
		</div>
	</div>
	<% } %>
</nav>

<% if (isMobile && isIndex)
    { %>
<header aria-labelledby="header-title" class="view header">
	<h2 id="header-title" class="title">
		<strong><%= titleStrong %></strong>
		<span><%= titleSpan %></span>
	</h2>
</header>
<% } %>