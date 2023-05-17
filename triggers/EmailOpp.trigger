trigger EmailOpp on Opportunity (before insert, before update) { 
    Set<Id> Conta = new Set<Id>();
     Map<Id, Contact> ContaContato = new Map<Id, Contact>();
    
    for (Opportunity OportunidadeNegociada : Trigger.new) {
        Conta.add(OportunidadeNegociada.AccountId);
    }    
    
   
    for (Contact Contatos : [SELECT Id, Email, AccountId FROM Contact WHERE AccountId IN :Conta]) {
        ContaContato.put(Contatos.AccountId, Contatos);
    }
    
    for (Opportunity Negociacao : Trigger.new) {
        if (Negociacao.StageName == 'Negociação/Revisão' && ContaContato.containsKey(Negociacao.AccountId)) {
            Negociacao.Email__c = ContaContato.get(Negociacao.AccountId).Email;
        }
    }
}