import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option", "select", "notice"]

  initialize() {
      this.current_val
  }

  change(event) {
      this.optionTargets.forEach((option) => {
        if(option.value == event.target.value){
          option.style.display = "none";
        }
      })

      if (this.current_val != event.target.value) {
        this.optionTargets.forEach((option) => {
          if(option.value == this.current_val){
            option.style.display = "initial";
          }
        })
      }
      this.current_val = event.target.value;
  }

  focus(event) {
      this.current_val = event.target.value;
  }

  submit() {
      let form_complete = true;
      let notice = "";

      this.selectTargets.forEach((element) => {
        if (element.options.selectedIndex == 0) {
            form_complete = false;
        }
      })

      if(!form_complete){
        notice += "You have not ranked all the entries. ";
      }

      if (form_complete) {
        this.element.submit()
      } else {
        this.noticeTarget.innerHTML = notice;
      }
  }

}