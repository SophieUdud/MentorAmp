public with sharing class MentorUserController {
    @AuraEnabled
    public static void saveUserRecord(MentorAmp_User__c user) {
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        if(user != null){
            if (user.RecordTypeId == menteeRecordTypeId) {
                Progress_Tracker__c pgTrack = new Progress_Tracker__c();
                insert pgTrack;
                user.Progress_Tracker__c = pgTrack.Id;
            }
            insert user;
        } 
    }
}
