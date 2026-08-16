import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.stagger()
  }

  itemTargetConnected(element) {
    const index = this.itemTargets.indexOf(element)
    element.style.animationDelay = `${Math.min(index, 12) * 40}ms`
  }

  stagger() {
    this.itemTargets.forEach((item, index) => {
      item.style.animationDelay = `${Math.min(index, 12) * 40}ms`
    })
  }
}
