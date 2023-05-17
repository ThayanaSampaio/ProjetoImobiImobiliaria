trigger CriarTarefaAoMudarStatusLead on Lead (after update) {
  List<Task> tarefas = new List<Task>();
    
    for (Lead lead :Trigger.new) {
        if (lead.status != 'Contactado' && lead.status == 'Em Negociação') {
            task novaTarefa = new task();
            novaTarefa.Subject = 'Tentar a conversão nos próximos 10 dias';
            novaTarefa.Description = 'Tentar a conversão nos próximos 10 dias';
            novaTarefa.Priority = 'High';
            novaTarefa.WhoId = lead.Id;
            novaTarefa.ActivityDate = Date.today().addDays(1);
            novaTarefa.ReminderDateTime = Date.today().addDays(10);
            tarefas.add(novaTarefa);
        }
    }
    
    if (!tarefas.isEmpty()) {
        insert tarefas;
        
    }
      
}