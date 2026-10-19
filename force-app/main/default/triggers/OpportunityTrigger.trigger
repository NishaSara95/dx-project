trigger OpportunityTrigger on Opportunity (before insert, before update) {
    OpportunityTriggerHandler.markHotOpportunities(Trigger.new);
}