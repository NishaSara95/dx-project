@isTest
private class OpportunityTriggerHandlerTest {

    // Helper to build an Opportunity with the required fields
    private static Opportunity buildOpp(String name, Decimal amount) {
        return new Opportunity(
            Name = name,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = amount
        );
    }

    @isTest
    static void insertHighAmount_setsHotDescription() {
        Opportunity opp = buildOpp('High Value Opp', 150000);

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity result = [SELECT Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Hot Opportunity', result.Description,
            'Amount above 100000 should be marked as hot');
    }

    @isTest
    static void insertLowAmount_doesNotSetDescription() {
        Opportunity opp = buildOpp('Low Value Opp', 50000);

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity result = [SELECT Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(null, result.Description,
            'Amount below 100000 should not be marked as hot');
    }

    @isTest
    static void insertExactlyThreshold_doesNotSetDescription() {
        Opportunity opp = buildOpp('Boundary Opp', 100000);

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity result = [SELECT Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(null, result.Description,
            'Exactly 100000 is not greater than 100000, so it should not be hot');
    }

    @isTest
    static void insertNullAmount_doesNotThrowOrSetDescription() {
        Opportunity opp = buildOpp('No Amount Opp', null);

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity result = [SELECT Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(null, result.Description,
            'Null amount should be handled safely');
    }

    @isTest
    static void updateAmountAboveThreshold_setsHotDescription() {
        Opportunity opp = buildOpp('Update Opp', 50000);
        insert opp;

        Test.startTest();
        opp.Amount = 200000;
        update opp;
        Test.stopTest();

        Opportunity result = [SELECT Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Hot Opportunity', result.Description,
            'Raising the amount above 100000 should mark it as hot');
    }

       @isTest
    static void bulkInsert_handlesMixedAmounts() {
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            // Even index = hot (150000), odd index = not hot (10000)
            opps.add(buildOpp('Bulk Opp ' + i, Math.mod(i, 2) == 0 ? 150000 : 10000));
        }

        Test.startTest();
        insert opps;
        Test.stopTest();

        Integer hotCount = 0;
        for (Opportunity o : [SELECT Description FROM Opportunity WHERE Id IN :opps]) {
            if (o.Description == 'Hot Opportunity') {
                hotCount++;
            }
        }
        System.assertEquals(100, hotCount, 'Exactly half of the 200 records should be hot');
    }
}