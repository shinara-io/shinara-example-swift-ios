import SwiftUI
import StoreKit
import ShinaraSDK

struct ContentView: View {
    @StateObject private var store = IAPStore()
    @State private var referralCode = "" // State for storing referral code
    @State private var showError = false // State for showing error alert
    @State private var errorMessage = "" // State for error message
    
    var body: some View {
        VStack {
            // Textfield for referral code
            TextField("Enter Referral Code", text: $referralCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Button to validate and purchase
            Button("Buy Subscription") {
                validateAndPurchase()
            }
            .padding()
            
            // Display status of purchase
            Text(store.purchaseStatus)
                .padding()
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .padding()
        .onAppear {
            store.fetchProducts()
        }
    }
    
    private func validateAndPurchase() {
        // Don't proceed if referral code is empty
        guard !referralCode.isEmpty else {
            errorMessage = "Please enter a referral code"
            showError = true
            return
        }
        
        ShinaraSDK.instance.validateReferralCode(code: referralCode) { result in
            switch result {
            case .success(_):
                // If validation successful, proceed with purchase
                store.purchaseSubscription()
            case .failure(let error):
                // If validation fails, show error
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}
