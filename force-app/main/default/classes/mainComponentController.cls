public inherited sharing class mainComponentController {

    @AuraEnabled(cacheable=true)
    public static String getMentorAmpUser () {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        List<MentorAmp_User__c> mtUsers = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId];
        if (mtUsers.size() == 0){
            return 'notSignedUp';
        } else if (mtUsers.size() == 1 && mtUsers[0].RecordTypeId == menteeRecordTypeId) {
            return 'onlyMentee';
        } else if (mtUsers.size() == 1 && mtUsers[0].RecordTypeId == mentorRecordTypeId) {
            return 'onlyMentor';
        } else if (mtUsers.size() > 1) {
            return 'both';
        } else {
            return 'error';
        }
    }
}