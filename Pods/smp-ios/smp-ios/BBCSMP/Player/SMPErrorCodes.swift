//
//  SMPErrorCodes.swift
//  SMP
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 20/07/2023.
//  Copyright © 2023 BBC. All rights reserved.
//

import Foundation

// https://confluence.dev.bbc.co.uk/display/mp/Error+Model

public struct SMPErrorCodes {
    
    public struct MediaAvailability {
        public static let unknownError = 1000
        public static let connectionsExhausted = 5000
        public static let attemptingCDNFailover = 7200
    }
    
    public struct MediaResolution {
        public static let invalidRequest = 1026
        public static let unauthorized = 1046
        public static let generic = 1052
        public static let selectionUnavailable = 1052
        public static let tokenExpired = 1053
        public static let tokenInvalid = 1054
        public static let geolocation = 1056
        public static let selectionUnavailableWithToken = 1073
        public static let authorizationNotResolved = 7202
    }
        
    public struct Playback {
        // In the future we may wish to add a specific error code for failedToPlayToEnd. Matching current behaviour in MOBILE-7718
        public static let failedToPlayToEnd = 1000
        public static let initialLoadFailed = 3840
        public static let seekTimedOut = 7201
    }
    
}

@objcMembers public class BBCSMPErrorCodes: NSObject {
    
    public class func failedToPlayToEnd() -> Int { return SMPErrorCodes.Playback.failedToPlayToEnd }
    public class func initialLoadFailed() -> Int { return SMPErrorCodes.Playback.initialLoadFailed }
    public class func attemptingCDNFailover() -> Int { return SMPErrorCodes.MediaAvailability.attemptingCDNFailover }
    public class func seekTimedOut() -> Int { return SMPErrorCodes.Playback.seekTimedOut }
    
}
