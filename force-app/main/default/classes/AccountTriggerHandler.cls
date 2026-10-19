public class AccountTriggerHandler{


    // Create a related Opportunity when an Account is created.
    public static void createOpportunityForEveryAccount(List<Account> accList){
     List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList){
            
            Opportunity opp = new Opportunity(Name= acc.Name,  StageName = 'Prospecting', CloseDate = Date.today().addDays(30),AccountId = acc.Id);
            oppList.add(opp);

        }
        insert oppList;
    }
}