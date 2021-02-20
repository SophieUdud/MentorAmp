import { LightningElement,track } from 'lwc';

export default class ModalPopupLWC extends LightningElement {
    @track isModalOpen = false;
    @track currentStep;
    isMentor;
    _selected = [];

    get options() {
        return [
            { label: 'Cooking', value: 'Cooking'},
            { label: 'Diving', value: 'Diving' },
            { label: 'Martial Arts', value: 'Martial Arts' },
            { label: 'Coding', value: 'Coding' },
            { label: 'Finances', value: 'Finances' },
            { label: 'Soft skills', value: 'Soft skills' },
            { label: 'Meditation', value: 'Meditation' },
            { label: 'Creative Writting', value: 'Creative Writting' },
            { label: 'Photography', value: 'ja' },
        ];
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
        this.currentStep = '1';
        this.isMentor = false;
    }
    
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }

    goBackToStepOne() {
        this.currentStep = '1';
        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template.querySelector('div.stepOne').classList.remove('slds-hide');
    }

    goToStepTwoMentee() {
        this.currentStep = '2';
        this.isMentor = false;
        this.template.querySelector('div.stepOne').classList.add('slds-hide');
        this.template.querySelector('div.stepTwo').classList.remove('slds-hide');
    }

    goToStepTwoMentor() {
        this.currentStep = '2';
        this.isMentor = true;
        this.template.querySelector('div.stepOne').classList.add('slds-hide');
        this.template.querySelector('div.stepTwo').classList.remove('slds-hide');
    }

    goBackToStepTwo() {
        this.currentStep = '2';
        this.template.querySelector('div.stepThree').classList.add('slds-hide');
        this.template.querySelector('div.stepTwo').classList.remove('slds-hide');
    }

    goToStepThree() {
        this.currentStep = '3';
        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template.querySelector('div.stepThree').classList.remove('slds-hide');
    }

    handleChange(e) {
        this._selected = e.detail.value;
    }
}