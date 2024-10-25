//
//  OCRDataViewController.swift
//  DocumentScanner
//
//  Created by TUBA on 25/10/2024.


import UIKit

class OCRDataViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var copyButton: UIImageView!
    
    var IdDataModel: ScannedDocumentResponse?
    var IdDataModelArr: [(String, Any?)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
        loadData()
        prioritizeFaceImageData()
        registerTableView()
    }
    
}


// MARK: - Private Functions
extension OCRDataViewController {
    
     private func setupGestureRecognizer() {
         let templateImage = UIImage(named: "copy")?.withRenderingMode(.alwaysTemplate)
         copyButton.image = templateImage
         copyButton.tintColor = .white
         
         copyButton.isUserInteractionEnabled = true
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyDataToClipboard))
         copyButton.addGestureRecognizer(tapGesture)
     }

     @objc private func copyDataToClipboard() {
         var copiedData = ""
         
         for (key, value) in IdDataModelArr {
             copiedData += "\(String(describing: ScannedDocumentKey(rawValue: key)?.displayLabel() ?? "")): \(value ?? "N/A")\n"
         }
         
         // Copy to clipboard
         UIPasteboard.general.string = copiedData
         
         // Alert to indicate success
         let alert = UIAlertController(title: "Copied", message: "Data has been copied to clipboard.", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }
    
    private func registerTableView() {
        let cellTypes: [(cellClass: AnyClass, identifier: String)] = [
            (OCRDataTableViewCell.self, OCRDataTableViewCell.identifier),
            (ImageTableViewCell.self, ImageTableViewCell.identifier)
        ]
        
        for cellType in cellTypes {
            tableView.register(
                UINib(nibName: String(describing: cellType.cellClass), bundle: .main),
                forCellReuseIdentifier: String(describing: cellType.identifier)
            )
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        guard let idDataModel = IdDataModel else { return }
        let mirror = Mirror(reflecting: idDataModel)
        
        // Create an array of key-value pairs, filtering out nil values and empty strings
        self.IdDataModelArr = mirror.children.compactMap { (label, value) in
            guard let key = label else { return nil }
            
            if let unwrappedValue = value as? CustomStringConvertible,
               !unwrappedValue.description.isEmpty {
                return (key, unwrappedValue.description)
            }
            
            // Handle image data properties
            if let imageData = value as? Data, !imageData.isEmpty {
                return (key, "Image data available")
            }
            return nil
        }
    }
    
    private func prioritizeFaceImageData() {
        // Filter out the faceImageData
        let faceImageDataPair = IdDataModelArr.first { $0.0 == ScannedDocumentKey.faceImageData.rawValue }
        
        // Remove the faceImageData from the original array
        IdDataModelArr.removeAll { $0.0 == ScannedDocumentKey.faceImageData.rawValue }
        
        // If found, insert it at the beginning of the array
        if let faceImageDataPair = faceImageDataPair {
            IdDataModelArr.insert(faceImageDataPair, at: 0)
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension OCRDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IdDataModelArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (key, value) = IdDataModelArr[indexPath.row]

        // Check if the key corresponds to an image data type
        if key == ScannedDocumentKey.fullDocumentFrontImageData.rawValue ||
           key == ScannedDocumentKey.fullDocumentBackImageData.rawValue ||
           key == ScannedDocumentKey.faceImageData.rawValue {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else {
                return UITableViewCell()
            }

            // Create a dictionary to map keys to image data properties
            let imageDataMapping: [String: Data?] = [
                ScannedDocumentKey.fullDocumentFrontImageData.rawValue: IdDataModel?.fullDocumentFrontImageData,
                ScannedDocumentKey.fullDocumentBackImageData.rawValue: IdDataModel?.fullDocumentBackImageData,
                ScannedDocumentKey.faceImageData.rawValue: IdDataModel?.faceImageData
            ]

            // Get the corresponding image data for the current key
            if let imageValue = imageDataMapping[key] as? Data {
                cell.customImageView.image = UIImage(data: imageValue)
            } else {
                cell.customImageView.image = UIImage(named: "placeholder")
            }
            
            //For header
            if let scannedKey = ScannedDocumentKey(rawValue: key) {
                cell.header.text = scannedKey.displayLabel()
            }

            return cell
        } else {
            // Dequeue OCRDataTableViewCell for other keys
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: OCRDataTableViewCell.identifier),
                for: indexPath
            ) as? OCRDataTableViewCell else {
                return UITableViewCell()
            }

            // Create a ScannedDocumentKey from the key
            if let scannedKey = ScannedDocumentKey(rawValue: key) {
                cell.header.text = scannedKey.displayLabel()
            } else {
                cell.header.text = key.capitalized
            }

            cell.value.text = value as? String ?? "N/A"

            return cell
        }
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let (key, _) = IdDataModelArr[indexPath.row]
        if key == "faceImageData" || key == "fullDocumentFrontImageData" || key == "fullDocumentBackImageData"{
            return 250.0
        } else  if key == "address" {
            return UITableView.automaticDimension
        }
        else{
            return 60.0
        }
    }
}
