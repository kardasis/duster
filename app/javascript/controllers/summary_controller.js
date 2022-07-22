import { Controller } from "@hotwired/stimulus"

const csrfToken = document.querySelector("[name='csrf-token']").content


export default class extends Controller {
  static targets = [ "id" ]

  async duplicate_summary() {
    if (confirm( "Make a new one like this?") == true) {
    const result = await fetch(`/run_summaries/${this.idTarget.value}/duplicate`, {
      method: 'POST',
      headers: {
        "X-CSRF-Token": csrfToken,
        'Content-type': 'application/json'
      }
    });

    location.reload();
    }
  }

  async delete_summary() {
    if (confirm( "Really delete this run?") == true) {
      const result = await fetch(`/run_summaries/${this.idTarget.value}`, {
        method: 'DELETE',
        headers: {
          "X-CSRF-Token": csrfToken,
          'Content-type': 'application/json'
        }
      });
      this.element.remove()
    }
  }
}
