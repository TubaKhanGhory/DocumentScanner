//
//  Enums+Constant.swift
//  DocumentScanner
//
//  Created by TUBA on 25/10/2024.
//

import Foundation

//MARK: - CONSTANTS

let licenseKey = "sRwCABljb20uY292YWxlbnQtc2Nhbm5lci1kZW1vAWxleUpEY21WaGRHVmtUMjRpT2pFM01qazFNRFEwT1RJNE1qTXNJa055WldGMFpXUkdiM0lpT2lJME0yVXhOamMxTlMweVpEVTRMVFJqWWpZdFltSXlPQzAzWVRNNE9XSXhPRFE1WkdFaWZRPT2D1uTBvQ/w8NHhKz2iqDxZdH31bjgZZV58nGTglk/DEq5B9hRHJsyGAFPoPctyhaVMpZd0nUm5Uf9z/Mk5GyxWFR/D7ltKccCPXqlSSkvPIkcyBJMMPrgyaBM6LoPztL2ISmtsuDL4oIb31nCFZPwaBL7/VpKxtrQ="


//MARK: - ENUMS

enum ScannedDocumentKey: String {
    case address
    case dateOfBirth
    case dateOfExpiry
    case dateOfIssue
    case documentNumber
    case firstName
    case lastName
    case fullName
    case fathersName
    case mothersName
    case localizedName
    case sex
    case additionalNameInformation
    case additionalAddressInformation
    case placeOfBirth
    case nationality
    case residentialStatus
    case maritalStatus
    case personalIdNumber
    case age
    case documentType
    case issuer
    case issuerName
    case faceImageData
    case fullDocumentFrontImageData
    case fullDocumentBackImageData

    // Function to return the corresponding label
    func displayLabel() -> String? {
        switch self {
        case .address:
            return "Address"
        case .dateOfBirth:
            return "Date Of Birth"
        case .dateOfExpiry:
            return "Date Of Expiry"
        case .dateOfIssue:
            return "Date Of Issue"
        case .documentNumber:
            return "Document Number"
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .fullName:
            return "Full Name"
        case .fathersName:
            return "Father Name"
        case .mothersName:
            return "Mother Name"
        case .localizedName:
            return "Localized Name"
        case .sex:
            return "Sex"
        case .additionalNameInformation:
            return "Additional Name Information"
        case .additionalAddressInformation:
            return "Additional Address Information"
        case .placeOfBirth:
            return "Place Of Birth"
        case .nationality:
            return "Nationality"
        case .residentialStatus:
            return "Residential Status"
        case .maritalStatus:
            return "Marital Status"
        case .personalIdNumber:
            return "Personal Id Number"
        case .age:
            return "Age"
        case .documentType:
            return "Document Type"
        case .issuer:
            return "Issuer"
        case .issuerName:
            return "Issuer Name"
        case .faceImageData:
            return "Face Image"
        case .fullDocumentFrontImageData:
            return "Full Document Front Image"
        case .fullDocumentBackImageData:
            return "Full Document Back Image"
        }
    }
}
