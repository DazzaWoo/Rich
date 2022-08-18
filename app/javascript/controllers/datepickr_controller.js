import { Controller } from "stimulus"
import picker from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

export default class extends Controller {
  connect() {
    const datePicker = picker(this.element)

    Rails.ajax({
      url: "/api/v1/articles/not_available_dates",
      type: "get",
      success: (disable) => {
        console.log(datePicker)
        datePicker.set({ disable: disable })
      },
      error: (err) => {
        console.log("error" + err)
      },
    })
  }
}
