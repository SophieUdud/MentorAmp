public with sharing class datatableController {
    
    //return all Categories for the currently logged-in user's Progress Tracker
    @AuraEnabled(cacheable=true)
    public static List<Category__c> getCategories() {
        Id currentUserId = UserInfo.getUserId();
        MentorAmp_User__c mtUser = [SELECT Id, Name, User__c, Progress_Tracker__c FROM MentorAmp_User__c WHERE User__c = :currentUserId];
        List<Category__c> categories = [
            SELECT Id, Name, Weekly_Goal__c, Week_1__c, Week_2__c, Week_3__c, Week_4__c, Week_5__c, Week_6__c, Week_7__c, Week_8__c
            FROM Category__c
            WHERE Progress_Tracker__c = :mtUser.Progress_Tracker__c
            WITH SECURITY_ENFORCED
        ];
        return categories;
    }

    //update the properties of the categories the user changed in the datatable (name, weekly goal, weekly tracking etc.)
    //the 'data' object was created in the frontend, containing the changed categories with the values of their changed fields
    @AuraEnabled
    public static string updateCategories(Object data) {
        List<Category__c> categoriesForUpdate = (List<Category__c>) JSON.deserialize(
            JSON.serialize(data),
            List<Category__c>.class
        );
        try {
            update categoriesForUpdate;
            return 'Success: categories updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }

    //get the Progress Tracker for the currently logged-in user, return empty string if there's no tracker yet
    public static Id getProgressTracker () {
        Id currentUserId = UserInfo.getUserId();
        List<MentorAmp_User__c> mtUser = [SELECT Id, Name, User__c, Progress_Tracker__c FROM MentorAmp_User__c WHERE User__c = :currentUserId];
        if (mtUser.size() != 0) {
            Id pgTrackId = mtUser[0].Progress_Tracker__c;
        	return pgTrackId;
        } else {
            return '';
        }
    }

    //add a new Category for the current user's Progress Tracker, populate the name and goal based on what the user entered on the frontend
    @AuraEnabled
    public static String createCategory (String name, String goal) {
        Category__c category = new Category__c();
        category.Name = name;
        category.Weekly_Goal__c = goal;
        category.Progress_Tracker__c = getProgressTracker();
        try {
            insert category;
            return 'Success: category created successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }

    //delete the Category the user chose in the frontend
    @AuraEnabled
    public static String deleteCategory(Id categoryId){
        Category__c category = [SELECT Id, Name FROM Category__c WHERE Id = :categoryId];
        try {
            delete category;
            return 'Success: categories deleted successfully';
        } 
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}