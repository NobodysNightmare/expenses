class UpdateOnSelect {
    constructor(select) {
        this.select = select;
    }

    initialize() {
        $(this.select).on("change", () => this.triggerPageUpdate());
        this.triggerPageUpdate();
    }

    triggerPageUpdate() {
        let url = this.select.dataset.url;
        let target = this.select.dataset.target;
        let param = this.select.dataset.param;
        $.ajax({ url: url, data: { [param]: this.select.value } }).done((data) => $(target).html(data));
    }
}

$(() => {
    $(".update-on-select").each((i, s) => new UpdateOnSelect(s).initialize())
});
