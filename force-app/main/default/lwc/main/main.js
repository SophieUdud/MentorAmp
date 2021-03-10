import { LightningElement, wire } from 'lwc';
import getMentorAmpUser from '@salesforce/apex/mainComponentController.getMentorAmpUser';

export default class Main extends LightningElement {

    notSignedUp = false;
    onlyMentee = false;
    onlyMentor = false;
    both = false;

    showMenteeView = false;
    showMentorView = false;
    
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

    get options() {
        return [
            { label: 'Mentee View', value: 'mentee' },
            { label: 'Mentor View', value: 'mentor' },
        ];
    }

    value = 'mentee';

    changeView (event) {
        let view = event.detail.value;
        console.log('view: ' + view);
        if (view === 'mentee') {
            this.showMenteeView = true;
            this.showMentorView = false;
        } else if (view === 'mentor') {
            this.showMenteeView = false;
            this.showMentorView = true;
        }
    }

}