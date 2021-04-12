import { LightningElement, track, api, wire } from "lwc";
import { getRecord } from 'lightning/uiRecordApi';
import getUserInfo from '@salesforce/apex/userInfoController.getUserInfo';

// import MentorAmp_User from '@salesforce/schema/MentorAmp_User__c';
// import Name from '@salesforce/schema/MentorAmp_User.Name__c';

import USER_OBJECT from '@salesforce/schema/User';

export default class ModalPopupLWC extends LightningElement {
    @track isModalOpen = true;
    @track currentStep;

    @wire(getUserInfo)
    wiredUser({data, error}){
        console.log('wiredUser: ', this.wiredUser);
        if(data){
            this.user = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.user = undefined;
        }
    }
    isMentor;
    _selected = [];

    get options() {
        return [
            { label: 'HTML - Beginner', value: 'HTML - Beginner'},
            { label: 'HTML - Intermediate', value: 'HTML - Intermediate' },
            { label: 'Java - Beginner', value: 'Java - Beginner' },
            { label: 'Java - Intermediate', value: 'Java - Intermediate' },
            { label: 'Python - Beginner', value: 'Python - Beginner' },
            { label: 'Python - Intermediate', value: 'Python - Intermediate' },
            { label: 'Time management', value: 'Time management' },
            { label: 'Flexibility', value: 'Flexibility' },
            { label: 'Taking responsibility', value: 'Taking responsibility' },
            { label: 'Creative thinking', value: 'Creative thinking' },
            { label: 'Conflict resolution', value: 'Conflit resolution' },
            { label: 'Communication & listening skills', value: 'Communication & Listening Skills' },
            { label: 'Team work', value: 'Team work' },
            { label: 'Creative thinking', value: 'Creative thinking' },
            { label: 'Excercise', value: 'Excercise' },
            { label: 'Yoga', value: 'Yoga' },
            { label: 'Implementing morr fuits and vieggies into diet', value: 'Implementing morr fuits and vieggies into diet' },
            { label: 'Eating less junk food', value: 'Eating less junk food' },
            { label: 'Healthy relationships with friends and family', value: 'Healthy relationships with friends and family' },
            { label: 'Meditation', value: 'Meditation' }
        ];
    }

    get selected() {
        return this._selected.length ? this._selected : 'none';
    }

    @api
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
        console.log('userInfo: ', this.wiredUser());   
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