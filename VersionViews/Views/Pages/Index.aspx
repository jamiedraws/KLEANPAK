<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% 
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
    var isMobile = DtmContext.IsMobile;
    var photoGallerySrc = "/images/1.0000/{0}.jpg";
    if (isMobile)
    {
        photoGallerySrc = "/images/1.0000/{0}@0.5x.jpg";
    }

    List<string> photoGallery = new List<string>()
    {
        String.Format(photoGallerySrc, "use-1"),
        String.Format(photoGallerySrc, "use-2"),
        String.Format(photoGallerySrc, "use-3"),
        String.Format(photoGallerySrc, "use-4"),
        String.Format(photoGallerySrc, "use-5")
    };
%>

<section aria-label="Photo gallery" class="view view--photo view--section">
    <div id="main" class="view__anchor"></div>
    <div class="slide">
        <div id="photo-slide" class="slide__into picture picture--gallery">
            <picture class="picture__img picture__img--alt" style="--arp:266/501;" data-src-img="<%= photoGallery.ElementAt(0) %>" data-attr='{ "alt": "Guy disinfecting a facility shower" }'>
                <noscript>
                    <img src="<%= photoGallery.ElementAt(0) %>" alt="Guy disinfecting a facility shower">
                </noscript>
            </picture>
            <picture class="picture__img" style="--arp:320/501;" data-src-img="<%= photoGallery.ElementAt(1) %>" data-attr='{ "alt": "Woman disinfecting an outdoor seating area" }'>
                <noscript>
                    <img src="<%= photoGallery.ElementAt(1) %>" alt="Woman disinfecting an outdoor seating area">
                </noscript>
            </picture>
            <picture class="picture__img" style="--arp:320/501;" data-src-img="<%= photoGallery.ElementAt(2) %>" data-attr='{ "alt": "Man disinfecting bleachers in a baseball dugout" }'>
                <noscript>
                    <img src="<%= photoGallery.ElementAt(2) %>" alt="Man disinfecting bleachers in a baseball dugout">
                </noscript>
            </picture>
            <picture class="picture__img" style="--arp:320/501;" data-src-img="<%= photoGallery.ElementAt(3) %>" data-attr='{ "alt": "Man disinfecting outside of large dumpster" }'>
                <noscript>
                    <img src="<%= photoGallery.ElementAt(3) %>" alt="Man disinfecting outside of large dumpster">
                </noscript>
            </picture>
            <picture class="picture__img picture__img--alt" style="--arp:266/501;" data-src-img="<%= photoGallery.ElementAt(4) %>" data-attr='{ "alt": "Guy disinfecting a truck loading dock" }'> 
                <noscript>
                    <img src="<%= photoGallery.ElementAt(4) %>" alt="Guy disinfecting a truck loading dock">
                </noscript>
            </picture>
        </div>
        <nav aria-label="Photo gallery previous and next slides" class="slide__nav">
            <button
                id="slide-prev" 
                aria-label="Select the previous slide"
                class="slide__prev"
                type="button"
            >
                <span class="icon-chevron-thin-left"></span>
            </button>
            <button
                id="slide-next" 
                aria-label="Select the next slide"
                class="slide__next"
                type="button"
            >
                <span class="icon-chevron-thin-right"></span>
            </button>
        </nav>
    </div>
</section>

<main aria-label="<%= productName %> offer" class="view view--main view--section">
    <div class="view__in">
        <div class="group group--offer">
            <div class="group group--product">
                <picture style="--arp:291/336;--arp-max:291px" data-src-img="/images/1.0000/product.png" data-attr='{ "alt": "<%= SettingsManager.ContextSettings["Label.ProductName"] %>" }'> 
                    <noscript>
                        <img src="/images/1.0000/product.png" alt="<%= SettingsManager.ContextSettings["Label.ProductName"] %>">
                    </noscript>
                </picture>
                <%= Html.Partial("OfferFullContext") %>
            </div>
            <div class="media picture">
            <%
                var videoIds = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Source", "415532882 | 415534574"];
                var videoLabels = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Labels", "Product Overview | How It Works"];

                if (!String.IsNullOrEmpty(videoIds) && !String.IsNullOrEmpty(videoLabels))
                {
                    string[] videoIdArray =
                    string.IsNullOrEmpty(videoIds)
                    ? new string[0]
                    : videoIds
                        .Split(new[] { "|" }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(s => s.Trim())
                        .Where(s => !string.IsNullOrWhiteSpace(s))
                        .ToArray();

                    string[] videoLabelArray =
                    string.IsNullOrEmpty(videoLabels)
                    ? new string[0]
                    : videoLabels
                        .Split(new[] { "|" }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(s => s.Trim())
                        .Where(s => !string.IsNullOrWhiteSpace(s))
                        .ToArray();

                    var firstVideo = videoIdArray.FirstOrDefault();

                    if (firstVideo != null)
                    {
                        var iframeAllow = string.Empty;
                        if (DtmContext.Version == 3) {
                            iframeAllow = "autoplay";
                        }
                        %>
                        <div class="media__video picture__img" data-src-iframe="https://player.vimeo.com/video/<%= firstVideo %>?autoplay=1&dnt=1" style="--arp:445/250;" data-attr='{ "width": "445", "height": "250", "allow": "<%= iframeAllow %>"}'></div>
                        <%
                    }

                    int labelLength = videoLabelArray.Count();

                    if (videoIdArray.Count() == labelLength)
                    {
                        %>
                        <nav aria-label="Video playlist">
                        <%
                        for (int i = 0; i < labelLength; i++)
                        {
                            var id = String.Format("video-{0}", videoLabelArray[i].Replace(" ", string.Empty));
                            %>
                            <button id="<%= id %>" class="button" data-video-id="<%= videoIdArray[i] %>"><%= videoLabelArray[i] %></button>
                            <%
                        }
                        %>
                        </nav>
                        <%
                    }
                }
            %>
            </div>
            <div class="group__row picture picture--banner">
                <picture class="picture__img" style="--arp:980/119;--arp-max:980px" data-src-img="/images/1.0000/made-in-usa.jpg" data-attr='{ "alt" : "Proudly Made in U.S.A." }' data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/1.0000/made-in-usa--cd.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/1.0000/made-in-usa.jpg" }]}'>
                    <noscript>
                        <img src="/images/1.0000/made-in-usa.jpg" alt="">
                    </noscript>
                </picture>
            </div>
            </div>
        </div>
        <div class="view__in">
            <div id="highlight" class="view__anchor"></div>
            <figure class="group group--article article picture picture--article group__row">
                <picture class="article__img picture__img" style="--arp:456/196;--arp-max:456px" data-src-img="/images/1.0000/meter-dial.jpg" data-attr='{ "alt": "Illustration of the meter dial" }'> 
                    <noscript>
                        <img src="/images/1.0000/meter-dial.jpg" alt="Illustration of the meter dial">
                    </noscript>
                </picture>
                <figcaption class="article__figcaption copy__article">
                    <h2>Secure Disinfection:</h2>
                    <p><strong>The <%= productName %> works with lots of different disinfectants.</strong> Many of those solutions have different dilution rates. That's why the <%= productName %> has an adjustable metering valve that is factory calibrated and flow tested. It ensures the concentration mix of water to disinfectant is right every time and can be adjusted for almost any appropriate cleaner.</p>
                    <p>The <%= productName %> is compatible with over 130 EPA List N products.</p>
                    <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-highlight" } }) %>
                </figcaption>
            </figure>
    </div>
</main>

<article aria-label="About <%= productName %>" class="view view--section view--contrast">
    <div id="about" class="view__anchor"></div>
    <picture class="view__bg" data-src-img="/images/1.0000/bg--water.jpg">
        <noscript>
            <img src="/images/1.0000/bg--water.jpg" alt="">
        </noscript>
    </picture>
    <div class="view__in">
        <div class="copy copy--article">
            <div class="group">
                <div class="group__row">
                    <h2 id="about-title">As the world transitions to open for business again, everyone is asking, <em class="copy__alert">"How do we open safely?"</em></h2>
                </div>
                <div class="copy__article">
                    <p><strong>Task Force Tips</strong> has a tool to help. For over 50 years, TFT has been manufacturing equipment to help save lives and protect property. The new, patent pending, <strong>TFT <%= productName %></strong> mass disinfection system continues that legacy of protection.</p>

                    <p>The <%= productName %> allows municipal, commercial, and industrial users to <strong>safely, effectively, and quickly disinfect areas</strong> by simply adding garden hoses, water and one of the dilutable liquid disinfectants shown on EPA's List N of products for emerging viruses like <strong>COVID-19</strong>, <strong>MERS</strong>, and <strong>SARS</strong>.</p>
    
                    <p>The <%= productName %> is made in the USA by a global leader in public safety water flow products. It is factory calibrated and has an adjustable metering valve that helps you ensure that the disinfectant concentration is safe and effective.</p>
    
                    <p><strong>Clean from 10,000 to 300,000 square feet between refills.</strong> KLEAN/pak helps businesses, parks, industrial facilities and schools stay safe.</p>
    
                    <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-about" } }) %>
                </div>
                <figure class="picture picture--portrait">
                    <picture class="picture__img" style="--arp:408/443;--arp-max:211px" data-src-img="/images/1.0000/card-use-1.jpg" data-attr='{ "alt": "Pouring the cleaning solution into the resevoir tank" }'> 
                        <noscript>
                            <img src="/images/1.0000/card-use-1.jpg" alt="Pouring the cleaning solution into the resevoir tank">
                        </noscript>
                    </picture>
                    <picture class="picture__img" style="--arp:408/443;--arp-max:211px" data-src-img="/images/1.0000/card-use-2.jpg" data-attr='{ "alt": "Pouring the cleaning solution into the resevoir tank" }'> 
                        <noscript>
                            <img src="/images/1.0000/card-use-2.jpg" alt="Pouring the cleaning solution into the resevoir tank">
                        </noscript>
                    </picture>
                    <picture class="picture__img" style="--arp:408/443;--arp-max:211px" data-src-img="/images/1.0000/card-use-3.jpg" data-attr='{ "alt": "Pouring the cleaning solution into the resevoir tank" }'> 
                        <noscript>
                            <img src="/images/1.0000/card-use-3.jpg" alt="Pouring the cleaning solution into the resevoir tank">
                        </noscript>
                    </picture>
                </figure>
            </div>
        </div>
    </div>
</article>

<section aria-labelledby="how-it-works-title" class="view view--section">
    <div id="how-it-works" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy group">
            <div class="group__row">
                <h2 id="how-it-works-title"><%= productName %> is so easy to use.</h2>
                <p>The <%= productName %> is an industrial grade, portable mass disinfection system that is designed to provide disinfecting solution over a large area with an easy to use standard garden hose water supply. Using the <%= productName %>, with appropriate disinfecting solutions, gives a quick and easy way to disinfect larger items and items with areas that are difficult to reach with a wipe. Since the <%= productName %> is not an aerosol dispenser, the spray droplets are larger and won't get carried away by the wind, resulting in more disinfecting solution making it to the items being disinfected.</p>
            </div>
            <div class="group__row group">
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/step-1.jpg" data-attr='{ "alt": "Pouring the cleaning solution into the resevoir tank" }'> 
                        <noscript>
                            <img src="/images/1.0000/step-1.jpg" alt="Pouring the cleaning solution into the resevoir tank">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>1. Fill The Reservoir</h3>
                        <p>Unscrew the fill lid. Fill reservoir to bottom of fill lid. Disinfectant may seep out if overfilled.</p>
                    </figcaption>
                </figure>
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/step-2.jpg" data-attr='{ "alt": "Attach the head nozzle" }'> 
                        <noscript>
                            <img src="/images/1.0000/step-2.jpg" alt="Attach the head nozzle">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>2. Attach Head & Set Controls</h3>
                        <p>Insert the pickup tube into the jug and screw on the fill lid. Turn to the required concentration per the disinfectant manufacturer's Technical Data Sheet.</p>
                    </figcaption>
                </figure>
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/step-3.jpg" data-attr='{ "alt": "Attach the hose and start spraying" }'> 
                        <noscript>
                            <img src="/images/1.0000/step-3.jpg" alt="Attach the hose and start spraying">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>3. Attach Hose & Spray</h3>
                        <p>Attach 5/8" (16 mm) garden hose to the water source. Screw flat fan nozzle and wand onto the garden hose output. You are now ready to spray!</p>
                    </figcaption>
                </figure>
            </div>
            <nav aria-label="Guides and instruction manuals" class="group__row group group--nav">
                <a target="_blank" href="/images/docs/KLEAN-pak-Quick-Start-Guide.pdf" class="button">Download Quick Start Guide</a>
                <a target="_blank" href="/images/docs/KLEAN-pak-Instructions.pdf" class="button">Download Full Instruction Manual</a>
                <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-how-it-works" } }) %>
            </nav>
        </div>
    </div>
    <picture style="--arp:1500/112;" data-src-img="/images/1.0000/bg--wave.jpg" data-attr='{ "class" : "view__span" }'>
        <noscript>
            <img src="/images/1.0000/bg--wave.jpg" class="view__span" alt="">
        </noscript>
    </picture>
</section>

<section aria-labelledby="features-title" class="view view--section view--contrast">
    <div id="features" class="view__anchor"></div>
    <picture class="view__bg" data-src-img="/images/1.0000/bg--droplets.jpg">
        <noscript>
            <img src="/images/1.0000/bg--droplets.jpg" alt="">
        </noscript>
    </picture>
    <div class="view__in">
        <div class="copy">
            <h2 id="features-title"><%= productName %> Features &amp; Benefits</h2>
            <%
                List<string> features = new List<string>()
                {
                    "No special equipment required. Just add standard garden hoses, tap water, and disinfectant liquid.",
                    "User only need wear standard safety glasses and gloves.",
                    "Not limited to one disinfectant solution. Choose from many types and brands found on the EPA's website on the List N--Products with Emerging Viral Pathogens AND Human Coronavirus claims for use against SARS-CoV-2.",
                    "Simple to use. No special training needed.",
                    "Up to 5 hours of use between refills.",
                    "Fast, so employees can quickly disinfect and get back to their normal duties.",
                    "Accurate, calibrated and flow tested metering valve helps ensure the disinfectant to water ratio is right every time.",
                    "Safe, it runs on regular tap water at normal pressures.",
                    "Flexible, it doesn't need gasoline or power to operate and can be used anywhere a garden hose can be used.",
                    "Affordable, other kits cost several thousand dollars.",
                    "Made in America by water flow experts that have been trusted by first responders for over 50 years."
                };
            %>
            <ul class="list">
                <% foreach (var feature in features)
                    { %>
                <li class="list__item fx--slide">
                    <span class="list__bar">
                        <span class="list__bar__text"><%= feature %></span>
                    </span>
                </li>
                <% } %>
            </ul>
            <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-features" } }) %>
        </div>
    </div>
</section>

<section aria-labelledby="demo-title" class="view view--section">
    <div id="demo" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy group">
            <div class="group__row">
                <h2 id="demo-title">A great solution for any business, organization or institution</h2>
            </div>
            <div class="group__row group">
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/area-playground.jpg" data-attr='{ "alt": "Playground" }'> 
                        <noscript>
                            <img src="/images/1.0000/area-playground.jpg" alt="Playground">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>Playgrounds</h3>
                    </figcaption>
                </figure>
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/area-golf.jpg" data-attr='{ "alt": "Golf course" }'> 
                        <noscript>
                            <img src="/images/1.0000/area-golf.jpg" alt="Golf course">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>Golf Courses</h3>
                    </figcaption>
                </figure>
                <figure class="picture picture--square">
                    <picture class="picture__img" style="--arp:307/254;--arp-max:307px" data-src-img="/images/1.0000/area-gym.jpg" data-attr='{ "alt": "Gym" }'> 
                        <noscript>
                            <img src="/images/1.0000/area-gym.jpg" alt="Gym">
                        </noscript>
                    </picture>
                    <figcaption class="picture__caption">
                        <h3>Gym Locker Rooms &amp; More</h3>
                    </figcaption>
                </figure>
            </div>
        </div>
    </div>
</section>

</asp:Content>