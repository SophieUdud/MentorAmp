public with sharing class datatableController {
    
    //if the tracker is opened from the mentee view, return all Categories for the currently logged-in mentee's Progress Tracker
    //if the tracker is opened from the mentor view, return all Categories for the Progress Tracker of the currently logged-in mentor's mentee
    @AuraEnabled(cacheable=true)
    public static List<Category__c> getCategories(Boolean getMentorCategories) {
    //public static String getCategories(Boolean getMentorCategories) {
    //public static String getCategories() {
        System.debug('in getCategories');
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c mentee = new MentorAmp_User__c();
        if (!getMentorCategories) {
            mentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        } else if (getMentorCategories) {
            MentorAmp_User__c mentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
            mentee = [SELECT Id, Name, mtAmp__MentorAmp_User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE mtAmp__MentorAmp_User__c = :mentor.Id AND RecordTypeId = :menteeRecordTypeId];
        }
        List<Category__c> categories = [
            SELECT Id, Name, Weekly_Goal__c, Week_1__c, Week_2__c, Week_3__c, Week_4__c, Week_5__c, Week_6__c, Week_7__c, Week_8__c
            FROM Category__c
            WHERE Progress_Tracker__c = :mentee.Progress_Tracker__c
            WITH SECURITY_ENFORCED
        ];
        return categories;
        //return 'hello';
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
    public static Id getProgressTracker (Boolean getTrackerAsMentor) {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c mentee = new MentorAmp_User__c();
        if (!getTrackerAsMentor) {
            mentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        } else if (getTrackerAsMentor) {
            MentorAmp_User__c mentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
            mentee = [SELECT Id, Name, mtAmp__MentorAmp_User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE mtAmp__MentorAmp_User__c = :mentor.Id AND RecordTypeId = :menteeRecordTypeId];
        }
        return mentee.Progress_Tracker__c;
    }

    //add a new Category for the current user's Progress Tracker, populate the name and goal based on what the user entered on the frontend
    @AuraEnabled
    public static String createCategory (String name, String goal, Boolean createAsMentor) {
        System.debug('in createCategory');
        Category__c category = new Category__c();
        category.Name = name;
        category.Weekly_Goal__c = goal;
        category.Progress_Tracker__c = getProgressTracker(createAsMentor);
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