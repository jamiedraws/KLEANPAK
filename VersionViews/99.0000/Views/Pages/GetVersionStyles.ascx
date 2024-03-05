<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%-- Html.RenderSnippet("STYLE-BLOCK-HEAD"); --%>

<% Html.RenderPartial("CSS.Module.ARP", Model); %>
<% Html.RenderPartial("GetPaymentIconStyles", Model); %>

<link rel="stylesheet" href="https://use.typekit.net/ihz5rkx.css">

<style>
body.dtm__in {
  background: white;
}
body {
  font-family: proxima-nova-condensed, sans-serif;
  font-weight: 500;
}
* {
  font-family: proxima-nova-condensed, 'Arial', 'Helvetica', sans-serif;
}
.no-bkg,
.no-bkg::after {
  background: none;
}
.group {
  display: flex;
}
.l-header__in,
.l-outer__in,
.l-footer__in,
.group--hero,
.group--info {
  max-width: 1000px;
  margin: 0 auto;
}
.disclaimer--temp {
  background: #ec0631;
  color: white;
  text-align: center;
  padding: 1.4rem;
  font-size: 2.5rem;
  font-weight: 800;
  font-style: italic;
  text-transform: uppercase;
}
.group--header {
  justify-content: space-between;
  align-items: center;
  padding: 1.3rem 0;
}

.hero {
  text-align: center;
}

.hero::before {
  content: "";
  background: url(/images/bkg.jpg) center top no-repeat;
  width: 100%;
  height: 404px;
  display: block;
  position: absolute;
  left: 0;right: 0;
  z-index: -1;
}

.group--hero {
  flex-wrap: wrap;
  padding: 2rem 0;
}

.group--hero .hero__tagline {
  flex: 0 1 100%;
}

.hero__tagline {
  color: white;
  font-size: 4.2rem;
  font-weight: bold;
  text-shadow: 0 0.05em 0.2em rgba(0,0,0,0.3);
}

.hero__usa {
  margin: 2rem auto;
}

.hero .offer {
  padding: 2rem 1.8rem 3.5rem;
  background: white;
  border-radius: 0.25em;
  box-shadow: inset 0 0 0.25em rgba(0,0,0,0.6);
  filter: drop-shadow(0 0 0.25em rgba(0,0,0,0.6));
}


.offer {
  font-size: 3.4rem;
  font-weight: 800;
  line-height: 1.2;
  color: #222222;
}

.offer .email__link {
  text-decoration: none;
  border-bottom: 0.1em solid #222;
}

.offer .email__link:hover,
.offer .email__link:focus {
  border-bottom: none;
  color: #023e91;
}

.offer__highlight {
  color: #ec0631;
}

.offer__price {
    font-size: 1.47em;
    border-bottom: 0.2rem solid #bcbcbc;
    margin-bottom: 0.25em;
}

.offer__price span {
    font-size: 0.68em;
    font-weight: 600;
}

.offer__price small {
    font-size: 0.36em;
    font-weight: 400;
}

.info .offer {
  border-bottom: 0.2rem solid #bcbcbc;
  text-align: center;
  padding: 2rem 1rem 3rem;
  margin: 0 auto 2rem;
  width: 100%;
  font-size: 4rem;
}

.group--info {
  justify-content: space-between;
  flex-wrap: wrap;
}

.group--info .info__title {
  flex: 0 1 100%;
}

.group--info .info__img {
  flex: 0 1 362px;
}

.group--info .info__copy {
  flex: 1;
}

.info__title {
  text-align: center;
  color: #094b99;
  font-size: 4.3rem;
  font-weight: 800;
  margin: 1rem auto;
}

.info__title strong {
  color: #ec0631;
  font-size: 1.2em;
}

.info p {
  font-size: 2rem;
  line-height: 1.5;
  margin: 2rem 0;
  color: #222222;
}

.info p a {
  color: #ec0631;
  text-decoration: none;
  border-bottom: 0.1em solid #ec0631;
}

.info p a:hover,
.info p a:focus {
  border-bottom: none;
  color: #023e91;
}

.dtm .dtm__in .l-footer {
  box-shadow: 0 -0.25rem 0.5rem rgba(0,0,0,0.3);
  border-top: 0.3rem solid white;
  background: #ebebeb;
  margin-top: 3rem;
}

.group--footer {
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  font-size: 2.6rem;
  font-weight: 800;
  text-align: center;
}

.group--footer .img {
    margin: 0 1rem;
}

@media screen and (min-width: 1000px) {
  .group--hero {
    min-height: 500px;
    align-items: flex-start;
  }
  .group--hero .hero__offer {
    flex: 0 1 440px;
    padding-top: 6rem;
  }
  .hero__offer .offer {
    max-width: 49rem;
    margin: 0 auto;
  }
  .group--hero .hero__img {
    position: relative;
    flex: 0 1 560px;
    overflow: visible;
  }
  .hero__img img {
    width: 602px;
    position: absolute;
    left: 0; top: 0;
  }
  .hero__usa {
    margin-top: 6rem;
  }
}

@media screen and (min-width: 1500px) {
    .hero::before {
        background-size: 100% auto;
    }
}

@media screen and (max-width: 1000px) {
    .hero::before {
        height: 26rem;
    }
}

@media screen and (max-width: 750px) {
    .hero::before {
        height: 22rem;
    }
}

@media screen and (max-width: 1000px) {
    .l-header__in,
    .l-outer__in,
    .l-footer__in,
    .group--hero,
    .group--info {
        padding-left: 1rem;
        padding-right: 1rem;
    }
    .group--hero {
        align-items: center;
    }
    .header__logo {
        flex-basis: 33%;
    }
    .header__headline {
        flex: 1;
    }
    .header__headline img {
        width: 100%;
    }
    .hero__tagline {
        font-size: 3rem;
    }
    .hero__img {
        flex: 0 1 40%
    }
    .hero__offer {
        flex: 0 1 60%;
    }
    .hero__offer .offer {
        font-size: 3rem;
        padding: 1rem 1rem 2rem;
        margin: 1rem 1rem 2rem;
    }
    .hero__img img {
        width: 100%;
    }
    .group--footer {
        font-size: 2rem;
    }
}

@media screen and (max-width: 750px) {
    .disclaimer--temp {
        font-size: 2rem;
    }
    .hero__img,
    .hero__offer {
        flex: 0 1 100%;
    }
    .hero__img img {
        max-width: 280px;
    }
    .hero__offer .offer {
        font-size: 1.5rem;
        width: 96%;
        margin: 0 auto 2rem;
    }
    .hero__tagline,
    .info__title {
        font-size: 2.4rem;
    }
    .info .offer {
      font-size: 3rem;
    }
    .info__title strong {
      display: block;
      font-size: 1em;
    }
    .group--footer {
        font-size: 1.3rem;
    }
    .group--footer .footer__flag {
        max-width: 2.2rem;
    }
    .group--footer .footer__tft {
        margin: 0;
        max-width: 50%;
    }
}

@media screen and (max-width: 520px) {
    .mobile-break {
      display: block;
    }
    .group--header {
        flex-wrap: wrap;
        justify-content: center;
    }
    .header__logo,
    .header__headline {
        flex-basis: 100%;
    }
    .header__logo {
      max-width: 220px;
    }
    .info .offer {
      font-size: 2.2rem;
      padding: 0 0 2rem;
    }
    .disclaimer--temp {
      font-size: 1.8rem;
    }
    .hero__usa {
      display: none;
    }
}

@media all and (-ms-high-contrast:none) {
     *::-ms-backdrop, .hero__offer .offer { font-size: 3rem; } /* IE11 */
     *::-ms-backdrop, .group--info .info__copy { flex: 0 1 60%; } /* IE11 */
     *::-ms-backdrop, .group--footer { font-size: 2.3rem; } /* IE11 */
     *::-ms-backdrop, body { min-width: 1000px; } /* IE11 */
}

</style>