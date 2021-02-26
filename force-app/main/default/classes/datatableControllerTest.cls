@isTest
public class datatableControllerTest {
    
    @isTest
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
    }
    
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
        
        System.debug(datatableController.updateCategories(catList));
    }
    
    @isTest
    public static void getProgressTrackerTest() {
        List<User> userList = [SELECT Id, Name FROM User];
        User testUser = userList[0];
        System.runAs(testUser) {
            Progress_Tracker__c pgTrack = new Progress_Tracker__c();
            insert pgTrack;
            
            MentorAmp_User__c newMtUser = new MentorAmp_User__c (Progress_Tracker__c = pgTrack.Id, User__c = testUser.Id);
            insert newMtUser;
            
            List<MentorAmp_User__c> mtUser = [SELECT Id, Name FROM MentorAmp_User__c WHERE User__c = :testUser.Id];
            if (mtUser.size() == 1) {
                System.assertEquals(pgTrack.Id, datatableController.getProgressTracker());
            } else {
                System.assert(mtUser.size() > 1);
            }
            
        }
        
    }
    
    @isTest
    public static void createCategoryTest() {
        List<User> userList = [SELECT Id, Name FROM User];
        User testUser = userList[0];
        System.runAs(testUser) {
            Progress_Tracker__c pgTrack = new Progress_Tracker__c();
            insert pgTrack;
            
            MentorAmp_User__c newMtUser = new MentorAmp_User__c (Progress_Tracker__c = pgTrack.Id, User__c = testUser.Id);
            insert newMtUser;
            
            System.assertEquals('Success: category created successfully', datatableController.createCategory('Test name', 'Test goal'));
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