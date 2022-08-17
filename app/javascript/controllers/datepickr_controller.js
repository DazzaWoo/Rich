import { Controller } from "stimulus"
import picker from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

export default class extends Controller {
  connect() {
    // console.log(picker);
    picker(this.element)
  }
}
