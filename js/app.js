(function (global) {
    const create = Object.create({
        addProperty: function (property, value) {
            Object.defineProperty(this, property, {
                enumerable: true,
                value: value
            });
        },
        addProperties: function (properties) {
            const access = this;
            Object.keys(properties).forEach(function (property) {
                access.addProperty(property, properties[property]);
            });
        },
        createContext: function (inherit) {
            return Object.create(inherit || Object.getPrototypeOf(this), {});
        },
        lock: function () {
            Object.freeze(this);
        }
    }, {});

    if (typeof global.app !== "object") {
        Object.defineProperty(global, "app", {
            value: create,
            writable: false,
            configurable: false
        });
    }

    app.addProperties({
        isString: function (data) {
            return typeof data === "string";
        },
        isArray: function (data) {
            return Array.isArray(data);
        },
        isFunction: function (data) {
            return typeof data === "function";
        },
        isObject: function (data) {
            return typeof data === "object" && !this.isArray(data);
        },
        elementExists: function (element) {
            let result = false;
            if (element) {
                let length = element.length;
                if (length !== undefined) {
                    result = length;
                } else {
                    result = document.body.contains(element);
                }
            }
            return result;
        },
        toArray: function (collection) {
            if (collection !== null && typeof collection !== "undefined") {
                const store = [];
                const ar = store.slice.call(collection);
                return ar;
            }
        },
        listen: function (eles, method, e) {
            if (this.elementExists(eles)) {
                const elements = this.toArray(eles),
                event = e || "click";
                if (elements.length > 0) {
                    elements.forEach(function (ele) {
                        ele.addEventListener(event, method);
                    });
                } else {
                    eles.addEventListener(event, method);
                }
            }
        },
        require: function (properties, callback) {
            let status = true;
            const access = this;

            if (this.isArray(properties)) {
                properties.forEach(function (property) {
                    if (!access.hasOwnProperty(property)) {
                        status = false;
                    }
                });
                if (status && this.isFunction(callback)) {
                    callback();
                }
            }

            return status;
        }
    });
} (window));