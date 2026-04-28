import { Controller } from "@hotwired/stimulus"
import { enter } from "el-transition"

export default class extends Controller {
  static targets = ["messages"]

  connect() {
    this.scrollToBottom()
  }

  messagesTargetConnected(element) {
    this.scrollToBottom()
  }

  scrollToBottom() {
    const messagesContainer = this.messagesTarget
    messagesContainer.scrollTop = messagesContainer.scrollHeight
  }
}
