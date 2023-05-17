@IsTest
public class TestTarefaFinanceiro {
    
    @IsTest
    public static void TestPositivo() {
        // Criação de uma oportunidade com o estágio 'Fechado/Ganho'
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Fulano';
        opportunity.StageName = 'Fechado/Ganho';
        opportunity.CloseDate = date.today();
        insert opportunity;
		
        Task tarefa = new Task();
    	tarefa.WhatId = opportunity.Id;
    	tarefa.Subject = 'Cliente fechou negócio';
    	tarefa.Priority = 'High';    
    	tarefa.Description = 'Favor dar andamento no contrato.';     
    	insert tarefa;
        
		List<Task> createdTask = [SELECT Subject, Description, OwnerId, WhatId FROM Task WHERE WhatId = :opportunity.Id];
        System.assertEquals(1, createdTask.size());
           
    }
       @IsTest
    public static void TestNegativo() {
        // Criação de uma oportunidade com o estágio diferente de 'Fechado/Ganho'
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Ciclano';
        opportunity.StageName = 'Em Progresso';  // Estágio diferente de 'Fechado/Ganho'
        opportunity.CloseDate = Date.today();
        insert opportunity;
		
        List<Task> createdTasks = [SELECT Subject, Description, OwnerId, WhatId FROM Task WHERE WhatId = :opportunity.Id];
        System.assertEquals(1, createdTasks.size());
    }
}