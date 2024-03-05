<%@ Page Language="C#" MasterPageFile="~/VersionViews/99.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="hero">
  <div class="group group--hero">
    <h2 class="hero__tagline">Clean from 1,000 to 300,000 square feet between refills</h2>

    <div class="hero__img">
      <img src="/images/product-with-price.png" alt="<%= SettingsManager.ContextSettings["Label.ProductName"] %>">
    </div>
    <div class="hero__offer">
      <div class="hero__video">
        <iframe src="https://player.vimeo.com/video/414814523?autoplay=1&title=0&byline=0&portrait=0" width="422" height="237" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>
      </div>
      <div class="hero__usa" style="--aspect-ratio:109/208; --aspect-ratio-width: 208px">
        <img src="/images/made-in-usa.png" alt="Made in the USA">
      </div>
    </div>
  </div>
</div>

<article class="info group group--info">
  <div class="offer">
    <div class="offer__info">
      <span class="offer__highlight mobile-break">ORDER TODAY BY CALLING</span> 800 348-2686 or 219 462-6161<br> <span class="offer__highlight">or EMAIL</span> <a class="offer__email" href="mailto:KLEAN-PAK@TFT.COM">KLEAN-PAK@TFT.COM</a>
    </div>
  </div>
  <h3 class="info__title">
    As the world transitions to being open for business again, everyone is asking, <strong>&ldquo;How do we open safely?&rdquo;</strong>
  </h3>
  <div class="info__copy">
    <p><strong>Task Force Tips has a tool to help.</strong> For over 50 years, TFT has been manufacturing equipment to help save lives and protect property. The new, patent pending, <strong>TFT KLEAN/pak mass disinfection system</strong> continues that legacy of protection.</p>
    <p>The KLEAN/pak allows municipal, commercial, and industrial users to <strong>safely, effectively, and quickly disinfect areas</strong> by simply adding garden hoses, water and one of the dilutable liquid disinfectants shown on EPA's List N of products for emerging viruses like <strong>COVID-19, MERS,</strong> and <strong>SARS.</strong></p>
    <p><strong>The KLEAN/pak is made in the USA</strong> by a global leader in public safety water flow products. It is factory calibrated and has an adjustable metering valve that helps you ensure that the disinfectant concentration is safe and effective.</p>
    <p><strong>Clean from 1,000 to 300,000 square feet between refills.</strong> KLEAN/pak helps businesses, parks, industrial facilities and schools stay safe.</p>
  </div>
  <div class="info__img">
    <div class="img" style="--aspect-ratio:531/362; --aspect-ratio-width: 362px">
      <img src="/images/uses.jpg" alt="Apply it around your business">
  </div>
  </div>
</article>

</asp:Content>

