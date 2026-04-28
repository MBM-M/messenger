import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter", "count", "submit"]

  static values = {
    maxLength: 1000
  }

  connect() {
    this.updateCounter()
  }

  updateCounter() {
    const length = this.inputTarget.value.length
    const remaining = this.maxLengthValue - length

    this.countTarget.textContent = length

    this.counterTarget.classList.remove('warning', 'error')

    if (remaining < 50) {
      this.counterTarget.classList.add('warning')
    }

    if (remaining <= 0) {
      this.counterTarget.classList.add('error')
      this.submitTarget.disabled = true
    } else {
      this.submitTarget.disabled = false
    }
  }

  validate(event) {
    if (this.inputTarget.value.trim().length === 0) {
      event.preventDefault()
      this.inputTarget.focus()
      return false
    }
  }

  submitAfterSend(event) {
    this.inputTarget.value = ''
    this.updateCounter()
    this.inputTarget.focus()
  }
}
