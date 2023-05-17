@isTest
private class TesteEmailOpp {
    @isTest
    static void testTriggerPositive() {
        
        //conta para associar com a oportunidade
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        //contato associado com a conta
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test.contact@test.com', AccountId = testAccount.Id);
        insert testContact;
        
        //oportunidade para teste
        Opportunity testOpp = new Opportunity(Name = 'Test Opp', StageName = 'Negociação/Revisão', AccountId = testAccount.Id, CloseDate = Date.today().addDays(30));
        
        Test.startTest();
        insert testOpp;
        Test.stopTest();
        
        // Verificando se o Email__c da oportunidade foi preenchido corretamente pela trigger
        System.assertEquals(testContact.Email, [SELECT Email__c FROM Opportunity WHERE Id = :testOpp.Id].Email__c);
    }
    
    @isTest
    static void testTriggerNegative() {
        
        //conta para associar com a oportunidade
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        //contato associado com uma conta diferente
        Account otherAccount = new Account(Name = 'Other Account');
        insert otherAccount;
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test.contact@test.com', AccountId = otherAccount.Id);
        insert testContact;
        
        //oportunidade
        Opportunity testOpp = new Opportunity(Name = 'Test Opp', StageName = 'Prospecção', AccountId = testAccount.Id, CloseDate = Date.today().addDays(30));
        
        Test.startTest();
        insert testOpp;
        Test.stopTest();
        
        // Verificando se o Email__c da oportunidade não foi preenchido pela trigger
       	System.assertEquals(testContact.Email, [SELECT Email__c FROM Opportunity WHERE Id = :testOpp.Id].Email__c);
    }
}