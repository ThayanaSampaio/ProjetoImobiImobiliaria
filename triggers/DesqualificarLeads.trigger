trigger DesqualificarLeads on Lead (Before insert) {
  
    // Lista dos estados da região Nordeste e Sudeste
    Set<String> estadosValidos = new Set<String>{'MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA', 'ES', 'RJ', 'MG', 'SP'};

    // Loop por cada lead a ser inserido
    for (Lead lead : Trigger.new) {
        // Verifica se o estado do lead está na lista de estados válidos
        if (!estadosValidos.contains(lead.Estado__c)) {
            // Define o status do lead como desqualificado
            lead.Status = 'Desqualificado';
            // Define o motivo da desqualificação
            lead.Description = 'No momento nós atendemos apenas nos estados das regiões Nordeste e Sudeste';
        }
    }
}