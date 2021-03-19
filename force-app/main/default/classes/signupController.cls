public with sharing class signupController {

    @AuraEnabled
    public static String signupAsMentee () {
        //create Progress Tracker
        Progress_Tracker__c pgTrack = new Progress_Tracker__c ();
        insert pgTrack;

        //create Mentee user
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        MentorAmp_User__c newMentee = new MentorAmp_User__c (User__c = currentUserId, Name__c = 'First Mentee', RecordTypeId = menteeRecordTypeId, Progress_Tracker__c = pgTrack.Id);
        try {
            insert newMentee;
            return 'Success: Mentee user was created';
        } 
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}
