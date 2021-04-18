public with sharing class TestFactory {
    
    public static User insertTestUser () {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 
        User testUser = new User(Alias = 'standt', Email='mentoramp@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='mentoramp@testorg.com');
        insert testUser;
        return testUser;
    }

    public static User insertTestUser2 () {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; 
        User testUser2 = new User(Alias = 'standt', Email='mentoramp@testorg2.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='mentoramp@testorg2.com');
        insert testUser2;
        return testUser2;
    }

    public static void insertTestData () {
        User testUser = insertTestUser();
        User testUser2 = insertTestUser2();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();

        Progress_Tracker__c pgTrack1 = new Progress_Tracker__c(Current_Week__c = 'week2');
        insert pgTrack1;
        Category__c category1 = new Category__c (Name = 'Test Category', Progress_Tracker__c = pgTrack1.Id);
        insert category1;

        Progress_Tracker__c pgTrack2 = new Progress_Tracker__c(Current_Week__c = 'week3');
        insert pgTrack2;
        Category__c category2 = new Category__c (Name = 'Test Category2', Progress_Tracker__c = pgTrack2.Id);
        insert category2;

        MentorAmp_User__c firstMentorUser = new MentorAmp_User__c (User__c = testUser.Id, RecordTypeId = mentorRecordTypeId, Name__c = 'First Mentor');
        insert firstMentorUser;
        MentorAmp_User__c firstMenteeUser = new MentorAmp_User__c (User__c = testUser.Id, RecordTypeId = menteeRecordTypeId, Progress_Tracker__c = pgTrack1.Id, Name__c = 'First Mentee');
        insert firstMenteeUser;
        MentorAmp_User__c secondMenteeUser = new MentorAmp_User__c (User__c = testUser2.Id, RecordTypeId = menteeRecordTypeId, MentorAmp_User__c = firstMentorUser.Id, Progress_Tracker__c = pgTrack2.Id, Name__c = 'Second Mentee');
        insert secondMenteeUser;
    }
}
