<%@ Page Language="C#" MasterPageFile="~/Shared/Templates/DTM/Layouts/ConfirmationLayout.master" Inherits="System.Web.Mvc.ViewPage<Dtm.Framework.ClientSites.Web.ClientSiteViewData>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%@ Import Namespace="Dtm.Framework.Models.Ecommerce" %>
    <%@ Import Namespace="Dtm.Framework.ClientSites" %>
    <%@ Import Namespace="Dtm.Framework.Base.Enums" %>

    <style>
        .form-title {
            border: none;
        }

        .dtm .l-outer__in {
            padding: 2em;
        }

 			@-webkit-keyframes jQueryEflexDrawCheckmarkFill {
 				100% {
 			    	-webkit-box-shadow: inset 0px 0px 0px 4em #7ac142;
 			  	}
 			}

 			@-moz-keyframes jQueryEflexDrawCheckmarkFill {
 				100% {
 			    	-moz-box-shadow: inset 0px 0px 0px 4em #7ac142;
 			  	}
 			}

 			@-o-keyframes jQueryEflexDrawCheckmarkFill {
 				100% {
 			    	-o-box-shadow: inset 0px 0px 0px 4em #7ac142;
 			  	}
 			}

 			@keyframes jQueryEflexDrawCheckmarkFill {
 				100% {
 			    	box-shadow: inset 0px 0px 0px 4em #7ac142;
 			  	}
 			}

        .eflex-checkmark--is-checked {
            margin: auto;
            font-size: 1.25em;
            width: 5em;
            height: 5em;
        }

        .eflex-checkmark--is-checked .eflex-checkmark__svg {
            width: inherit;
            height: inherit;
        }

        .eflex-checkmark--is-checked .eflex-checkmark__svg {
            -webkit-animation: jQueryEflexDrawCheckmarkFill .4s ease-in-out .4s forwards, jQueryEflexDrawScale .3s ease-in-out .9s both;
            -moz-animation: jQueryEflexDrawCheckmarkFill .4s ease-in-out .4s forwards, jQueryEflexDrawScale .3s ease-in-out .9s both;
            animation: jQueryEflexDrawCheckmarkFill .4s ease-in-out .4s forwards, jQueryEflexDrawScale .3s ease-in-out .9s both;
        }

		.eflex-checkmark--is-checked .eflex-checkmark__svg .eflex-checkmark__circle {
		  	stroke-dasharray: 166; stroke-dashoffset: 166; stroke-miterlimit: 10; fill: none;
			-webkit-animation: jQueryEflexDrawCheckmarkStroke .6s cubic-bezier(0.650, 0.000, 0.450, 1.000) forwards;
				-moz-animation: jQueryEflexDrawCheckmarkStroke .6s cubic-bezier(0.650, 0.000, 0.450, 1.000) forwards;
		  			animation: jQueryEflexDrawCheckmarkStroke .6s cubic-bezier(0.650, 0.000, 0.450, 1.000) forwards;
		}

		.smil .eflex-checkmark--is-checked .eflex-checkmark__svg .eflex-checkmark__check {
		  	-webkit-animation: jQueryEflexDrawCheckmarkStroke .3s cubic-bezier(0.650, 0.000, 0.450, 1.000) .8s forwards;
				-moz-animation: jQueryEflexDrawCheckmarkStroke .3s cubic-bezier(0.650, 0.000, 0.450, 1.000) .8s forwards;
		  			animation: jQueryEflexDrawCheckmarkStroke .3s cubic-bezier(0.650, 0.000, 0.450, 1.000) .8s forwards;
		}

		.no-smil .eflex-checkmark--is-checked .eflex-checkmark__svg .eflex-checkmark__check {
			stroke-dashoffset: 0;
		}
    </style>

    <div class="eflex-checkmark--is-checked">
        <svg class="eflex-checkmark__svg" viewBox="0 0 52 52"><circle class="eflex-checkmark__circle" cx="26" cy="26" r="25" fill="none"></circle><path class="eflex-checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"></path></svg>
    </div>
    

    <div class="form-title">
		<span class="form-title__not-available">Thank you! Your Information has been submitted.</span>
		<small class="form-title__fill-out">Our representatives will be in touch shortly.</small>
	</div>

    <div class="@print-only-hide u-mar--vert @x2-mar">
        <% Html.BeginForm(); %>
        <button name="createOrder" type="submit" class="o-box--btn--icon fx--animate u-mar--center">
            <span class="icon-home right-padding"></span><%= LabelsManager.Labels["ConfirmationBackHomeButton"] %>
        </button>
        <% Html.EndForm(); %>
    </div>
</asp:Content>
