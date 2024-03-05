<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var isFrontPage = DtmContext.Page.IsStartPageType;
    var v = String.Format("?v={0}", 2);
%>

<footer aria-label="Copyrights and policies" class="view view--footer">
    <div class="view__in">

        <% if (isFrontPage)
            {
                Html.RenderSnippet("FOOTER-FRONTEND");
            }
            else
            {
                Html.RenderSnippet("COMMON-FOOTER");
            } %>
    </div>

    <% if (isFrontPage)
        {
		%>
    <script defer src="/js/nav.js"></script>
    <script defer src="/js/resource.js"></script>
    <script defer src="/js/form.js<%= v %>"></script>
    <%
        Html.RenderPartial("Scripts");
        Html.RenderSnippet("ORDERFORMSCRIPT");
	%>

    <script>
        const vse = document.querySelector("#vse-error");
        var mouseLeave = false;
        addExitEvent(true);

        function submitLead() {

            if (isValidLead()) {
                $('.vse').empty();
                //Here is where i am disabling the submitButton and preparing to send 
                $('#leadSubmit').prop('disabled', true);
                $('#leadSubmit').text('Submitting....');

                var url = '/<%=DtmContext.OfferCode%>/<%=DtmContext.Version%>';

                var firstName = $('#FirstName').val();
                var lastName = $('#LastName').val();
                var company = $('#Company').val();
                var phone = $('#LeadPhone').val();
                var email = $('#LeadEmail').val();

                $.post(url, {
                    BillingFirstName: firstName,
                    BillingLastName: lastName,
                    Email: email,
                    Phone: phone,
                    Company: company,
                    RemoteType: 'Lead',
                    FormType: 'Lead',
                    OrderType: 'None',
                    ActionQuantity0: '1',
                    ActionCode0: 'LEAD'
                }, function (data) {
                    $('#FirstName').val('');
                    $('#LastName').val('');
                    $('#Company').val('');
                    $('#Phone').val('');
                    $('#Email').val('');

                    $.post(url, { createOrder: 'createOrder', RemoteType: 'Lead' }, function (data) {
                        $.get('/ActivateVisitor?covid=<%=DtmContext.VersionId%>', function (data) {
                        });
                    });
                    $('#leadSubmit').prop('disabled', false);
                    $('#leadSubmit').text('Submit Information');

                    //Here is where success message happens

                    alert("Thank you! Your information has been submitted.");
                });

            }
        }

        function isValidLead() {
            var firstName = $('#FirstName').val();
            var lastName = $('#LastName').val();
            var company = $('#Company').val();
            var phone = $('#LeadPhone').val();
            var email = $('#LeadEmail').val();
            var final = true;
            var errorMessages = ["Please see issues below:"];

            if (firstName.length < 1) {
                errorMessages.push("Please input a valid first name.");
            }
            if (lastName.length < 1) {
                errorMessages.push("Please input a valid last name.");
            }
            if (!validateTelephone(phone)) {
                errorMessages.push("Please input a valid phone number.");

            }
            if (!validateEmail(email)) {
                errorMessages.push("Please input a valid email");
            }

            if (errorMessages.length > 1) {
                var errorMessageString = errorMessages.join('\n');
                _dtm.alert(errorMessageString);
                final = false;

                vse.scrollIntoView();

            }
            return final;
        }

        function validateEmail(email) {

            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());

        }

        function validateTelephone(phone) {

            if (phone.length < 1 || phone.replace(/[^0-9]/g, "").length != 10) {
                return false;

            } else {
                return true;
            }
        }

        function addExitEvent(checkHeight) {

            document.documentElement.addEventListener("mouseleave", function (e) {
                if (!mouseLeave) {
                    if (!checkHeight || e.clientY < 20) {
                       
                        app.form.show();
                        fireSurvey = false;
                        fireIdle = false;
                     
                        mouseLeave = true;
                    }
                }
            }, false);
        }
    </script>


    <%} %>

    <div class="l-controls top-absolute">
        <% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
        <% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>
        <% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>
        <h1>THESE ARE SITE CONTROLS</h1>
    </div>
</footer>

<% if (isFrontPage)
    {
        Html.RenderPartial("Warranty", Model);
    } %>
