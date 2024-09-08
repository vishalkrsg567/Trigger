trigger contactCountTrigger on Contact (after insert, after delete) 
{
    System.debug('UserInfo.getUserId()=' + UserInfo.getUserId());
    User currentUserName = [SELECT Id, Username, Profile.Name, ProfileId FROM User WHERE Id = :UserInfo.getUserId()];
    System.debug('currentUserName=' + currentUserName);
    System.debug('currentUserName.Profile.Name=' + currentUserName.Profile.Name);
    
    TriggerSetting__c settings = TriggerSetting__c.getInstance();
    if (settings != null && !settings.isDisableContactCountTrigger__c && currentUserName.Username == settings.UserName__c && currentUserName.Profile.Name == settings.User_profile__c) 
    {
        System.debug('inside 9=' );
        List<id> accountIds = new List<id>();
        if (Trigger.isInsert && Trigger.isafter) 
        {
            for (Contact con : Trigger.new) 
            {
                accountIds.add(con.AccountId);
            }
        }
        if ( Trigger.isdelete && Trigger.isafter) 
        {
            for (Contact con : Trigger.old) 
            {
                accountIds.add(con.AccountId);
            }
        }
        if(accountIds.size()>0 && accountIds != Null)
        {
            System.debug('accountIds=' + accountIds);
            contactCountTriggerHandler.method(accountIds);
        }
    }
}