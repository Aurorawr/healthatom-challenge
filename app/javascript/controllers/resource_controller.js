import { Controller } from "@hotwired/stimulus";

const RESOURCES = {
  "Agua": "L",
  "Pólvora": "grs",
  "Gas": "m3",
  "Hojas (filo)": "U",
  "Equipo maniobras": "U",
  "Lanzas relámpago": "U"
}

export default class extends Controller {
  
  static targets = [ "index", "table", "select1", "input1", "unit1", "btn1", "select2", "input2", "unit2", "btn2", "tableData" ];
  static classes = [ "toggle" ];
  static values = {resourceSelected: Boolean, resourseName: String, unit: String, resources: Array}

  initialize() {
    this.resourcesValue = JSON.parse(localStorage.getItem("resources")) || [];
    this.resourceSelectedValue = false;
    this.initializeSelect(this.select1Target, true);
    this.initializeSelect(this.select2Target);
    this.cleanInputs();
  }

  initializeSelect(selectElement, withEmpty = false) {
    let selectHtml = "";
    if (withEmpty) {
      selectHtml = '<option value="">Seleccione</option>';
    }
    Object.keys(RESOURCES).forEach(resource => selectHtml += `<option value="${resource}">${resource}</option>`);
    selectElement.innerHTML = selectHtml;
  }

  cleanInputs() {
    this.input1Target.value = "";
    this.input2Target.value = "";
  }

  validate(e) {
    const regex = /[0-9]|\./;
    if (!regex.test(e.key)) {
      e.preventDefault()
    }
  }

  select() {
    this.resourceNameValue = this.select1Target.value;
    this.unit1Target.innerHTML = RESOURCES[this.select1Target.value];
    if (!this.resourceSelectedValue) {
      this.input1Target.classList.toggle(this.toggleClass);
      this.btn1Target.classList.toggle(this.toggleClass);
      this.resourceSelectedValue = true;
    }
  }

  select2() {
    this.unit2Target.innerHTML = RESOURCES[this.select2Target.value];
  }

  add(input) {
    if (!input.value) {
      alert("Debes indicar un valor para agregar.");
      return false;
    }
    if (input.value <= 0) {
      alert("Debes indicar un valor mayor a 0 para agregar.");
      return false;
    }
    const resources = this.resourcesValue;
    resources.push({
      name: this.resourceNameValue,
      quantity: input.value,
      date: new Date().toLocaleString(),
    });
    localStorage.setItem("resources", JSON.stringify(resources));
    this.resourcesValue = resources
    this.showTable();
    return true;
  }

  addAndHide() {
    if (this.add(this.input1Target)) {
      this.indexTarget.classList.toggle(this.toggleClass);
      this.tableTarget.classList.toggle(this.toggleClass);
      this.unit2Target.innerHTML = Object.values(RESOURCES)[0];
    }
  }

  addAndClear() {
    this.resourceNameValue = this.select2Target.value;
    if (this.add(this.input2Target)) {
      this.cleanInputs()
    }
  }

  showTable() {
    let html = "";
    this.resourcesValue.forEach((resource, index) => {
      const {
        name, quantity, date
      } = resource;
      html += `<tr><td>${name}</td><td>${quantity}</td><td>${date}</td>
        <td><button data-resource-index-param="${index}" data-action="resource#delete"><i class="material-icons">delete</i></button></td>`
    });
    this.tableDataTarget.innerHTML = html;
  }

  delete({params}) {
    const confirmation = confirm("¿Está seguro que desea borrar este registro?")
    if (confirmation) {
      const resources = this.resourcesValue;
      resources.splice(params.index, 1);
      localStorage.setItem("resources", JSON.stringify(resources));
      this.resourcesValue = resources;
      this.showTable();
    }
  }
}
