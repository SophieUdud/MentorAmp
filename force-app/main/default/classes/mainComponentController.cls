public inherited sharing class mainComponentController {

    @AuraEnabled(cacheable=true)
    public static String getMentorAmpUser () {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        List<MentorAmp_User__c> mtUsers = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId];
        if (mtUsers.size() == 0){
            return 'notSignedUp';
        } else if (mtUsers.size() == 1 && mtUsers[0].RecordTypeId == menteeRecordTypeId) {
            return 'onlyMentee';
        } else if (mtUsers.size() == 1 && mtUsers[0].RecordTypeId == mentorRecordTypeId) {
            return 'onlyMentor';
        } else if (mtUsers.size() > 1) {
            return 'both';
        } else {
            return 'error';
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getMentorName () {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        MentorAmp_User__c currentMentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId, MentorAmp_User__c FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        List<MentorAmp_User__c> mentors = [SELECT Id, Name, Name__c FROM MentorAmp_User__c WHERE Id = :currentMentee.MentorAmp_User__c];
        if (mentors.size() == 0) {
            return 'No mentor has been assigned yet';
        } else {
            return mentors[0].Name__c;
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getMenteeName () {
        Id currentUserId = UserInfo.getUserId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c currentMentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId, MentorAmp_User__c FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
        List<MentorAmp_User__c> mentees = [SELECT Id, Name, Name__c, MentorAmp_User__c FROM MentorAmp_User__c WHERE MentorAmp_User__c = :currentMentor.Id];
        if (mentees.size() == 0) {
            return 'No mentee has been assigned yet';
        } else {
            return mentees[0].Name__c;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Category__c> getCategories(Boolean showingMenteeView, Boolean showingMentorView) {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c mentee = new MentorAmp_User__c();
        if (showingMenteeView == true && showingMentorView == false) {
            mentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        } else if (showingMenteeView == false && showingMentorView == true) {
            MentorAmp_User__c mentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
            mentee = [SELECT Id, Name, MentorAmp_User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE MentorAmp_User__c = :mentor.Id AND RecordTypeId = :menteeRecordTypeId];
        }
        List<Category__c> categories = [
                SELECT Id, Name, Weekly_Goal__c, Week_1__c, Week_2__c, Week_3__c, Week_4__c, Week_5__c, Week_6__c, Week_7__c, Week_8__c
                FROM Category__c
                WHERE Progress_Tracker__c = :mentee.Progress_Tracker__c
            ];
        return categories;
        
    }

    @AuraEnabled(cacheable=true)
    public static String getCurrentWeek (Boolean showingMenteeView, Boolean showingMentorView) {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c mentee = new MentorAmp_User__c();
        if (showingMenteeView == true && showingMentorView == false) {
            mentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        } else if (showingMenteeView == false && showingMentorView == true) {
            MentorAmp_User__c mentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
            mentee = [SELECT Id, Name, MentorAmp_User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE MentorAmp_User__c = :mentor.Id AND RecordTypeId = :menteeRecordTypeId];
        }
        Progress_Tracker__c tracker = [SELECT Id, Name, Current_Week__c FROM Progress_Tracker__c WHERE Id = :mentee.Progress_Tracker__c];
        String currentWeek = tracker.Current_Week__c;
        return currentWeek;
    }

    @AuraEnabled
    public static String updateCurrentWeek (String newWeek, Boolean showingMenteeView, Boolean showingMentorView) {
        Id currentUserId = UserInfo.getUserId();
        Id menteeRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentee').getRecordTypeId();
        Id mentorRecordTypeId = Schema.SObjectType.MentorAmp_User__c.getRecordTypeInfosByName().get('Mentor').getRecordTypeId();
        MentorAmp_User__c mentee = new MentorAmp_User__c();
        if (showingMenteeView == true && showingMentorView == false) {
            mentee = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :menteeRecordTypeId];
        } else if (showingMenteeView == false && showingMentorView == true) {
            MentorAmp_User__c mentor = [SELECT Id, Name, User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE User__c = :currentUserId AND RecordTypeId = :mentorRecordTypeId];
            mentee = [SELECT Id, Name, MentorAmp_User__c, Progress_Tracker__c, RecordTypeId FROM MentorAmp_User__c WHERE MentorAmp_User__c = :mentor.Id AND RecordTypeId = :menteeRecordTypeId];
        }
        Progress_Tracker__c tracker = [SELECT Id, Name, Current_Week__c FROM Progress_Tracker__c WHERE Id = :mentee.Progress_Tracker__c];
        tracker.Current_Week__c = newWeek;
        try {
            update tracker;
            return 'Success: Progress Tracker updated successfully';
        } 
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}