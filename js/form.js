(function (global) {
    if ("app" in global) {
        app.require(["resource"], function () {
            const addView = function (className, viewState) {
                let result = undefined;
                const view = document.getElementsByClassName(className)[0];
        
                if (view) {
                    const state = viewState || "is-hidden";
                    result = Object.create({}, {
                        root: {
                            value: view
                        },
                        show: {
                            value: function (event) {
                                if (app.isObject(event)) {
                                    event.preventDefault();
                                }
                                view.classList.add(state);
                            }
                        },
                        hide: {
                            value: function () {
                                view.classList.remove(state);
                            }
                        }
                    });
                }
                return result;
            };

            const form = app.addProperty("form", addView("c-view", "c-view--pop"));

            if (app.form) {
                const css = app.resource.requestResource("/css/form.modal.css", "link", {
                    rel: "stylesheet"
                });
                
                if (css) {
                    app.listen(document.querySelectorAll("[href='#lead']"), app.form.show);
                    app.listen(document.querySelector(".c-view__close"), app.form.hide);
                    app.listen(document.querySelector(".c-view__underlay"), app.form.hide);
                }
            }
        });
    }
}(window));