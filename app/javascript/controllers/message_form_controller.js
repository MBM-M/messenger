import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]

  updateCounter(event) {
    const input = event.target
    const length = input.value.length
    const maxLength = input.maxLength
    const countSpan = document.getElementById('message-count')

    if (countSpan) {
      countSpan.textContent = length
    }

    this.counterTarget.classList.remove('warning', 'error')

    if (length > maxLength - 50) {
      this.counterTarget.classList.add('warning')
    }

    if (length >= maxLength) {
      this.counterTarget.classList.add('error')
    }
  }

  validate(event) {
    const input = document.getElementById('message-input')
    if (input && input.value.trim().length === 0) {
      event.preventDefault()
      input.focus()
    }
  }
}
