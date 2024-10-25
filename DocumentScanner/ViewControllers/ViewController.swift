//
//  ViewController.swift
//  DocumentScanner
//
//  Created by TUBA on 21/10/2024.
//

import UIKit
import BlinkID

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var idImage: UIImageView!
    @IBOutlet weak var passportImage: UIImageView!
    @IBOutlet weak var employmentPassImage: UIImageView!
    @IBOutlet weak var licenseImage: UIImageView!
    
    
    //MARK: - Recognizers
    
    //Passport recognizer
    var recognizerRunnerViewController: UIViewController?
    
    //For scanning ID Card
    var blinkIdMultiSideRecognizer : MBBlinkIdMultiSideRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting images color to white
        setImages()
        self.view.backgroundColor = .white
    }

    
    @IBAction func scanButtonTapped(_ sender: UIButton) {
        var success: Bool = true
        MBMicroblinkSDK.shared().setLicenseKey(licenseKey) { error in
            let alert = UIAlertController(title: "Error", message: "License Key is not valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            success = false
        }
        
        if success == true{
            self.idViewTapped()
        }
    }
    
    func setImages(){
        setImageTintColor(imageName: "id", imageView: self.idImage, color: .white)
        setImageTintColor(imageName: "passport", imageView: self.passportImage, color: .white)
        setImageTintColor(imageName: "driving license", imageView: self.licenseImage, color: .white)
        setImageTintColor(imageName: "employment license", imageView: self.employmentPassImage, color: .white)
    }
    
    func setImageTintColor(imageName: String, imageView: UIImageView, color: UIColor){
        let templateImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.image = templateImage
        imageView.tintColor = color
    }

}


// MARK: - ID,Passport,License,EmploymentPass Recognizer Delegates
extension ViewController: MBBlinkIdOverlayViewControllerDelegate{
    
    //Delegate Methods
    func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController, state: MBRecognizerResultState) {
        if (self.blinkIdMultiSideRecognizer?.result.resultState == MBRecognizerResultState.valid) {
            guard let result = blinkIdMultiSideRecognizer?.result, result.resultState == .valid else {
                print("Invalid result or no result found")
                return
            }

            // Create ScannedDocumentResponse using the new initializer
            let scannedDocumentResponse = ScannedDocumentResponse(from: result)
            
            self.dismiss(animated: true)
            
            //Move to OCRDataTableViewCell
            let story = UIStoryboard.init(name: "Main", bundle: .main)
            let OCRDataVC = story.instantiateViewController(withIdentifier: "OCRDataViewController") as! OCRDataViewController
            OCRDataVC.IdDataModel = scannedDocumentResponse
            self.navigationController?.present(OCRDataVC, animated: true)
        }
    }
    
    func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        print("blinkIdOverlayViewControllerDidTapClose")
        self.dismiss(animated: true)
    }
    
    
    //Setup functions
    private func idViewTapped() {
      
      /** Create BlinkID recognizer */
      self.blinkIdMultiSideRecognizer = MBBlinkIdMultiSideRecognizer()
        self.blinkIdMultiSideRecognizer?.returnFaceImage = true
        self.blinkIdMultiSideRecognizer?.returnFullDocumentImage = true

      /** Create BlinkID settings */
      let settings : MBBlinkIdOverlaySettings = MBBlinkIdOverlaySettings()

      /** Crate recognizer collection */
      let recognizerList = [self.blinkIdMultiSideRecognizer!]
      let recognizerCollection : MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)

      /** Create your overlay view controller */
      let blinkIdOverlayViewController : MBBlinkIdOverlayViewController = MBBlinkIdOverlayViewController(settings: settings, recognizerCollection: recognizerCollection, delegate: self)

      /** Create recognizer view controller with wanted overlay view controller */
      let recognizerRunneViewController : UIViewController = MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: blinkIdOverlayViewController) ?? UIViewController()

      /** Present the recognizer runner view controller. You can use other presentation methods as well (instead of presentViewController) */
      self.present(recognizerRunneViewController, animated: true, completion: nil)
    }
    
}
