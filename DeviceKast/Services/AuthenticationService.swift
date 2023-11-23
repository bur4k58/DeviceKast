import Firebase
import FirebaseAuth

class AuthenticationService: ObservableObject {
    //Define a @Published property to store the current user and a handler to listen for authentication state changes
    @Published var user: User?
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        addListeners()
    }
    
    static func signIn() {
        Auth.auth().signIn(withEmail: "development2@icapps.com", password: "password") { (user, error) in }
        
        // Uncomment the following code to create a new user
        //        Auth.auth().createUser(withEmail: "development2@icapps.com", password: "password") {
        //            (authResult, error) in
        //            guard let user = authResult?.user else {
        //                return
        //            }
        //        }
    }
    
    private func addListeners() {
        // Define a function to remove any existing authentication state change listeners
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        
        // Define a closure to listen for authentication state changes and update the user property accordingly
        authenticationStateHandler = Auth.auth()
            .addStateDidChangeListener { _, user in
                self.user = user
            }
    }
}
