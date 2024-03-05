<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%
    var id = (String)ViewData["id"] ?? string.Empty;
    var mid = "11490478";
    var version = "2.0000";
    var anchor = "order";
    var pathname = String.Format("{0}/{1}/index{2}?mid={3}#{4}", DtmContext.OfferCode, version, DtmContext.ApplicationExtension, mid, anchor);
    var CTALink = DtmContext.Domain.FullDomainCustomPathContext(pathname);
%>

<% if (id == "cta-nav") { %>
    <a class="nav__link nav__order button button--order" href="<%= CTALink %>" id="<%= id %>">
        <span>Order Now</span>
    </a>
<% } else { %>
   <%
       var href = "#lead";
       var descriptor = string.Empty;

       if (id != "cta-how-it-works")
       {
           descriptor = "Have questions?";
       }

   %>
    <% if (!String.IsNullOrEmpty(descriptor)) { %>
    <span class="cta">
        <strong class="cta__text"><%= descriptor %></strong>
        <a href="<%= href %>" id="<%= id %>" class="button button--order">Contact Us</a>
    </span>
    <% } else { %>
        <a href="<%= href %>" id="<%= id %>" class="button button--order">Contact Us</a>
    <% } %>
<% } %>