trigger TarefaEntregaChaves on Opportunity (after update) {
    List<Task> tarefas = new List<Task>();
    
    for (Opportunity opp :Trigger.new) {
        if (opp.stageName == 'Fechado/Ganho' && opp.amount >= 10000) {
            task novaTarefa = new task();
            novaTarefa.OwnerId = opp.OwnerId;
            novaTarefa.WhatId = opp.Id;
            novaTarefa.Subject = 'Time de vendas: Agendar entrega de chaves e reparos com o cliente';
            novaTarefa.ActivityDate = Date.today().addDays(1);
            novaTarefa.Priority = 'High';
            novaTarefa.Description = 'Agendar a entrega das chaves e os reparos necessários com o cliente.';
            novaTarefa.ReminderDateTime = Date.today().addDays(5);
            tarefas.add(novaTarefa);
        }
    }
    
       if (!tarefas.isEmpty()) {
        insert tarefas;
        System.debug('Tarefa criada com sucesso: ' + tarefas);
    }
    	System.debug('Trigger criar tarefa finalizada.');
}