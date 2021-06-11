//
//  ViewController.swift
//  Retouch photo studio
//
//  Created by Anisha Anisha on 2021-06-08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var IntensitySlider: UISlider!
   
    @IBOutlet weak var Img: UIImageView!
    
    var isFiltered = false
    var globalImage:UIImage?
    
    
    
    @IBAction func btnReset(_ sender: Any) {
        if isFiltered == true{
            Img.image = globalImage
        }
    }
    
    @IBOutlet weak var lblSliderValue: UILabel!
    
    @IBAction func sliderValueChange(_ sender: UISlider ) {
        
        if isFiltered == true{
            Img.image = globalImage
        }
        
        IntensitySlider.minimumValue = 0
        IntensitySlider.maximumValue = 100
       
        
        lblSliderValue.text = String(Int((sender.value).rounded()))
        
    }
    
    @IBAction func btnBlur(_ sender: UIButton) {
        
        let filterToApply = CIFilter(name: "CIBoxBlur")
        let currentValue = Int((IntensitySlider.value).rounded())
        
        filterToApply!.setValue(CIImage(image: Img.image!), forKey: kCIInputImageKey)
        filterToApply!.setValue(currentValue, forKey: kCIInputRadiusKey)
        
        showOutput(filterToApply: filterToApply!)
    }
    
    func showOutput(filterToApply: CIFilter){
        if isFiltered == false {
            globalImage = Img.image
        }
               
        let originalImage = Img.image!
               
        let context = CIContext(options: nil)
        
        let outputImg = filterToApply.outputImage
        
        let cgImg = context.createCGImage(outputImg!, from: outputImg!.extent)
        
        let processedImg = UIImage(cgImage: cgImg!)
        
        Img.image = processedImg
            isFiltered = true
       
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

