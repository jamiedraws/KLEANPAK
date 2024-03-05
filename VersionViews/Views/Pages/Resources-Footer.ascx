<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<% if (string.Equals(DtmContext.PageCode, "Index", StringComparison.InvariantCultureIgnoreCase)) { %>
    <script defer src="/js/slide/js/slide.js"></script>
    <script defer src="/js/slide/js/components/slide.a11y.js"></script>
    <script defer src="/js/index.js"></script>
<% } %>

<% if (string.Equals(DtmContext.PageCode, "FAQ", StringComparison.InvariantCultureIgnoreCase)) { %>
    <script defer src="/shared/customers/575/js/card.js"></script>    
<% } %>