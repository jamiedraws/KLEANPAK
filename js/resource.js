(function (global) {
    if ("app" in global) {
        const resource = app.createContext(app);

        resource.addProperties({
            /**
             * creates a new HTML element
             * and goes through each attribute pair and sets the attribute name and value
             * then returns the element
             * @param {string} tag the name of the HTML tag to create
             * @param {object} attributes the object containing the tag's attribute name and value pairs
             */
            createElement: function (tag, attributes) {
                const element = document.createElement(tag);
                if (typeof attributes === "object") {
                    Object.keys(attributes).forEach(function (attribute) {
                        element.setAttribute(attribute, attributes[attribute]);
                    });
                }
                return element;
            },

            /**
             * creates a new HTML element
             * and appends it to the document body
             * @param {string} tag name of the HTML element to be appended
             * @return {object} list of attributes and values associated with the element
             */
            appendElement: function (tag, attributes) {
                const element = this.createElement(tag, attributes);
                document.body.appendChild(element);
                return element;
            },

            /**
             * creates a new HTML element using the value of "ele",
             * sets the src attribute to the value of "src",
             * optionally applies other attributes
             * and appends to the end of the document body
             * @param {string} src representation of a url source
             * @param {string} tag representation of an HTML element to create in the document
             * @param {object} attributes optional object of HTML attribute value pairs to add to the created element
             * @return {node} html element with the resource request attached or false if failure occurs
             */
            requestResource: function (src, tag, attributes) {
                if (typeof src !== "string") {
                    console.warn("Cannot request a resource without a valid URL");
                    return false;
                }
     
                if (typeof tag !== "string") {
                    console.warn("Cannot request a resource without a valid element");
                    return false;
                }
     
                if (typeof attributes === "object") {
                    if (tag === "link") {
                        attributes.href = src;
                    } else {
                        attributes.src = src;
                    }
                } else {
                    if (tag === "link") {
                        attributes = { href: src };
                    } else {
                        attributes = { src: src };
                    }
                }
     
                try {
                    return this.appendElement(tag, attributes);
                } catch (error) {
                    console.log(error);
                    return false;
                }
            },

            /**
             * uses an array of JavaScript url resources as "strings"
             * and dispatches a request for the resource.
             * if the response returns with HTTP status code 200, a callback function "success" will fire
             * otherwise, the next request will be dispatched
             * if none of the url resources return with HTTP status code 200, a "fail" callback function will fire
             * @param {array} srcset an array of url sources
             * @param {function} success callback function when the first url returns a HTTP status code of 200
             * @param {function} fail callback function when none of the urls return a HTTP status code of 200
             */
            requestScriptOrFallback: function (srcset, success, fail) {
                const dispatch = function (index) {
                    const val = srcset[index];
                    if (typeof val === "undefined") {
                        if (typeof fail === "function") {
                            fail();
                        }
                        return false;
                    }
                    const response = this.requestResource(val, "script");
                    response.onerror = function () {
                        index = index + 1;
                        dispatch(index);
                    };
                    response.onload = success;
                };
                dispatch(0);
            }
        });

        app.addProperty("resource", resource);
    }
}(window));