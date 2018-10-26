class ReloadOnSelect {
    constructor(select) {
        this.select = select;
    }

    initialize() {
        $(this.select).on("change", () => this.triggerPageReload());
    }

    triggerPageReload() {
        let path = this.select.dataset.path;
        let param = this.select.dataset.param;
        let location = window.location;

        // TODO: improve URL building
        location.replace(path + "?" + param + "=" + this.select.value);
    }
}

$(() => {
    $(".reload-on-select").each((i, s) => new ReloadOnSelect(s).initialize())
});
