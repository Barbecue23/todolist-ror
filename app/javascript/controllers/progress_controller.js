import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fill", "number"]
  static values = { percent: Number }

  connect() {
    requestAnimationFrame(() => {
      if (this.hasFillTarget) {
        this.fillTarget.style.width = `${this.percentValue}%`
      }
      this.animateNumber(this.percentValue)
    })
  }

  animateNumber(to) {
    if (!this.hasNumberTarget) return

    const from = Number(this.numberTarget.textContent) || 0
    if (from === to) {
      this.numberTarget.textContent = to
      return
    }

    const duration = 500
    const start = performance.now()

    const tick = (now) => {
      const progress = Math.min((now - start) / duration, 1)
      const eased = 1 - Math.pow(1 - progress, 3)
      this.numberTarget.textContent = Math.round(from + (to - from) * eased)
      if (progress < 1) requestAnimationFrame(tick)
    }

    requestAnimationFrame(tick)
  }
}
