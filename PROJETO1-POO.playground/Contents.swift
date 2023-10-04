import UIKit

// Definindo um enum para representar as prioridades das tarefas
enum Priority: String {
    case baixa
    case média
    case alta
}

// Definindo a classe Task para representar uma tarefa
class Task {
    var title: String
    var description: String
    var creationDate: Date
    var dueDate: Date
    var priority: Priority
    var isCompleted: Bool = false

    init(title: String, description: String, dueDate: Date, priority: Priority) {
        self.title = title
        self.description = description
        self.creationDate = Date()
        self.dueDate = dueDate
        self.priority = priority
    }
}

// Definindo a classe TaskManager para gerenciar todas as tarefas
class TaskManager {
    var tasks: [Task] = []
    
    // Adicionando uma tarefa à lista de tarefas
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    // Removendo uma tarefa da lista de tarefas
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0 === task }) {
            tasks.remove(at: index)
        }
    }
    

    
    // Atualizando o estado de conclusão de uma tarefa
    func updateTaskCompletion(_ task: Task, isCompleted: Bool) {
        task.isCompleted = isCompleted
    }
    
    // Listando todas as tarefas
    func listTasks(filterByPriority priority: Priority? = nil) -> [Task] {
        if let priority = priority {
            return tasks.filter { $0.priority == priority }
        } else {
            return tasks
        }
    }
    
    // Usando uma closure para notificar quando uma tarefa for concluída
    func notifyTaskCompletion(completionHandler: (Task) -> Void) {
        for task in tasks where task.isCompleted {
            completionHandler(task)
        }
    }
    
    // Usando uma closure para notificar quando a lista de tarefas for atualizada
    func notifyTaskListUpdate(updateHandler: () -> Void) {
        updateHandler()
    }
}

// Uso
let taskManager = TaskManager()

let task1 = Task(title: "Fazer compras", description: "Comprar mantimentos para a semana", dueDate: Date(), priority: .baixa)
let task2 = Task(title: "Estudar Swift", description: "Praticar programação em Swift", dueDate: Date(), priority: .média)

taskManager.addTask(task1)
taskManager.addTask(task2)

print("Todas as tarefas:")
for task in taskManager.listTasks() {
    print("\(task.title) (Prioridade: \(task.priority.rawValue))")
}

print("\nTarefas de alta prioridade:")
for task in taskManager.listTasks(filterByPriority: .alta) {
    print("\(task.title) (Prioridade: \(task.priority.rawValue))")
}

// Simulando a conclusão de uma tarefa e notificando
taskManager.updateTaskCompletion(task1, isCompleted: true)
taskManager.notifyTaskCompletion { task in
    print("Tarefa concluída: \(task.title)")
}

// Notificando a atualização da lista de tarefas
taskManager.notifyTaskListUpdate {
    print("\nLista de tarefas atualizada")
}

