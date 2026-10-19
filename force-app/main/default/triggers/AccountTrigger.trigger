Trigger AccountTrigger on Account(after insert){
    AccountTriggerHandler.createOpportunityForEveryAccount(Trigger.new);
}