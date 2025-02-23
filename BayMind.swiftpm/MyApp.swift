import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var store = TaskStore()
    @State private var errorWrapper: ErrorWrapper?
    @State private var showPopUp = true
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if showPopUp {
                    PopUpView(isPresented: $showPopUp)
                        .transition(.opacity)  // Fade effect
                        .zIndex(1)
                }
                TaskView(tasks: $store.tasks) {
                    Task {
                        do {
                            try await store.save(tasks: store.tasks)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error,
                                                        guidance: "Try again later.")
                        }
                    }
                }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "We will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.tasks = DailyTask.sampleData
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
        }
    }
}
