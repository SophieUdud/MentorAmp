@isTest
public class datatableControllerTest {
    
    @isTest
    public static void getCategoriesTest() {
        
    }
    
    @isTest
    public static void updateCategoriesTest() {
        
    }
    
    @isTest
    public static void getProgressTrackerTest() {
		Id currentUserId = UserInfo.getUserId();
        Progress_Tracker__c pgTrack = new Progress_Tracker__c();
        insert pgTrack;
        MentorAmp_User__c mtUser = new MentorAmp_User__c (Progress_Tracker__c = pgTrack.Id, User__c = currentUserId);
        insert mtUser;
        System.assertEquals(pgTrack.Id, datatableController.getProgressTracker());
    }
    
    @isTest
    public static void createCategoryTest() {
        
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