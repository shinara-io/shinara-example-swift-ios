import Foundation
import UIKit
import StoreKit
import ShinaraSDK

class IAPStore: NSObject, ObservableObject {
    @Published var purchaseStatus = "Ready to purchase"
    
    private var products: [SKProduct] = []
    
    // Fetch the available in-app purchase products
    func fetchProducts() {
        // TODO: Replace with your own Subscription Product Id
        let request = SKProductsRequest(productIdentifiers: ["iaptestswift.yearly"])
        request.delegate = self
        request.start()
    }
    
    // Initiate the purchase of a subscription
    func purchaseSubscription() {
        guard let product = products.first else {
            purchaseStatus = "Product not found"
            return
        }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self) // Add transaction observer
        SKPaymentQueue.default().add(payment) // Add the payment to the queue
    }
}

extension IAPStore: SKProductsRequestDelegate {
    // Handle the response for available products
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.isEmpty {
            purchaseStatus = "No products found"
        } else {
            products = response.products
            purchaseStatus = "Products fetched successfully"
        }
    }
}

extension IAPStore: SKPaymentTransactionObserver {
    // Listener for transaction updates
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print("IAPStore transaction: \(transaction.transactionIdentifier)")
            switch transaction.transactionState {
            case .purchased:
                // Handle successful purchase
                purchaseStatus = "Purchase Successful!"
                Task.detached {
                    do {
                        // fire and forget
                        try await ShinaraSDK.instance.attributePurchase(productId: transaction.payment.productIdentifier, transactionId: transaction.transactionIdentifier ?? "")
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .failed:
                // Handle failed purchase
                if let error = transaction.error {
                    purchaseStatus = "Purchase failed: \(error.localizedDescription)"
                } else {
                    purchaseStatus = "Purchase failed"
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .restored:
                // Handle restored purchases
                purchaseStatus = "Purchase Restored"
                SKPaymentQueue.default().finishTransaction(transaction)
                
            default:
                break
            }
        }
    }
}
