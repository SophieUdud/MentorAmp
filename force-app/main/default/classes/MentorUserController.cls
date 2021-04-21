public with sharing class MentorUserController {
    @AuraEnabled
    public static void saveUserRecord(MentorAmp_User__c user) {
        if(user != null){
            insert user;
        } 
    }
}
