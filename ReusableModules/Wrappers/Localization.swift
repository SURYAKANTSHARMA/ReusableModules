//
//  Localization.swift
//  KurdTaxi
//
//  Created by Cl-macmini-100 on 6/12/17.
//  Copyright © 2017 Suryakant Sharma. All rights reserved.
//

import UIKit

enum LanguageType: String {
    case english = "en"
    case espanol = "es"
    case arabic = "ar"
}

extension Notification.Name {
    public static let languageChanged = Notification.Name(rawValue: "com.click-labs.FabU.LCLLanguageChangeNotification")
}

let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"

/// Default language. English. If English is unavailable defaults to base localization.
let LCLDefaultLanguage = "en"

/**
 - Listen for this notification for update UI for new Language.
 */

// MARK: Language Setting Functions

open class Localize: NSObject {
    
    /**
     List available languages
     - Returns: Array of available languages.
     */
    open class func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.index(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    
    /**
     Current language
     - Returns: The current language. String.
     */
    open class func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    /**
     
     */
    class func currentLanguage() -> LanguageType {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            if let lang = LanguageType(rawValue: currentLanguage) {
                return lang
            }
        }
        return .english
    }
    
    /**
     Change the current language
     - Parameter language: Desired language.
     */
    open class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            //TODO:- Set Semantics here.
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name.languageChanged, object: nil)
        }
    }
    static func refreshSementicAccordingToCurrentLanguage(language: LanguageType? = nil) {
        setSemanticAttributes(language: language ?? currentLanguage())
    }
    
    static private func setSemanticAttributes(language: LanguageType) {
        switch language {
        case .english:
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
        case .arabic:
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
        case .espanol:
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
        }
       
    }
    
    /**
     Change the current language
     - Parameter language: Desired language.
     */
    class func setCurrentLanguage(_ language: LanguageType) {
        let langString = getLanguageString(language: language)
        let selectedLanguage = availableLanguages().contains(langString) ? langString : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            setSemanticAttributes(language: language)
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name.languageChanged, object: nil)
        }
    }
    
    class func getLanguageString(language: LanguageType) -> String {
        switch language {
        case .english:
            return "en"
        case .espanol:
            return "es"
        case .arabic:
            return "ar"
        }
    }
    
    /**
     Default language
     - Returns: The app's default language. String.
     */
    open class func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    /**
     Resets the current language to the default
     */
    open class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /**
     Get the current language's display name for a language.
     - Parameter language: Desired language.
     - Returns: The localized string.
     */
    open class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}



