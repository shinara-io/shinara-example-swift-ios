# Shinara SDK Example iOS App
This repository contains an example iOS application demonstrating the integration and usage of the Shinara SDK for handling referral-based in-app purchases.

## Features
- Referral code validation
- Automatic purchase attribution based on referral codes
- More documentation on https://coda.io/@shinara/shinara-swift-sdk 

## Prerequisites
- Xcode 14.0 or later
- iOS 15.0+ deployment target
- Shinara API Key (You can get it by signing up on Shinara.io/login)

## Setup Instructions
1. **Project Setup**
   - The example project comes with ShinaraSDK dependency pre-installed
   - A StoreKit configuration file is included for testing purposes
   - For production apps, remove the test StoreKit configuration and use your actual subscription product IDs

2. **Configure Shinara SDK**
   - Open `shinara_example_swift_iosApp.swift`
   - Replace the placeholder API key with your actual Shinara API key:
   ```swift
   ShinaraSDK.instance.initialize(apiKey: "YOUR_API_KEY_HERE")
   ```

## How It Works
The SDK uses two main methods for handling referral-based purchases:

1. **Initialize**
   ```swift
   ShinaraSDK.instance.initialize(apiKey: "YOUR_API_KEY_HERE")
   ```
   - Initializes the SDK with your API key
   - Automatically sets up StoreKit purchase listeners
   - Handles purchase attribution to referral codes internally

2. **Validate Referral Code**
   ```swift
   ShinaraSDK.instance.validateReferralCode(code: referralCode) { result in
       // Handles validation result
   }
   ```
   - Validates the referral code before purchase
   - Returns success/failure through completion handler

When a purchase is completed, the SDK automatically attributes it to the validated referral code, requiring no additional code from your side.

## Important Note for Implementation
This example project is intended to demonstrate Shinara SDK integration patterns only. For actual attribution testing and production implementation:

1. Follow the integration steps provided in your Shinara Dashboard
2. Replace the test StoreKit configuration with your actual App Store Connect subscription product IDs
3. Configure the SDK with your production API key from the Shinara Dashboard
