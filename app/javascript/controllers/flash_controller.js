import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    setTimeout( () => {
      this.element.remove()
    }, 3000)
  }
  close() {
    this.element.remove()
  }
}
