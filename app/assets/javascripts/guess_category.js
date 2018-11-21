class GuessCategory {
    constructor(input) {
        this.descriptionInput = input;
        this.categorySelect = $(input.dataset.target);

        // whenever the user manually selected a category, we disable guessing
        // so that a manual choice always has priority
        this.categoryManuallySelected = false;
    }

    initialize() {
        if(this.categorySelect.val()) {
            this.categoryManuallySelected = true;
        }

        $(this.descriptionInput).on("change", () => this.updateCategory());
        $(this.categorySelect).on("change", () => this.categoryManuallySelected = true);
    }

    updateCategory() {
        if(this.categoryManuallySelected) return;

        $.ajax({ url: "/expenses/guess_category", data: { description: this.descriptionInput.value } })
            .done((data) => {
                if(data.category_id) {
                    this.categorySelect.val(data.category_id);
                }
            });
    }
}

$(() => {
    $(".guess-category").each((i, e) => new GuessCategory(e).initialize())
});
