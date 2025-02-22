import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var store = ScrumStore()
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
                ScrumsView(scrums: $store.scrums) {
                    Task {
                        do {
                            try await store.save(scrums: store.scrums)
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
                    store.scrums = DailyTask.sampleData
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
        }
    }
}
