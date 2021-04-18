import { LightningElement, wire, api, track } from 'lwc';
import getCategories from '@salesforce/apex/datatableController.getCategories';
import updateCategories from '@salesforce/apex/datatableController.updateCategories';
//import createCategory from '@salesforce/apex/datatableController.createCategory';
import deleteCategory from '@salesforce/apex/datatableController.deleteCategory';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


const COLS = [
    {label: '', type: 'button-icon', fixedWidth: 50, typeAttributes: { name: 'deleteCategory', iconName: 'utility:delete', variant: 'container', title: 'Delete Category', alternativeText: 'Delete Category', class:'deleteIcon'}},
    { label: 'Category', fieldName: 'Name', editable: true, hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', editable: true, hideDefaultActions: true, wrapText: true },
    { label: 'Week 1', fieldName: 'Week_1__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 2', fieldName: 'Week_2__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 3', fieldName: 'Week_3__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 4', fieldName: 'Week_4__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 5', fieldName: 'Week_5__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 6', fieldName: 'Week_6__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 7', fieldName: 'Week_7__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } },
    { label: 'Week 8', fieldName: 'Week_8__c', type: 'boolean', editable: true, hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const actions = [
    { label: 'Delete', name: 'delete' }
];

export default class Datatable extends LightningElement {

    @api openAsMentor = false;
    
    @api refreshCategories () {
        refreshApex(this.categories);
    }

    columns = COLS;
    draftValues = [];

    @wire(getCategories, { getMentorCategories : '$openAsMentor' })
    categories;

    rowToDelete = {};

    handleRowAction (event) {
        const action = event.detail.action;
        const row = event.detail.row; 
        if (action.name === "deleteCategory") {
            this.rowToDelete = row;
            this.isDeleteWindowOpen = true;
            this.deleteCategory();
        }
    }

    deleteCategory (){
        deleteCategory({categoryId: this.rowToDelete.Id })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Category was deleted',
                    variant: 'success'
                })
            );
            refreshApex(this.categories);
            this.rowToDelete = {};
            this.isDeleteWindowOpen = false;
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

    async handleDatatableUpdate(event) {
        const updatedFields = event.detail.draftValues; 
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });

        await updateCategories({data: updatedFields})
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Your changes are saved',
                    variant: 'success'
                })
            );
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
    
            // Display fresh data in the datatable
            refreshApex(this.categories).then(() => {
                this.draftValues = [];
            });
       }).catch(error => {
           this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or refreshing records',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}