@isTest
public class TestTarefaEntregaChaves {
    @isTest
	static void TestTarefaEntregaChavesPositivo() {
    // Cria uma nova conta
    Account acc = new Account();
    acc.Name = 'Nova Conta';
    insert acc;

    // Cria uma oportunidade
    Opportunity opp = new Opportunity();
    opp.Name = 'Nova oportunidade';
    opp.StageName = 'Fechado/Ganho';
    opp.Amount = 150000;
    opp.AccountId = acc.Id;
    opp.CloseDate = Date.today().addDays(1);
    insert opp;
        
   // Cria uma nova tarefa associada à oportunidade
    Task tarefa = new Task();
    tarefa.WhatId = opp.Id;
    tarefa.Subject = 'Agendar entrega de chaves e reparos com o cliente';
    tarefa.ActivityDate = Date.today().addDays(1);
    tarefa.Status = 'Completed';
    tarefa.Priority = 'High';    
    tarefa.Description = 'Agendar a entrega das chaves e os reparos necessários com o cliente.';    
    tarefa.ReminderDateTime = Date.today().addDays(5);  
    insert tarefa;    

    // Verifica se a tarefa foi criada
    List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :opp.Id];
    //Ativar esse System.AssertEquals se quiser ver a mensagem de teste positivo dando certo
    //System.assertEquals(0, tasks.size(), 'Teste positivo deu certo e uma tarefa foi criada oportunidade Closed Won e >= 10000');
    System.assertEquals(1, tasks.size(), 'Teste positivo deu erro e nenhuma tarefa foi criada');
        
     // Verifica se a tarefa foi criada com os valores corretos
     System.assertEquals(opp.Id, tarefa.WhatId, 'Teste falhou: a tarefa criada não está associada à oportunidade correta');
     System.assertEquals('Agendar entrega de chaves e reparos com o cliente', tarefa.Subject, 'Teste falhou: a tarefa criada não tem o assunto correto');
     System.assertEquals(Date.today().addDays(1), tarefa.ActivityDate, 'Teste falhou: a tarefa criada não tem a data de atividade correta');
     System.assertEquals('Completed', tarefa.Status,'Teste falhou: a tarefa criada não tem o Status correto' );   
     System.assertEquals('High', tarefa.Priority, 'Teste falhou: a tarefa criada não tem a prioridade correta');
     System.assertEquals('Agendar a entrega das chaves e os reparos necessários com o cliente.', tarefa.Description, 'Teste falhou: a tarefa criada não tem o Description correto');   
}
    
    @isTest
    static void TestTarefaEntregaChavesNegativo() {
        
    	Account acc = new Account();
    	acc.Name = 'Nova Conta';
    	insert acc;

    // Cria uma oportunidade e associa à conta criada
    Opportunity opp = new Opportunity();
    opp.Name = 'Nova oportunidade';
    opp.StageName = 'Fechado/Ganho';
    opp.Amount = 99999;
    opp.AccountId = acc.Id;
    opp.CloseDate = Date.today();
    insert opp;

    // Verifica se nenhuma tarefa foi criada
    List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :opp.Id];
   // Verifica se uma tarefa foi criada sendo teste negativo errado     
    System.assertEquals(0, tasks.size(), 'Teste negativo deu erro e uma tarefa foi criada para valor abaixo de 100000');
    // Verifica se nenhuma tarefa foi criada sendo teste negativo certo    	
   System.assertEquals(1, tasks.size(), 'Teste Negativo deu certo e nenhuma tarefa foi criada para valor abaixo de 100000');
        
    }

    @isTest
    static void TestTarefaEntregaChavesNegativo2() {
    // Cria uma nova conta
    Account acc = new Account();
    acc.Name = 'Nova Conta';
    insert acc;

    // Cria uma oportunidade
    Opportunity opp = new Opportunity();
    opp.Name = 'Nova oportunidade';
    opp.StageName = 'Prospecção';
    opp.Amount = 150000;
    opp.AccountId = acc.Id;
    opp.CloseDate = Date.today();
    insert opp;

    
    List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :opp.Id];
    // Verifica se nenhuma tarefa foi criada sendo teste negativo certo    
    System.assertEquals(0, tasks.size(), 'Teste negativo deu certo e nenhuma tarefa foi criada para Prospecção');
    // Verifica se uma tarefa foi criada sendo teste negativo errado        
    System.assertEquals(1, tasks.size(), 'Teste negativo deu erro e uma tarefa foi criada para Prospecção');    
}
    
}