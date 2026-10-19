public class OpportunityTriggerHandler {
    public static void markHotOpportunities(List<Opportunity> newOpps) {
        for (Opportunity opp : newOpps) {
            if (opp.Amount != null && opp.Amount > 100000) {
                opp.Description = 'Hot Opportunity';
            }
        }
    }
}