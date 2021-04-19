import { LightningElement, track, api, wire } from "lwc";
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getUserInfo from '@salesforce/apex/userInfoController.getUserInfo';
import saveUserRecord from '@salesforce/apex/MentorUserController.saveUserRecord';
import getMenteeRecordType from '@salesforce/apex/RecordTypeController.getMenteeRecordType';
import getMentorRecordType from '@salesforce/apex/RecordTypeController.getMentorRecordType';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import MentorUser_OBJECT from '@salesforce/schema/MentorAmp_User__c';

export default class ModalPopupLWC extends LightningElement {
    isModalOpen = false;
    currentStep;
    userName;
    userEmail;
    userMobile; 
    menteeRecordTypeId;
    mentorRecordTypeId;
    isSavedSuccess = true;
    isMentor;
    _selected = [];

    @wire(getObjectInfo, {objectApiName: MentorUser_OBJECT})
    getRecordTypeId({data, error}){
        if(data){
            const recordTypeInfos = data.recordTypeInfos;

            for (const [key, value] of Object.entries(recordTypeInfos)) {
                if (value.name === "Mentor") {
                    this.mentorRecordTypeId = value.recordTypeId;
                } else if (value.name === "Mentee"){
                    this.menteeRecordTypeId = value.recordTypeId;
                }
            }
        } else if(error){
            this.showNotification("Signup", error.message, "error");
         }
      };

    /* Calls apex to get current user's info */
    @wire(getUserInfo) getUser({data, error}){
        if(data){
            this.user = data;
            this.userName = data.Name;
            this.userEmail = data.Email;
            this.userMobile = data.MobilePhone;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.user = undefined;
            this.showNotification("Signup", error.message, "error");
        }
    }

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
        // to open modal set isModalOpen track value as true
        this.isModalOpen = true;
        this.currentStep = '1';
        this.isMentor = false;
    }

    @api
    closeModal() {
        // to close modal set isModalOpen track value as false
        this.isModalOpen = false;
    }

    saveRecord(user)
    {   
        saveUserRecord({user : user})
        .then(result => {
            // Clear the user enter values
            this.user = {};   
            this.showNotification("Signup", "Successfully signed up!", 'success');
        })
        .catch(error => {
            this.showNotification("Signup", error.message, "error");
        });
    }

    submitDetails() {
        // The skills is not being saved at this time need design
        // of how to handle saving skills
        this.isModalOpen = false;
        let user = { 'sobjectType': 'MentorAmp_User__c' };
        user.Name__c= this.userName;
        user.Email__c = this.userEmail;
        user.Phone__c = this.userMobile;
        if (this.isMentor) {
            user.RecordTypeId = this.mentorRecordTypeId;
        } else {
            user.RecordTypeId = this.menteeRecordTypeId;
        }
        this.saveRecord(user);
        this.closeModal();
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

    /* Get skill set */
    goToStepThree() {
        this.currentStep = '3';
        this.template.querySelector('div.stepTwo').classList.add('slds-hide');
        this.template.querySelector('div.stepThree').classList.remove('slds-hide');
    }

    handleChange(e) {
        this._selected = e.detail.value;
    }

    nameChange(event) {
        this.userName= event.target.value;
    }

    emailChange(event) {
        this.userEmail= event.target.value;
    }
    mobileChange(event) {
        this.userMobile= event.target.value;
    }

    showNotification(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.isSavedSuccess = true;   

        this.dispatchEvent(evt);
    }
}
