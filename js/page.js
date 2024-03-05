(function (global) {
    if ("app" in global) {
        const defer = app.createContext(app);
        const css = app.createContext(app);

        defer.addProperties({
            hasObserve: function (callback) {
                if ("Observe" in global) {
                    callback(Observe);
                }
            },
            isAvailable: function (selector, response) {
                let result = response || false;
                if (this.isString(selector)) {
                    const element = document.querySelector(selector);
                    if (this.elementExists(element)) {
                        result = element;
                    }
                }
                return result;
            },
            viewElement: function (config, inRangeCallback, outRangeCallback) {
                if (this.isObject(config)) {
                    let element = this.isAvailable(config.selector);
    
                    if (element && this.isString(config.state)) {
                        element = this.isAvailable(config.neighbor, element);
                        
                        this.hasObserve(function () {
                            const func = function () {},
                                inRange = inRangeCallback || func,
                                outRange = outRangeCallback || func;
    
                            Observe({
                                selector: config.selector,
                                inRange: inRange.bind(element, config),
                                outRange: outRange.bind(element, config),
                                unObserve: false
                            });
                        });
                    }
                }
            }
        });

        defer.hasObserve(function () {
            Observe({
                selector: "[data-src-img]",
                inRange: setItemByPlaceholder
            });
        
            Observe({
                selector: "[data-src-iframe]",
                inRange: function (record) {
                    setItemByPlaceholder(record, {
                        tag: "iframe",
                        src: "data-src-iframe",
                        ondemand: true
                    });
                } 
            });
        });

        defer.lock();
        app.addProperty("defer", defer);

        if ("_dtm" in global) {
            const error = document.getElementById("vse-error");
            const vse = document.querySelector(".validation-summary-errors");

            if (app.elementExists(error)) {
                _dtm.callbackAlert = function () {
                    error.scrollIntoView();
                };
            }

            if (app.elementExists(vse)) {
                error.scrollIntoView();
            }
        }

        css.addProperties({
            hasProperty: function (property) {
                let result = false;
                if (this.isString(property)) {
                    const test = document.body.style[property];
                    result = typeof test !== "undefined";
                }
                return result;
            },
            hasValue: function (property, value) {
                let result = false;
                if (this.isString(value) && this.hasProperty(property)) {
                    const element = document.createElement("div");
                    element.style[property] = value;
                    result = element.style[property] === value;
                }
                return result;
            }
        });

        app.addProperty("CSS", css);

        css.addProperty("setSticky", function (container, selector, position) {
            if (!this.hasValue("position", "sticky")) {
                if (this.isString(container)) {
                    const offset = position || 0;
                    const state = { 
                        abs : "element--is-absolute", 
                        fix : "element--is-fixed" 
                    };

                    const getElements = function (view, callback) {
                        const viewBox = view.getBoundingClientRect();
                        const elements = view.querySelectorAll(selector);
                        
                        if (app.elementExists(elements)) {
                            app.toArray(elements).forEach(function (element) {
                                const elementBox = element.getBoundingClientRect();
                                if (app.isFunction(callback)) {
                                    callback(element, elementBox, viewBox);
                                }
                            });
                        }
                    };

                    this.defer.hasObserve(function () {
                        Observe({
                            selector: container,
                            inRange: function (view) {
                                getElements(view, function (element, elementBox, viewBox) {
                                    if (viewBox.top < offset) {
                                        if (viewBox.bottom > (elementBox.height + offset)) {
                                            element.classList.add(state.fix);
                                            element.classList.remove(state.abs);
                                        } else {
                                            element.classList.remove(state.fix);
                                            element.classList.add(state.abs);
                                        }
                                    } else {
                                        element.classList.remove(state.fix);
                                        element.classList.remove(state.abs);
                                    }
                                });
                            },
                            unObserve: false
                        });
                    });
                }
            }
        });

        css.setSticky(".group--form", "#reviewOrder", 55);
    }
}(window));