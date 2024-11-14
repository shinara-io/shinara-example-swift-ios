import SwiftUI
import StoreKit
import ShinaraSDK

struct ContentView: View {
    @StateObject private var store = IAPStore()
    @State private var referralCode = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header label
            Text("Shinara iOS SDK Example Code")
                .font(.headline)
                .padding(.bottom, 5)
            
            // Textfield with black border and label
            VStack(alignment: .leading, spacing: 8) {
                Text("Referral Code")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("Enter Referral Code", text: $referralCode)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            .padding(.bottom, 20)
            
            // Button to validate and purchase
            Button("Buy Subscription") {
                validateAndPurchase()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Display status of purchase
            Text(store.purchaseStatus)
                .padding()
        }
        .padding()
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .onAppear {
            store.fetchProducts()
        }
    }
    
    private func validateAndPurchase() {
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
