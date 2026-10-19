public with sharing class OpportunityController{

    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunity(String searchKey){
           String key = '%' + searchKey + '%';
    return [SELECT Id, Name, StageName, Amount, CloseDate, Account.Name FROM Opportunity WHERE Name LIKE :key
            LIMIT 50];
        
    }
}