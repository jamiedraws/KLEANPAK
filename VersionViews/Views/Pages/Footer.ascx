<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
	var isFrontPage = DtmContext.Page.IsStartPageType;    
%>

<footer aria-label="Copyrights and policies" class="view view--footer">
	<div class="view__in">
		
		<% if (isFrontPage)
			{
				Html.RenderSnippet("FOOTER-FRONTEND");
			}
			else {
				Html.RenderSnippet("COMMON-FOOTER");
		} %>
		
	</div>

	<% if (isFrontPage) {
		%>
		<script defer src="/js/nav.js"></script>
		<%
		Html.RenderPartial("Scripts");
		Html.RenderSnippet("ORDERFORMSCRIPT");
	} %>

	<div class="l-controls top-absolute">
		<% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
		<% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>
		<% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>
	</div>
</footer>

<% if (isFrontPage) {
	Html.RenderPartial("Warranty", Model);
} %>
