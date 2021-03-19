import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getMentorAmpUser from '@salesforce/apex/mainComponentController.getMentorAmpUser';
import getMentorName from '@salesforce/apex/mainComponentController.getMentorName';
import getMenteeName from '@salesforce/apex/mainComponentController.getMenteeName';
import getMenteeCategories from '@salesforce/apex/mainComponentController.getMenteeCategories';
import getCurrentWeek from '@salesforce/apex/mainComponentController.getCurrentWeek';
import updateCurrentWeek from '@salesforce/apex/mainComponentController.updateCurrentWeek';

const COLS1 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 1', fieldName: 'mtAmp__Week_1__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS2 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 2', fieldName: 'mtAmp__Week_2__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS3 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 3', fieldName: 'mtAmp__Week_3__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS4 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 4', fieldName: 'mtAmp__Week_4__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS5 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 5', fieldName: 'mtAmp__Week_5__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS6 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 6', fieldName: 'mtAmp__Week_6__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS7 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 7', fieldName: 'mtAmp__Week_7__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS8 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'mtAmp__Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 8', fieldName: 'mtAmp__Week_8__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

export default class Main extends LightningElement {

    renderedCallback() {
        let week = this.currentWeek.data;
        switch (week) {
            case 'week1':
              this.columns = COLS1;
              break;
            case 'week2':
              this.columns = COLS2;
              break;
            case 'week3':
              this.columns = COLS3;
              break;
            case 'week4':
              this.columns = COLS4;
              break;
            case 'week5':
              this.columns = COLS5;
              break;
            case 'week6':
              this.columns = COLS6;
              break;
            case 'week7':
              this.columns = COLS7;
              break;
            case 'week8':
              this.columns = COLS8;
              break;
        };
    }

    notSignedUp = false;
    onlyMentee = false;
    onlyMentor = false;
    both = false;

    showMenteeView = false;
    showMentorView = false;

    columns = '';

    @wire(getMenteeCategories, {})
    menteeCategories;

    refreshCategories () {
        refreshApex(this.menteeCategories);
    }
    
    @wire(getMentorAmpUser, {})
    mtAmpUsers ({ error, data }) {
        if (data == 'notSignedUp') {
            this.notSignedUp = true;
        } else if (data == 'onlyMentee') {
            this.onlyMentee = true;
        } else if (data == 'onlyMentor') {
            this.onlyMentor = true;
        } else if (data == 'both'){
            this.both = true;
            this.showMenteeView = true;
        }
    }

    refreshView() {
        console.log('refresh view7');
        //eval("$A.get('e.force:refreshView').fire();");
        //window.reload();
        //refreshApex(this.onlyMentee);
        location.reload();
    }

    @wire(getMentorName, {})
    mentorName;

    @wire(getMenteeName, {})
    menteeName;

    @wire(getCurrentWeek, {})
    currentWeek;

    get weekOptions() {
        return [
            { label: 'Week 1', value: 'week1' },
            { label: 'Week 2', value: 'week2' },
            { label: 'Week 3', value: 'week3' },
            { label: 'Week 4', value: 'week4' },
            { label: 'Week 5', value: 'week5' },
            { label: 'Week 6', value: 'week6' },
            { label: 'Week 7', value: 'week7' },
            { label: 'Week 8', value: 'week8' }
        ];
    }

    changeWeek (event) {
        let week = event.detail.value;
        switch (week) {
            case 'week1':
              this.columns = COLS1;
              break;
            case 'week2':
              this.columns = COLS2;
              break;
            case 'week3':
              this.columns = COLS3;
              break;
            case 'week4':
              this.columns = COLS4;
              break;
            case 'week5':
              this.columns = COLS5;
              break;
            case 'week6':
              this.columns = COLS6;
              break;
            case 'week7':
              this.columns = COLS7;
              break;
            case 'week8':
              this.columns = COLS8;
              break;
        };
        updateCurrentWeek({ newWeek: week })
            .then((result) => {
                refreshApex(this.currentWeek);
            });
    }

    get viewOptions() {
        return [
            { label: 'Mentee View', value: 'mentee' },
            { label: 'Mentor View', value: 'mentor' },
        ];
    }

    viewValue = 'mentee';

    changeView (event) {
        let view = event.detail.value;
        if (view === 'mentee') {
            this.showMenteeView = true;
            this.showMentorView = false;
        } else if (view === 'mentor') {
            this.showMenteeView = false;
            this.showMentorView = true;
        }
    }

    openTracker () {
        this.template.querySelector('c-progress-tracker').openTracker();
    }

    signupAsMentor () {
        this.template.querySelector('c-signup').openModal();
    }

    openSignup () {
        this.template.querySelector('c-signup').openModal();
    }

}