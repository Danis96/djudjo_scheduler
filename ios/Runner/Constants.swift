//
//  Constants.swift
//  Runner
//
//  Created by Ada Hadzikasimovic on 14/10/2020.
//

import Foundation

struct Constants {
    #if DEVELOPMENT
    static let GMSServiceAPIKey = "AIzaSyCeITHz5SETociKaZJaT4g8J7ezZTY-O-8"
    static let sharedSecret = "d91ddb6e94c9289071c528693ff76841"
    static let serverHost = "https://tower."
    #elseif QA
    static let GMSServiceAPIKey = ""
    static let sharedSecret = ""
    static let serverHost = ""
    #else
    static let GMSServiceAPIKey = "AIzaSyDW5wrE8pFI5J2ohiIU56tJJcNlxU827YU"
    static let sharedSecret = "04e309788f5e811ef3767af6ce885fcb"
    static let serverHost = "https://tower-test."
    #endif
}
