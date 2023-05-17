trigger TarefaFinanceiro on Opportunity (after update) {
    List<Task> tasksToCreate = new List<Task>();
    
    for (Opportunity opp : Trigger.new) {
        if (opp.StageName == 'Fechado/Ganho') {
            Task newTask = new Task();
            newTask.Subject = 'Time financeiro: Cliente fechou negócio';
            newTask.Description = 'Favor dar andamento a este negócio';          
            newTask.WhatId = opp.Id; 

            tasksToCreate.add(newTask);
        }
    }
    
    // Insere as tarefas criadas
    insert tasksToCreate;
}