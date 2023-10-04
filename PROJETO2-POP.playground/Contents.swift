import UIKit

// Protocolo para representar a prioridade das tarefas
protocol Prioritizable {
    var priority: Priority { get }
}

// Protocolo para representar uma tarefa
protocol TaskProtocol: Prioritizable {
    var title: String { get set }
    var description: String { get set }
    var creationDate: Date { get }
    var dueDate: Date { get set }
    var isCompleted: Bool { get set }
}

// Protocolo para gerenciar tarefas
protocol TaskManagerProtocol {
    var tasks: [TaskProtocol] { get }
    
    func addTask(_ task: TaskProtocol)
    func removeTask(_ task: TaskProtocol)
    func updateTaskCompletion(_ task: TaskProtocol, isCompleted: Bool)
    func listTasks(filterByPriority priority: Priority?) -> [TaskProtocol]
    func notifyTaskCompletion(completionHandler: (TaskProtocol) -> Void)
    func notifyTaskListUpdate(updateHandler: () -> Void)
}

// Definindo uma enum para representar as prioridades das tarefas
enum Priority: String {
    case baixa
    case média
    case alta
}

// Definindo a classe Task para representar uma tarefa
class Task: TaskProtocol {
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
class TaskManager: TaskManagerProtocol {
    var tasks: [TaskProtocol] = []
    
    // Adicionando uma tarefa à lista de tarefas
    func addTask(_ task: TaskProtocol) {
        tasks.append(task)
    }
    
    // Removendo uma tarefa da lista de tarefas
    func removeTask(_ task: TaskProtocol) {
        if let index = tasks.firstIndex(where: { ($0 as? Task) === (task as? Task) }) {
            tasks.remove(at: index)
        }
    }

    
    // Atualizando o estado de conclusão de uma tarefa
    func updateTaskCompletion(_ task: TaskProtocol, isCompleted: Bool) {
        (task as? Task)?.isCompleted = isCompleted
    }
    
    // Listando todas as tarefas
    func listTasks(filterByPriority priority: Priority? = nil) -> [TaskProtocol] {
        if let priority = priority {
            return tasks.filter { ($0 as? Task)?.priority == priority }
        } else {
            return tasks
        }
    }
    
    // Usando uma closure para notificar quando uma tarefa for concluída
    func notifyTaskCompletion(completionHandler: (TaskProtocol) -> Void) {
        for task in tasks where (task as? Task)?.isCompleted ?? false {
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




