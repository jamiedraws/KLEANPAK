<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%
    var id = (String)ViewData["id"] ?? string.Empty;
%>

<% if (id == "cta-nav") { %>
    <a class="nav__link nav__order" href="#order" id="<%= id %>">
        <span>Order</span>
    </a>
<% } else if (id == "cta-main") { %>
    <a href="#order" class="button button--order">Order Now</a>
<% } else { %>
    <a href="#order" class="button button--order">Click Here To Order Now</a>
<% } %>