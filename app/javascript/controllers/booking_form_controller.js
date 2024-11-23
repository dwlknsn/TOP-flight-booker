import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "passengerCount", "passengerForm", "passengerTemplate" ]
  static classes = []
  static values = { passengerCount: {type: Number} }

  connect() {
    this.passengerCountValueChanged()
  }

  addPassenger() {
    const template_clone = this.passengerTemplateTarget.content.cloneNode(true)
    const wrapper = template_clone.querySelector("div")
    const name_label = wrapper.querySelector("label[for=name]")
    const name_input = wrapper.querySelector("input#name")
    const email_label = wrapper.querySelector("label[for=email]")
    const email_input = wrapper.querySelector("input#email")

    name_label.setAttribute("for", `booking_passengers_attributes_${this.passengerCountValue}_name`)
    name_input.setAttribute("name", `booking[passengers_attributes][${this.passengerCountValue}][name]`)

    email_label.setAttribute("for", `booking_passengers_attributes_${this.passengerCountValue}_email`)
    email_input.setAttribute("name", `booking[passengers_attributes][${this.passengerCountValue}][email]`)

    this.passengerFormTarget.appendChild(wrapper)
    this.passengerCountValue += 1
  }

  removePassenger(event) {
    if (this.passengerCountValue <= 1) {
      this.alertMinimumPassengers()
      return
    }

    event.target.closest("div").remove()
    this.passengerCountValue -= 1
  }

  passengerCountValueChanged() {
    this.passengerCountTarget.textContent = this.passengerCountValue
  }

  alertMinimumPassengers() {
    alert("You must have at least one passenger.")
  }
}
