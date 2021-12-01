import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static values = { title: String, url: String }

  connect() {
    Turbo.navigator.history.push(this.urlValue);
    document.title = this.titleValue;
  }
}