//
//  ViewController.swift
//  Jadwal Sholat
//
//  Created by asad on 16/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchKota: UISearchBar!
    @IBOutlet weak var tableKota: UITableView!
    
    var dataKota = [[String : Any]] ()
    var arrCariKota = [[String : Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableKota.delegate = self
        tableKota.dataSource = self
        searchKota.delegate = self
        
        Alamofire.request(Constant.urlDaftarKota).responseSwiftyJSON { (response2) in
            
            self.dataKota = response2.result.value?["kota"].arrayObject as! [[String : Any]]
            
            if self.dataKota.count > 0 {
                self.cariKota(keyword: "")
                //self.tableKota.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCariKota.count
        //return dataKota.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableKota.dequeueReusableCell(withIdentifier: "DaftarKota", for: indexPath)
        
        let data = arrCariKota[indexPath.row]
        //let data = dataKota[indexPath.row]
        let id = data["id"]
        let nama = data["nama"]
        
        cell.textLabel?.text = id as? String
        cell.detailTextLabel?.text = nama as? String
        
        return cell
    }
    
    // action click untuk row table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tujuan = storyboard.instantiateViewController(withIdentifier: "JadwalSholat") as! JadwalSholatViewController
        
        //let data = dataKota[indexPath.row]
        let data = arrCariKota[indexPath.row]
        let id = data["id"]
        let namaKota = data["nama"]
        
        tujuan.terimaId = id as? String
        tujuan.terimaKota = namaKota as? String
        
        show(tujuan, sender: indexPath)
    }
    
    func cariKota(keyword : String){
        
        arrCariKota.removeAll()
        
        if keyword != ""{
            
            for isi in dataKota{
                
                let namaKota = isi["nama"] as? String
                
                if namaKota!.contains(keyword.uppercased()){
                    self.arrCariKota.append(isi)
                }
            }
        }
        else{
            self.arrCariKota = self.dataKota
        }
        
        tableKota.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cariKota(keyword: searchText)
    }
}
