import SwiftUI

struct ContentView: View {
    @State private var todos: [Todo] = []
    @State private var newTodoText: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Enter new task", text: $newTodoText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    guard !newTodoText.isEmpty else { return }
                    todos.append(Todo(text: newTodoText))
                    newTodoText = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .padding()

            List {
                ForEach(todos) { item in
                    HStack {
                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                if let index = todos.firstIndex(where: { $0.id == item.id }) {
                                    todos[index].isDone.toggle()
                                }
                            }
                        Text(item.text)
                            .strikethrough(item.isDone)
                    }
                }
                .onDelete(perform: deleteItem)
            }
        }
        .padding()
    }

    func deleteItem(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct Todo: Identifiable {
    var id: UUID = UUID()
    var text: String
    var isDone: Bool = false
}

#Preview {
    ContentView()
}
