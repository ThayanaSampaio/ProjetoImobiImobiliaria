@isTest
private class TestCriarTarefaAoMudarStatusLead {
 
    @isTest
    static void testTriggerPositivo() {
        
        // Test Positivo: cria um lead com status "Contactado"
        Lead lead2 = new Lead(
            LastName = 'Ciclano',
            Company = 'ABC',
            Email ='Ciclanodetal@gmail.com',
            Estado__c = 'CE',
            Status = 'Contactado'
        );
        insert lead2;
        
        // Atualiza o status do lead2 para "Em Negociação"
        lead2.Status = 'Em Negociação';
        update lead2;
        
        // Verifica se a trigger não criou uma tarefa de acompanhamento para o lead2        
        List<Task> tarefas = [SELECT WhoId, Subject, ActivityDate, Priority, Description, ReminderDateTime
                              FROM Task WHERE WhoId = :lead2.Id];
        System.assertEquals(1, tarefas.size(), 'Teste positivo deu erro');
        Task tarefa = tarefas[0];
        System.assertEquals(lead2.Id, tarefa.WhoId);
        System.assertEquals('Tentar a conversão nos próximos 10 dias', tarefa.Subject);
        System.assertEquals(Date.today().addDays(1), tarefa.ActivityDate);
        System.assertEquals('High', tarefa.Priority);
        System.assertEquals('Tentar a conversão nos próximos 10 dias', tarefa.Description);
        System.assertEquals(Date.today().addDays(10), tarefa.ReminderDateTime);
    }
    
      @isTest
    static void testTriggerNegative() {
        //Teste Negativo: cria um lead com status "Em Negociação"
        Lead lead1 = new Lead(
            LastName = 'Fulano',
            Company = 'DeTal',
            Email ='Fulanodetal@gmail.com',
            Estado__c = 'CE',
            Status = 'Em Negociação'
        );
        insert lead1;
        
        // Verifica se a trigger criou uma tarefa de acompanhamento para o lead1
        List<Task> tarefas = [SELECT WhoId, Subject, ActivityDate, Priority, Description, ReminderDateTime
                              FROM Task WHERE WhoId = :lead1.Id];
        System.assertEquals(1, tarefas.size(), 'Teste negativo deu certo');
        Task tarefa = tarefas[0];
        System.assertEquals(lead1.Id, tarefa.WhoId);
        System.assertEquals('Tentar a conversão nos próximos 10 dias', tarefa.Subject);
        System.assertEquals(Date.today().addDays(1), tarefa.ActivityDate);
        System.assertEquals('High', tarefa.Priority);
        System.assertEquals('Tentar a conversão nos próximos 10 dias', tarefa.Description);
        System.assertEquals(Date.today().addDays(10), tarefa.ReminderDateTime);
    }
    
}