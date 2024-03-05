<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div class="group group--price">
    
    <div class="group group--payment">
        <%= Html.Partial("CTALink", new ViewDataDictionary { { "id", "cta-main" } }) %>
        <em>
            <span>Backed by our</span> 
            <span>one-year limited warranty</span>
        </em>
    </div>
</div>