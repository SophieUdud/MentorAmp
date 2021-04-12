import { LightningElement } from "lwc";

export default class Main extends LightningElement {
    openSignup () {
        this.template.querySelector("c-signup").openModal();
    }
}