<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<main aria-labelledby="main-title" class="view">
    <div id="main" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy copy--article">
			<h2 id="main-title"><%= Model.UpsellTitle %></h2>
            <%= Model.UpsellText %>
        </div>
    </div>
</main>

</asp:Content>