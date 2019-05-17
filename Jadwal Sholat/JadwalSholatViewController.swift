//
//  JadwalSholatViewController.swift
//  Jadwal Sholat
//
//  Created by asad on 16/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON

class JadwalSholatViewController: UIViewController {
    
    @IBOutlet weak var lblKota: UILabel!
    @IBOutlet weak var lblTanggal: UILabel!
    @IBOutlet weak var lblSubuh: UILabel!
    @IBOutlet weak var lblImsak: UILabel!
    @IBOutlet weak var lblDzuhur: UILabel!
    @IBOutlet weak var lblAshar: UILabel!
    @IBOutlet weak var lblMaghrib: UILabel!
    @IBOutlet weak var lblIsya: UILabel!
    
    var terimaId : String?
    var terimaKota : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.banghasan.com/sholat/format/json/jadwal/kota/\(terimaId!)/tanggal/\(getDate())"
        
        Alamofire.request(url).responseSwiftyJSON { (responseJadwal) in
            
            let jadwal = responseJadwal.result.value!["jadwal"]
            let data = jadwal["data"]
            
            self.lblKota.text = self.terimaKota
            self.lblTanggal.text = data["tanggal"].stringValue
            self.lblSubuh.text = data["subuh"].stringValue
            self.lblImsak.text = data["imsak"].stringValue
            self.lblDzuhur.text = data["dzuhur"].stringValue
            self.lblAshar.text = data["ashar"].stringValue
            self.lblMaghrib.text = data["maghrib"].stringValue
            self.lblIsya.text = data["isya"].stringValue
            
            print(data["isya"].stringValue)
        }
        
        print(getDate())
        print(terimaId!)
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getDate() -> String{
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        
        return formattedDate
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
