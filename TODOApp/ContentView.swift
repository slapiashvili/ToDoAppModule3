//
//  ContentView.swift
//  TODOApp
//
//  Created by Salome Lapiashvili on 08.12.23.
//


import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var description: String
    var isCompleted: Bool
    var date: String
}

struct TaskRow: View {
    var task: Task
    var toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.description)
                    .foregroundColor(.white)
                    .font(.headline)
                HStack {
                    Image("todo.clipboard")
                    Text(task.date)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Button(action: {
                toggleCompletion()
            }) {
                ZStack {
                    if task.isCompleted {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.toDoPurple)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 12, height: 12)
                            )
                    } else {
                        Circle()
                            .stroke(Color.toDoPurple, lineWidth: 2)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .listRowBackground(Color.toDoDark)
    }
}


struct ToDoView: View {
    
    @State private var tasksNotDone = 3
    @State private var tasksDone = 3
    
    @State private var tasks: [Task] = [
        Task(description: "Finish Making this App", isCompleted: false, date: "Dec 1"),
        Task(description: "iOS Dev Assignment due on Saturday", isCompleted: true, date: "Dec 9"),
        Task(description: "Christmas Gift Shopping", isCompleted: false, date: "Dec 1"),
        Task(description: "Big Cleanup at Work", isCompleted: false, date: "Dec 3"),
        Task(description: "Learn SwiftUI", isCompleted: false, date: "Dec 2"),
        Task(description: "Christmas Resolutions List", isCompleted: false, date: "Dec 20"),
    ]
    
    private var tasksCount: Int {
        tasksNotDone + tasksDone
    }
    
    private var progressPercentage: Int {
        tasksCount == 0 ? 0 : Int(Double(tasksDone) / Double(tasksCount) * 100)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("You have \(tasksNotDone) tasks to complete")
                        .frame(alignment: .leading)
                        .frame(height: 80)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    ZStack(alignment: .trailing){
                        Image("ProfilePicture")
                            .resizable()
                            .frame(width:50, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.toDoPurple, Color.toDoDark]), startPoint: .top, endPoint: .bottom))
                            .clipShape(Circle())
                            .padding()
                        
                        Text("\(tasksNotDone)")
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(5)
                            .background(Color.toDoOrange)
                            .clipShape(Circle())
                            .offset(y:20)
                            .padding()
                    }
                }
                .background(Color.black)
                
                Button(action: {
                    tasksDone += tasksNotDone
                    tasksNotDone = 0
                }) {
                    Text("Complete All")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.toDoPurple, Color.toDoPink]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                        .padding()
                }
                .background(Color.black)
                
                Text("Progress")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text("Daily Task")
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("\(tasksDone) / \(tasksCount) Tasks Completed")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.top, -2)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Text("Keep Working")
                            .font(.caption)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(progressPercentage) %")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.toDoDarkPurple)
                            .frame(height: 20)
                        
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.toDoPurple)
                            .frame(width: CGFloat(progressPercentage) * 0.01 * UIScreen.main.bounds.width, height: 20)
                    }
                }
                .background(Color.toDoDark)
                .padding()
                
                Text("Completed Tasks")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .background(Color.black)
                
                List {
                    ForEach(tasks.indices, id: \.self) { index in
                        TaskRow(task: tasks[index]) {
                            tasks[index].isCompleted.toggle()
                            updateTasksCount()
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.black)
        }
    }
    
    private func updateTasksCount() {
        tasksDone = tasks.filter { $0.isCompleted }.count
        tasksNotDone = tasks.count - tasksDone
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}


