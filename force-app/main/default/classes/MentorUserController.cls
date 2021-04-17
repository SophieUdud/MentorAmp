public with sharing class MentorUserController {
    @AuraEnabled
    public static void saveUserRecord(MentorAmp_User__c user) {
        System.debug('User: ' + 'user => '+JSON.serialize(user));
        if(user != null){
            insert user;
        } 
    }
}
