public with sharing class RecordTypeController {
    @AuraEnabled(cacheable=true)
    public static Id getMentorRecordType() {
        Id recordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByDeveloperName().get('Mentor').getRecordTypeId();
        System.debug(''+recordTypeId);
        return recordTypeId;
    }
    
    @AuraEnabled(cacheable=true)
    public static Id getMenteeRecordType() {
        Id recordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByDeveloperName().get('Mentee').getRecordTypeId();
        System.debug(''+recordTypeId);
        return recordTypeId;
    }
}
