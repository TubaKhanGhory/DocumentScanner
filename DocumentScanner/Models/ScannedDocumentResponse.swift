//
//  ScannedDocumentResponse.swift
//  DocumentScanner
//
//  Created by TUBA on 21/10/2024.
//

import Foundation
import BlinkID
import UIKit
struct ScannedDocumentResponse: Codable {
    var address: String?
    var dateOfBirth: String?
    var dateOfExpiry: String?
    var dateOfIssue: String?
    var documentNumber: String?
    var firstName: String?
    var fullName: String?
    var lastName: String?
    var fathersName: String?
    var mothersName: String?
    var sex: String?
    var localizedName: String?
    var additionalNameInformation: String?
    var additionalAddressInformation: String?
    var placeOfBirth: String?
    var nationality: String?
    var residentialStatus: String?
    var maritalStatus: String?
    var personalIdNumber: String?
    var age: String?
    var documentType: String?
    var issuer: String?
    var issuerName: String?
    
    // Store images as Data instead of UIImage
    var faceImageData: Data?
    var fullDocumentFrontImageData: Data?
    var fullDocumentBackImageData: Data?

    init(from result: MBBlinkIdMultiSideRecognizerResult) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        self.address = result.address?.description
        self.dateOfBirth = result.dateOfBirth?.date.map { dateFormatter.string(from: $0) }
        self.dateOfExpiry = result.dateOfExpiry?.date.map { dateFormatter.string(from: $0) }
        self.dateOfIssue = result.dateOfIssue?.date.map { dateFormatter.string(from: $0) }
        self.documentNumber = result.documentNumber?.description
        self.firstName = result.firstName?.description
        self.fullName = result.fullName?.description
        self.lastName = result.lastName?.description
        self.fathersName = result.fathersName?.description
        self.mothersName = result.mothersName?.description
        self.sex = result.sex?.description
        self.localizedName = result.localizedName?.description
        self.additionalNameInformation = result.additionalNameInformation?.description
        self.additionalAddressInformation = result.additionalAddressInformation?.description
        self.placeOfBirth = result.placeOfBirth?.description
        self.nationality = result.nationality?.description
        self.residentialStatus = result.residentialStatus?.description
        self.maritalStatus = result.maritalStatus?.description
        self.personalIdNumber = result.personalIdNumber?.description
        self.age = result.age.description
        self.documentType = result.mrzResult?.documentType.rawValue.description
        self.issuer = result.mrzResult?.issuer.description
        self.issuerName = result.mrzResult?.issuerName.description
        
        // Assuming the MBImage has a property that gives you data directly
        self.faceImageData = result.faceImage?.image?.pngData() // Use Data type for images
        self.fullDocumentFrontImageData = result.fullDocumentFrontImage?.image?.pngData()
        self.fullDocumentBackImageData = result.fullDocumentBackImage?.image?.pngData()
    }
}
