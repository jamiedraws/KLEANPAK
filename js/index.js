(function (global) {
    if ("app" in global) {
        app.require(["defer"], function () {
            const view = app.createContext(app.defer);
            const carousel = app.createContext(app.defer);
            const media = app.createContext(app.defer);

            view.hasObserve(function () {
                Observe({
                    selector: ".view--section",
                    inRange: function (entry) {
                        entry.classList.add("view--has-intersected");
                    }
                });
            });

            media.addProperties({
                hasSource: function (id) {
                    return this.isString(this.getSource(element));
                },
                getSource: function (element) {
                    return element.dataset.srcIframe;
                },
                updateSource: function (element, id) {
                    const source = this.getSource(element);
                    return source.replace(/(\d{9})/, id);
                },
                getId: function (element) {
                    return element.dataset.videoId;
                },
                getIframe: function (element) {
                    return element.querySelector("iframe");
                },
                hasVimeo: function () {
                    return "Vimeo" in global;
                },
                setVimeo: function (iframe, callback) {
                    let result = false;
                    if (this.hasVimeo() && this.elementExists(iframe)) {
                        result = new Vimeo.Player(iframe);
                        if (this.isFunction(callback)) {
                            callback(result);
                        }
                    }
                    return result;
                },
                getCurrentButton: function (element, button) {
                    const lastSelectedButton = element.querySelector(".button--has-current-media");
                    if (this.elementExists(lastSelectedButton)) {
                        lastSelectedButton.classList.remove("button--has-current-media");
                    }
                    button.classList.add("button--has-current-media");
                }
            });

            media.hasObserve(function () {
                Observe({
                    selector: ".media",
                    inRange: function (element) {
                        const buttons = element.querySelectorAll("[data-video-id]"),
                            video = element.querySelector("[data-src-iframe]");
                        let iframe = media.getIframe(video), 
                            vimeo = false;

                        media.listen(buttons, function () {
                            media.getCurrentButton(element, this);
                            const id = media.getId(this),
                                source = media.updateSource(video, id);

                            if (!media.elementExists(iframe)) {
                                iframe = media.getIframe(video);
                                vimeo = media.setVimeo(iframe);
                            }

                            if (media.elementExists(iframe)) {
                                if (vimeo) {
                                    vimeo.loadVideo(id);
                                } else {
                                    iframe.src = source;
                                }
                            }
                        });
                    }
                });
            });

            carousel.toArray(
                document.querySelectorAll(".slide")
            ).forEach(function (slide) {
                carousel.hasObserve(function () {
                    const into = slide.querySelector(".slide__into"),
                        id = "#" + into.id;

                    Observe({
                        selector: id,
                        inRange: function () {
                            Slide.into(
                                into,
                                {
                                    container: slide,
                                    prevButton: slide.querySelector(".slide__prev"),
                                    nextButton: slide.querySelector(".slide__next"),
                                },
                                function() {
                                    const self = this;

                                    carousel.toArray(this.children).forEach(function (child) {
                                        setItemByPlaceholder(child);
                                    });

                                    self.container.classList.add("slide--is-ready");
                
                                    self.prevButton.addEventListener("click", function() {
                                        self.prev();
                                    });
                            
                                    self.nextButton.addEventListener("click", function() {
                                        self.next();
                                    });
                                }
                            );
                        }
                    });
                });
            });
        });
    }
} (window));