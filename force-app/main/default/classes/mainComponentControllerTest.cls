@isTest
public class mainComponentControllerTest {

    @isTest
    public static void getMentorAmpUserTest () {
        User testUser = TestFactory.insertTestUser();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();

        System.runAs(testUser) {
            System.assertEquals('notSignedUp', mainComponentController.getMentorAmpUser());

            MentorAmp_User__c newMenteeUser = new MentorAmp_User__c (User__c = testUser.Id, RecordTypeId = menteeRecordTypeId);
            insert newMenteeUser;
            System.assertEquals('onlyMentee', mainComponentController.getMentorAmpUser());

            MentorAmp_User__c newMentorUser = new MentorAmp_User__c (User__c = testUser.Id, RecordTypeId = mentorRecordTypeId);
            insert newMentorUser;
            System.assertEquals('both', mainComponentController.getMentorAmpUser());

            MentorAmp_User__c userToDelete = [SELECT Id, Name FROM MentorAmp_User__c WHERE Id =: newMenteeUser.Id];
            delete userToDelete;
            System.assertEquals('onlyMentor', mainComponentController.getMentorAmpUser());
        }
    }

    @isTest
    public static void getMentorNameTest () {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        User testUser2 = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg2.com'];
        System.runAs(testUser2) {
            System.assertEquals('First Mentor', mainComponentController.getMentorName());
        }
        System.runAs(testUser) {
            System.assertEquals('No mentor has been assigned yet', mainComponentController.getMentorName());
        }
    }

    @isTest
    public static void getMenteeNameTest () {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        User testUser2 = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg2.com'];
        System.runAs(testUser) {
            System.assertEquals('Second Mentee', mainComponentController.getMenteeName());
        }
        MentorAmp_User__c menteeToDelete = [SELECT Id, Name__c FROM MentorAmp_User__c WHERE Name__c = 'Second Mentee'];
        delete menteeToDelete;

        System.runAs(testUser) {
            System.assertEquals('No mentee has been assigned yet', mainComponentController.getMenteeName());
        }
    }

    @isTest
    public static void getCategoriesTest () {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        List<Category__c> catList1 = [SELECT Id, Name FROM Category__c WHERE Name = 'Test Category'];
        List<Category__c> catList2 = [SELECT Id, Name FROM Category__c WHERE Name = 'Test Category2'];

        System.runAs(testUser) {
            List<Category__c> getCategories1 = mainComponentController.getCategories(true, false);
            System.assertEquals(catList1[0].Name, getCategories1[0].Name);

            List<Category__c> getCategories2 = mainComponentController.getCategories(false, true);
            System.assertEquals(catList2[0].Name, getCategories2[0].Name);
        }
    }

    @isTest
    public static void getCurrentWeekTest () {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        System.runAs(testUser) {
            System.assertEquals('week2', mainComponentController.getCurrentWeek(true, false));
            System.assertEquals('week3', mainComponentController.getCurrentWeek(false, true));
        }
    }

    @isTest
    public static void updateCurrentWeekTest () {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        System.runAs(testUser) {
            System.assertEquals('Success: Progress Tracker updated successfully', mainComponentController.updateCurrentWeek('week3', true, false));
            System.assertEquals('Success: Progress Tracker updated successfully', mainComponentController.updateCurrentWeek('week4', false, true));
        }
    }
}
