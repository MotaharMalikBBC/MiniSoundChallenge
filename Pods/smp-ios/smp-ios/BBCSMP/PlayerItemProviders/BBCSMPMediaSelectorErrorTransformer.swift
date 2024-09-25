//
//  BBCSMPMediaSelectorErrorType.swift
//  SMP
//
//  Created by Sam Rowley on 01/07/2020.
//  Copyright © 2020 BBC. All rights reserved.
//
import Foundation

@objc public enum BBCSMPMediaSelectorErrorType: Int {
    case geolocation
    case generic
    case authorizationNotResolved
    case unauthorized
    case selectionUnavailable
    case tokenExpired
    case tokenInvalid
    case selectionUnavailableWithToken
}

// Refer to https://confluence.dev.bbc.co.uk/display/mp/Error+Model as required
@objc public class BBCSMPMediaSelectorErrorTransformer: NSObject {
    @objc public static func convertTypeToNSError(_ errorType: BBCSMPMediaSelectorErrorType) -> NSError {
        var errorCode: Int
        var localizedErrorDescription: String = NSStringFromBBCSMPErrorEnumeration(BBCSMPErrorEnumeration.mediaResolutionFailed)
        
        switch errorType {
        case .generic:
            errorCode = SMPErrorCodes.MediaResolution.generic
        case .geolocation:
            errorCode = SMPErrorCodes.MediaResolution.geolocation
            localizedErrorDescription = NSStringFromBBCSMPErrorEnumeration(BBCSMPErrorEnumeration.geolocation)
        case .authorizationNotResolved:
            errorCode = SMPErrorCodes.MediaResolution.authorizationNotResolved
        case .unauthorized:
            errorCode = SMPErrorCodes.MediaResolution.unauthorized
        case .selectionUnavailable:
            errorCode = SMPErrorCodes.MediaResolution.selectionUnavailable
        case .tokenExpired:
            errorCode = SMPErrorCodes.MediaResolution.tokenExpired
        case .tokenInvalid:
            errorCode = SMPErrorCodes.MediaResolution.tokenInvalid
        case .selectionUnavailableWithToken:
            errorCode = SMPErrorCodes.MediaResolution.selectionUnavailableWithToken
            localizedErrorDescription = NSStringFromBBCSMPErrorEnumeration(BBCSMPErrorEnumeration.mediaResolutionFailedWithToken)
        }
        
        return NSError(domain: SMPErrorDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: localizedErrorDescription])
    }
    
    @objc public static func convertMediaSelectorErrorToNSError(_ mediaSelectorError: MediaSelectorError) -> NSError {
        var smpErrorType: BBCSMPMediaSelectorErrorType
        
        switch mediaSelectorError {
        case .geoLocation:
            smpErrorType = .geolocation
        case .selectionUnavailable:
            smpErrorType = .selectionUnavailable
        case .unauthorized:
            smpErrorType = .unauthorized
        case .tokenExpired:
            smpErrorType = .tokenExpired
        case .tokenInvalid:
            smpErrorType = .tokenInvalid
        case .authorizationNotResolved:
            smpErrorType = .authorizationNotResolved
        case .selectionUnavailableWithToken:
            smpErrorType = .selectionUnavailableWithToken
        default:
            smpErrorType = .generic
        }
        
        return convertTypeToNSError(smpErrorType)
    }
    
    @objc public static func convertMediaSelectorClientErrorToNSError(_ error: NSError?) -> NSError {
        
        var errorCode: Int = SMPErrorCodes.MediaAvailability.unknownError
        var errorInfo = [String: Any]()
        
        if let error = error,
           error.domain == MediaSelectorClientErrorDomain,
           let msError = MediaSelectorClientError(rawValue: error.code) {
            errorInfo[NSURLErrorKey] = error
            errorInfo[NSLocalizedDescriptionKey] = error.localizedDescription
            
            switch msError {
            case .connectionsExhausted:
                errorCode = SMPErrorCodes.MediaAvailability.connectionsExhausted
            case .invalidRequest:
                errorCode = SMPErrorCodes.MediaResolution.invalidRequest
            default:
                errorCode = SMPErrorCodes.MediaAvailability.unknownError
            }
        }
            
        return NSError(domain: SMPErrorDomain, code: errorCode, userInfo: errorInfo)
    }
}
