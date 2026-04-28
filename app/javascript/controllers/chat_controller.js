import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages"]
  static values = { userId: String }

  connect() {
    this.scrollToBottom()
  }

  messagesTargetConnected(element) {
    this.scrollToBottom()
    this.styleNewMessages()
  }

  styleNewMessages() {
    // Find messages that haven't been styled yet (no own/other class)
    const unstyledMessages = this.messagesTarget.querySelectorAll('.message:not(.own-message):not(.other-message)')
    unstyledMessages.forEach(message => this.styleMessage(message))
  }

  styleMessage(element) {
    const messageUserId = element.dataset.messageUserId
    if (!messageUserId) return

    if (messageUserId === this.userIdValue) {
      element.classList.add('own-message')

      // Hide header for own messages
      const header = element.querySelector('.message-header')
      if (header) header.style.display = 'none'
    } else {
      element.classList.add('other-message')

      // Show header for other messages
      const header = element.querySelector('.message-header')
      if (header) header.style.display = 'flex'
    }
  }

  clearInput() {
    const input = document.getElementById('message-input')
    const counter = document.getElementById('message-count')

    if (input) {
      input.value = ''
      input.focus()
    }

    if (counter) {
      counter.textContent = '0'
    }
  }

  scrollToBottom() {
    setTimeout(() => {
      const messagesContainer = this.messagesTarget
      messagesContainer.scrollTop = messagesContainer.scrollHeight
    }, 50)
  }
}
