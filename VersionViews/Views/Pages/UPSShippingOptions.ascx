<%@ Control Language="C#"  %>

<fieldset class="up-shipping">
    <style>
        .ups-shipping {
            margin: 0;
        }

        .ups-shipping__field {
            margin-top: 1rem;
        }

        .ups-shipping__field select {
            margin-top: .25rem;
        }

        .ups-shipping__alert {
            background: #d8ffce;
            padding: 1em;
            color: #1F5C00;
            border-radius: 2em;
            display: flex;
            overflow: hidden;
            margin: 1em 0;
            justify-content: center;
        }

        .ups-shipping__title strong {
            font-size: 1.6rem;
        }

        .ups-shipping__title em {
            font-style: italic;
            display: block;
            color: #444;
        }

        .ups-shipping__title abbr {
            text-decoration: none;
            border: none;
        }
    </style>

    <div class="ups-shipping__title"><strong>Select A <abbr title="United Parcel Service, Inc." aria-label="United Parcel Service, Inc.">UPS</abbr>
        Shipping Option</strong> <em>(Zip/Postal Code &amp; Country fields are required.)</em></div>
    <div id="ShippingCallout" class="ups-shipping__alert hide" aria-live="assertive">
        <span>With <strong><span id="ShippingMethod">UPS Ground</span></strong> shipping included, your order total is <strong><span id="ShippingOrderTotal">$745.49</span></strong>.</span>
    </div>
    <div class="ups-shipping__field">
        <label for="ShippingOption" data-required class="c-brand--form__label">Shipping Option</label>
        <select id="ShippingOption" name="ShippingOption" class="c-brand--form__select o-grid--col o-box o-shadow @xs-u-vw--100 fx--animate">
            <option value="">Select Shipping</option>
        </select>
    </div>

    <input type="hidden" id="UPSShippingSku" name="UPSShippingSku" class="cartParam" />
    <input type="hidden" id="UPSShippingPrice" name="UPSShippingPrice" class="cartParam" />
    <input type="hidden" id="UPSShippingDesc" name="UPSShippingDesc" class="cartParam" />
    <input type="hidden" id="UPSShippingZip" name="UPSShippingZip" />

    <script type="text/javascript">
        var UPSShippingEngine = function () {

            const shippingSkuEle = document.getElementById("UPSShippingSku"),
                shippingPriceEle = document.getElementById("UPSShippingPrice"),
                shippingDescEle = document.getElementById("UPSShippingDesc"),
                upsShippingZipEle = document.getElementById("UPSShippingZip"),
                shippingZipEle = document.getElementById("ShippingZip"),
                billingZipEle = document.getElementById("BillingZip"),
                shipDiffEle = document.getElementById("ShippingIsDifferentThanBilling"),
                billingCountryEle = document.getElementById("BillingCountry"),
                shippingCountryEle = document.getElementById("ShippingCountry"),
                shippingOptionEle = document.getElementById("ShippingOption"),
                shippingCalloutEle = document.getElementById("ShippingCallout"),
                shippingOrderTotalEle = document.getElementById("ShippingOrderTotal"),
                shippingMethodEle = document.getElementById("ShippingMethod"),
                hideClass = "hide";

            let postalCode = "",
                countryCode = "",
                shippingMethods = [];

            const getShippingOptions = function () {
                const shipZip = getShippingZip(),
                    shipCountry = getCountryCode();

                if ((postalCode != shipZip || shippingPriceEle == '' || countryCode != shipCountry) && shipZip != '' && shipZip.length > 4) {
                    postalCode = shipZip;
                    var payload = {
                        postalCode: postalCode,
                        countryCode: shipCountry
                    };

                    $.post("/shared/services/ups.ashx", payload, function (r) {

                        if (r.StatusCode == "1") {
                            upsEngine.setShippingOptions(r.ShipmentQuotes);
                        } else {
                            upsEngine.setShippingOptions(false);
                        }

                    });
                }
            };

            const getShippingZip = function () {
                let zip = '';
                if (shipDiffEle.checked) {
                    zip = shippingZipEle.value;
                } else {
                    zip = billingZipEle.value;
                }

                if (zip == '') {
                    zip = document.getElementById("zc").value;
                }

                return zip;
            };

            const getCountryCode = function () {
                let country = '';
                if (shipDiffEle.checked) {
                    country = shippingCountryEle.value;
                } else {
                    country = billingCountryEle.value;
                }

                return country;
            };

            const clearShippingOptions = function () {
                shippingSkuEle.value = '';
                shippingPriceEle.value = '';
                shippingDescEle.value = '';
                upsShippingZipEle.value = '';
            };

            const setShippingValues = function () {

                const index = shippingOptionEle.value;

                if (index) {
                    const option = shippingMethods[index];

                    shippingSkuEle.value = option.ServiceCode;
                    shippingPriceEle.value = option.Total;
                    shippingDescEle.value = option.ServiceDescription;
                    upsShippingZipEle.value = postalCode;

                    shippingMethodEle.innerHTML = option.ServiceDescription;
                    setShippingTotal(option.Total);

                } else {
                    toggleShippingTotal(true);
                    clearShippingOptions();
                }

                if (typeof handleCartChange === 'function') {
                    setTimeout(function () { handleCartChange(); }, 0100);
                }
                
            };

            const toggleShippingTotal = function (hide) {
                if (hide) {
                    shippingCalloutEle.classList.add(hideClass);
                } else {
                    shippingCalloutEle.classList.remove(hideClass);
                }
            }

            const setShippingTotal = function (price) {
                let subTotal = document.getElementsByClassName("subtotal")[0].innerHTML,
                    actionQuantity = document.getElementById("ActionQuantity0").value,
                    taxTotalHtml = document.getElementsByClassName("taxtotal")[0].innerHTML,
                    taxTotal = 0;

                if (taxTotalHtml) {
                    taxTotal = parseFloat(taxTotalHtml.replace("$", ""));
                }
                let newTotal = ((price * actionQuantity) + parseFloat(subTotal.replace("$", "")) + taxTotal).toFixed(2);

                shippingOrderTotalEle.innerHTML = "$" + newTotal;
                toggleShippingTotal(false);

            };


            this.setShippingOptions = function (options) {
                shippingMethods = options;

                let optionsLength = shippingOptionEle.options.length - 1;
                for (var t = optionsLength; t >= 1; t--) {
                    shippingOptionEle.remove(t);
                }

                if (shippingMethods && shippingMethods.length > 0) {
                    for (var i = 0; i < shippingMethods.length; i ++) {
                        const optionEle = document.createElement("option"),
                            option = shippingMethods[i];

                        optionEle.value = i;
                        optionEle.innerHTML = option.ServiceDescription;
                        shippingOptionEle.appendChild(optionEle);
                    }

                    shippingOptionEle.value = "";
                    setShippingValues();
                }
            };

            this.Init = function () {
                billingZipEle.addEventListener("change", getShippingOptions);
                shippingZipEle.addEventListener("change", getShippingOptions);
                billingZipEle.addEventListener("input", getShippingOptions);
                shippingZipEle.addEventListener("input", getShippingOptions);
                billingCountryEle.addEventListener("change", getShippingOptions);
                shippingCountryEle.addEventListener("change", getShippingOptions);
                shippingOptionEle.addEventListener("change", setShippingValues);

                window.addEventListener("DOMContentLoaded", function () {
                    getShippingOptions();
                    const zipCodes = document.getElementsByClassName("zc");

                    for (var i = 0; i < zipCodes.length; i++) {
                        zipCodes[i].addEventListener("change", getShippingOptions);
                    }
                });

               addEventListener("CartChange", function () {
                    const index = shippingOptionEle.value;

                    if (index) {
                        const option = shippingMethods[index];
                        setShippingTotal(option.Total);
                    }
                    
                });

                addEventListener("GoogleAutoComplete_AddressUpdated", function () {
                    getShippingOptions();
                });
            };

        };

        var upsEngine = new UPSShippingEngine();
        upsEngine.Init();

        function onFormPostValidation() {
            let errors = [],
                option = document.getElementById("UPSShippingSku").value;
            if (!option) {
                errors.push("Please select a shipping option");
            }

            return errors;
        }

    </script>
</fieldset>
