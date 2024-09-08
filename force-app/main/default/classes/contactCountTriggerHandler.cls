public class contactCountTriggerHandler 
{
    public static void method(List<id> accountIds)
    {
        List<Contact> conList = new List<Contact>();
        List<Account> accountUpdateList = new List<Account>();
        List<Account> accountList = new List<Account>();
        if(accountIds.size()>0 && accountIds != Null)
        {
            accountList = [select id, Description, (SELECT id FROM Contacts) from account where id IN: accountIds];
        }
        if(accountList.size()>0 && accountList != Null)
        {
            for (Account acc : accountList) 
            {
                System.debug('acc.Contacts.size()=' + acc.Contacts.size());
                acc.contactsnumber__c = acc.Contacts.size();
                accountUpdateList.add(acc);
            }
        }
        try 
        {
            if(accountUpdateList.size()>0 && accountUpdateList != Null)
            {
                update accountUpdateList;
            }
        }
        catch (Exception ex) 
        {
            System.debug('Exception error: ' + ex.getMessage());
        }
    }
}