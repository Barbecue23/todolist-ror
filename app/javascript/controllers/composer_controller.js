import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    this.formTarget?.addEventListener("turbo:submit-end", this.reset)
  }

  disconnect() {
    this.formTarget?.removeEventListener("turbo:submit-end", this.reset)
  }

  reset = (event) => {
    if (!event.detail.success) return
    this.formTarget?.reset()
    this.inputTarget?.focus()
  }
}
