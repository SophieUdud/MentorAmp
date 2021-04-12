public with sharing class userInfoController {
    @AuraEnabled(cacheable=true)
    public static User getUserInfo() {
    
        User currentUser = [Select Id, Name, Email, MobilePhone from User where Id=:UserInfo.getUserId()];
        System.debug('currentUser: ' + currentUser);
        return currentUser;
    }
}
