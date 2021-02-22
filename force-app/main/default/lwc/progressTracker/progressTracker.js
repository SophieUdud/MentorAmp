import { LightningElement, wire } from 'lwc';
import createCategory from '@salesforce/apex/datatableController.createCategory';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ProgressTracker extends LightningElement {

    renderedCallback() {
        if (this.isTrackerOpen) {
            this.template.querySelector('c-datatable').refreshCategories();
        }
    }

    isTrackerOpen = false;
    isFormOpen = false;

    openTracker() {
        this.isTrackerOpen = true;
    }
    closeTracker() {
        this.isTrackerOpen = false;
    }

    openForm() {
        this.isFormOpen = true;
        this.isTrackerOpen = false;
    }
    closeForm() {
        this.isFormOpen = false;
        this.isTrackerOpen = true;
    }

    nameInput = '';
    goalInput = '';

    changeNameInput(event) {
        this.nameInput = event.target.value;
    }
    changeGoalInput(event) {
        this.goalInput = event.target.value;
    }

    async addCategory() {
        await createCategory({name: this.nameInput, goal: this.goalInput})
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Category was added',
                    variant: 'success'
                })
            );
            this.closeForm();
                
       }).catch(error => {
           this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error adding new category',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}