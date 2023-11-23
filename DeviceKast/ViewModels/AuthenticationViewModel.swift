import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    let db = Firestore.firestore()
    
    // Published properties that trigger view updates when their values change
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid: Bool  = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage: String = ""
    @Published var user: User?
    @Published var displayName: String = ""
    @Published var displayFullName: String = ""
    
    // Initialization
    init() {
        registerAuthStateHandler()
        
        // Combine the values of flow, email, password, and confirmPassword
        // and use them to update the value of isValid property
        $flow
            .combineLatest($email, $password, $confirmPassword)
            .map { flow, email, password, confirmPassword in
                flow == .login
                ? !(email.isEmpty || password.isEmpty)
                : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            }
            .assign(to: &$isValid)
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // Register an auth state change handler to observe changes in the user's authentication state
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
                self.displayFullName = user?.displayName ?? ""
            }
        }
    }
    
    // Switch between login and signUp flow
    func switchFlow() {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
    }
    
    // Utility method for waiting asynchronously
    private func wait() async {
        do {
            print("Wait")
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("Done")
        }
        catch { }
    }
    
    // Reset email, password, and confirmPassword properties
    func reset() {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
}

enum AuthenticationError: Error {
    case tokenError(message:String)
}

extension AuthenticationViewModel {
    // Sign out the current user
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    // Sign in with Google account
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No clientID found in Firebase app")
        }
        
        // Create GIDConfiguration with the Firebase clientID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Get the root view controller from the window scene
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        
        do {
            // Sign in with Google using the root view controller
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = userAuthentication.user
            guard let email = user.profile?.email else {
                throw AuthenticationError.tokenError(message: "Email missing")
            }
            
            if email.hasSuffix("icapps.com") {
                // If the email ends with 'icapps.com', get the ID token and access token
                guard let idToken = user.idToken else {
                    throw AuthenticationError.tokenError(message: "ID token missing")
                }
                
                let accessToken = user.accessToken
                
                // Create GoogleAuthProvider credential with ID token and access token
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: accessToken.tokenString)
                
                // Sign in with Firebase using the Google credential
                let result = try await Auth.auth().signIn(with: credential)
                
                let firebaseUser = result.user
                print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
                return true
            } else {
                print("User's email does not end with 'icapps.com'")
                return false
            }
        } catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            return false
        }
    }

    func fetchUserFromFirebase(completion: @escaping (UserModal?) -> Void) {
        if let email = user?.email {
            // Query the "users" collection to fetch the user with the given email
            db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
                // Check for errors
                if let error = error {
                    print("Error getting user: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("User not found")
                    completion(nil)
                    return
                }
                
                if let userDocument = documents.first {
                    let userData = userDocument.data()
                    
                    // Validate and extract fields from the userData dictionary
                    if let email = userData["email"] as? String,
                       let firstName = userData["first_name"] as? String,
                       let lastName = userData["last_name"] as? String,
                       let imageUrl = userData["image_url"] as? String,
                       let team = userData["team"] as? String,
                       let rentedDeviceCount = userData["rented_device_count"] as? Int {
                        
                        // Create UserModal object with fetched data
                        let user = UserModal(id: userDocument.documentID,
                                             email: email,
                                             firstName: firstName,
                                             lastName: lastName,
                                             imageUrl: imageUrl,
                                             lastActiveAt: Date(),
                                             team: team,
                                             rentedDeviceCount: rentedDeviceCount)
                        completion(user)
                    } else {
                        print("Error converting user data")
                        completion(nil)
                    }
                } else {
                    print("No user document found")
                    completion(nil)
                }
            }
        } else {
            print("Logged-in user's email is missing")
            completion(nil)
        }
    }
}
