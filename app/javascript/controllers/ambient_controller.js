import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["brand"]

  connect() {
    this.onMove = this.onMove.bind(this)
    window.addEventListener("pointermove", this.onMove, { passive: true })
  }

  disconnect() {
    window.removeEventListener("pointermove", this.onMove)
  }

  onMove(event) {
    const x = (event.clientX / window.innerWidth - 0.5) * 12
    const y = (event.clientY / window.innerHeight - 0.5) * 8
    document.documentElement.style.setProperty("--parallax-x", `${x}px`)
    document.documentElement.style.setProperty("--parallax-y", `${y}px`)

    if (this.hasBrandTarget) {
      this.brandTarget.style.transform = `translate3d(${x * 0.35}px, ${y * 0.25}px, 0)`
    }
  }
}
