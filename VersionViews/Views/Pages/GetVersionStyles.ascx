<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<% 
    var isPaymentPage = DtmContext.PageCode == "PaymentForm" || DtmContext.PageCode == "ProcessPayment";
    var isFrontPage = DtmContext.Page.IsStartPageType && !isPaymentPage;
    var isIndex = DtmContext.PageCode == "Index";
    var isReviewPage = DtmContext.PageCode == "ReviewPage";
    var isUpsell = DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase) || isReviewPage;
    var isConfirmation = DtmContext.Page.PageType == "Confirmation";
    var isFAQ = DtmContext.PageCode == "FAQ";
    var isCCPA = DtmContext.PageCode == "CCPA";
    var v = String.Format("?v={0}", 13);
%>

<link rel="preload" href="/images/1.0000/logo.svg" as="image" type="image/png">
<link rel="preload" href="https://use.typekit.net/af/ea98f6/00000000000000003b9ae8e5/27/l?primer=388f68b35a7cbf1ee3543172445c23e26935269fadd3b392a13ac7b2903677eb&fvd=n4&v=3" as="font" type="font/woff2" crossorigin="anonymous">
<link rel="preload" href="https://use.typekit.net/af/6e816b/00000000000000003b9b3064/27/l?primer=388f68b35a7cbf1ee3543172445c23e26935269fadd3b392a13ac7b2903677eb&fvd=n5&v=3" as="font" type="font/woff2" crossorigin="anonymous">

<link rel="stylesheet" href="https://use.typekit.net/hyd7fff.css">
<link rel="stylesheet" href="/css/1.0000/header.css">

<% if (isIndex) { %>
    <link rel="stylesheet" href="/css/slide/slide.css">
    <link rel="stylesheet" href="/css/1.0000/index.css<%= v %>">
<% } else { %>
    <link rel="stylesheet" href="/css/1.0000/style.css<%= v %>">
<% } %>

<% if (isFrontPage) { %>
    <%= Html.Partial("GetPaymentIconStyles") %>
<% } %>

<% if (isFAQ) { %>
    <link rel="stylesheet" href="/css/1.0000/faq.css">
<% } %>