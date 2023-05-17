trigger CriarHistoricoDeVisita on Product2 (before insert, before update) {
    List<Product2> AtualizacaoVisita = new List<Product2>();
    
    for(Product2 visita : Trigger.new){
        if(visita.Contato__c != null && visita.Visita_Agendada__c != null){
            String HistoricoDeVisita = visita.HistoricoVisita__c != null ? visita.HistoricoVisita__c + '\n' : '';
            HistoricoDeVisita += 'Contato: ' + visita.Contato__c + ', Data de visita agendada: ' + visita.Visita_Agendada__c ;
            visita.HistoricoVisita__c = HistoricoDeVisita;
            visita.Contato__c = null;
            visita.Visita_Agendada__c = null;
        }
    }
}