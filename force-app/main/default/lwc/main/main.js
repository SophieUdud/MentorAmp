import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getMentorAmpUser from '@salesforce/apex/mainComponentController.getMentorAmpUser';
import getMentorName from '@salesforce/apex/mainComponentController.getMentorName';
import getMenteeName from '@salesforce/apex/mainComponentController.getMenteeName';
import getCategories from '@salesforce/apex/mainComponentController.getCategories';
import getCurrentWeek from '@salesforce/apex/mainComponentController.getCurrentWeek';
import updateCurrentWeek from '@salesforce/apex/mainComponentController.updateCurrentWeek';

const COLS1 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 1', fieldName: 'Week_1__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS2 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 2', fieldName: 'Week_2__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS3 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 3', fieldName: 'Week_3__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS4 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 4', fieldName: 'Week_4__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS5 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 5', fieldName: 'Week_5__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS6 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 6', fieldName: 'Week_6__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS7 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 7', fieldName: 'Week_7__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
];

const COLS8 = [
    { label: 'Category', fieldName: 'Name', hideDefaultActions: true, wrapText: true },
    { label: 'Weekly Goal', fieldName: 'Weekly_Goal__c', hideDefaultActions: true, wrapText: true },
    { label: 'Week 8', fieldName: 'Week_8__c', type: 'boolean', hideDefaultActions: true, initialWidth: 80, cellAttributes: { alignment: 'center' } }
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
    showMenteeView = false;
    showMentorView = false;
    both = false;

    columns = '';

    @wire(getCategories, { showingMenteeView: '$showMenteeView', showingMentorView: '$showMentorView' })
    menteeCategories;

    refreshCategories () {
        refreshApex(this.menteeCategories);
    }
    
    @wire(getMentorAmpUser, {})
    mtAmpUsers ({ error, data }) {
        if (data == 'notSignedUp') {
            this.notSignedUp = true;
        } else if (data == 'onlyMentee') {
            this.showMenteeView = true;
        } else if (data == 'onlyMentor') {
            this.showMentorView = true;
        } else if (data == 'both'){
            this.both = true;
            this.showMenteeView = true;
        }
    }

    refreshView() {
        location.reload();
    }

    @wire(getMentorName, {})
    mentorName;

    @wire(getMenteeName, {})
    menteeName;

    @wire(getCurrentWeek, { showingMenteeView: '$showMenteeView', showingMentorView: '$showMentorView' })
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
        updateCurrentWeek({ newWeek: week, showingMenteeView: this.showMenteeView, showingMentorView: this.showMentorView })
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

    get viewValue() {
      if (this.showMenteeView) {
        return 'mentee';
      } else if (this.showMentorView) {
        return 'mentor';
      }
    }

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

    openTrackerAsMentee () {
        this.template.querySelector('c-progress-tracker').openTrackerAsMentee();
    }

    openTrackerAsMentor () {
        this.template.querySelector('c-progress-tracker').openTrackerAsMentor();
    }

    signupAsMentor () {
        this.template.querySelector('c-signup').openModal();
    }

    openSignup () {
        this.template.querySelector('c-signup').openModal();
    }
}
