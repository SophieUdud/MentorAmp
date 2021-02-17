public with sharing class datatableController {
    
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

    public static Id getProgressTracker () {
        Id currentUserId = UserInfo.getUserId();
        MentorAmp_User__c mtUser = [SELECT Id, Name, User__c, Progress_Tracker__c FROM MentorAmp_User__c WHERE User__c = :currentUserId];
        Id pgTrackId = mtUser.Progress_Tracker__c;
        return pgTrackId;
    }

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
