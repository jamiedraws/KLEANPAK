<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-label="<%= DtmContext.PageCode %>" class="view">
    <div id="main" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy copy--article">
            <% Html.RenderSnippet("SUBPAGE-TITLE-" + DtmContext.PageCode); %>
            <% Html.RenderSubPageContent(DtmContext.PageCode); %>
        </div>
    </div>
</main>

</asp:Content>