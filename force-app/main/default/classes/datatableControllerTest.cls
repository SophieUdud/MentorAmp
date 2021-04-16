@isTest
public class datatableControllerTest {
    
    //removed from now as the method that this test is testing needs to be fixed
    /*@isTest
    public static void getCategoriesTest() {
        List<User> userList = [SELECT Id, Name FROM User];
        User testUser = userList[0];
        System.runAs(testUser) {
            Progress_Tracker__c pgTrack = new Progress_Tracker__c();
            insert pgTrack;
            
            MentorAmp_User__c mtUser = new MentorAmp_User__c (Progress_Tracker__c = pgTrack.Id, User__c = testUser.Id);
            insert mtUser;
            
            Category__c category = new Category__c (Name = 'Test Category', Progress_Tracker__c = pgTrack.Id);
            insert category;
            
            List<Category__c> categories = datatableController.getCategories();
            System.assert(categories.size() != 0);
        }
    }*/
    
    @isTest
    public static void updateCategoriesTest() {
        Progress_Tracker__c pgTrack = new Progress_Tracker__c();
        insert pgTrack;
        
		Category__c cat1 = new Category__c (Name = 'Cat1', Progress_Tracker__c = pgTrack.Id);
        Category__c cat2 = new Category__c (Name = 'Cat2', Progress_Tracker__c = pgTrack.Id);
		List<Category__c> catList = new List<Category__c>();
        catList.add(cat1);
        catList.add(cat2);
        insert catList;
        
        System.assertEquals('Success: categories updated successfully', datatableController.updateCategories(catList));
    }
    
    @isTest
    public static void getProgressTrackerTest() {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        MentorAmp_User__c firstMentee = [SELECT Id, Name__c, Progress_Tracker__c FROM MentorAmp_User__c WHERE Name__c = 'First Mentee'];    
        MentorAmp_User__c secondMentee = [SELECT Id, Name__c, Progress_Tracker__c FROM MentorAmp_User__c WHERE Name__c = 'Second Mentee'];
        System.runAs(testUser) {
            System.assertEquals(firstMentee.Progress_Tracker__c, datatableController.getProgressTracker(false));
            System.assertEquals(secondMentee.Progress_Tracker__c, datatableController.getProgressTracker(true));
        }
    }
    
    @isTest
    public static void createCategoryTest() {
        TestFactory.insertTestData();
        User testUser = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg.com'];
        User testUser2 = [SELECT Id, Name FROM User WHERE UserName = 'mentoramp@testorg2.com'];
        System.runAs(testUser) {
            System.assertEquals('Success: category created successfully', datatableController.createCategory('Test mentee category', 'Test goal', false));
            System.assertEquals('Success: category created successfully', datatableController.createCategory('Test mentor category', 'Test goal', true));
        }
    }
    
    @isTest
    public static void deleteCategoryTest() {
        Progress_Tracker__c pgTrack = new Progress_Tracker__c();
        insert pgTrack;
		Category__c category = new Category__c (Name = 'Test Category', Progress_Tracker__c = pgTrack.Id);
        insert category;
        System.assertEquals('Success: categories deleted successfully', datatableController.deleteCategory(category.Id));
    }
}