import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    const navbar = this.element
    const menu = document.getElementById('navbarMenu')

    navbar.classList.toggle('is-active')
    menu.classList.toggle('is-active')
  }
}
