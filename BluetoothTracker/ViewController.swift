//
//  ViewController.swift
//  BluetoothTracker
//
//  Created by Admin on 02.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var centralManager : CBCentralManager?
    var devices : [BlueDev] = []
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    
    @IBAction func refreshTapped(_ sender: Any) {
       timer?.invalidate()
        startScan()
        startTimer()
    }
    
    func startScan() {
        devices = []
        tableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (timer) in
            self.startScan()
        })
    }
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
    
    //tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BlueTableViewCell {
            let btDevice = self.devices[indexPath.row]
            cell.nameLbl.text = btDevice.name
            cell.rssiLbl.text = String(Int(truncating: btDevice.rssi))
            return cell
        }
        return UITableViewCell()
    }
    
    
    //Bluetooth
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
            startTimer()
        }else {
            showAlert(title: "Bluetooth Error", message: "Power on your Bluetooth")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let btDevice = BlueDev()
        if let name = peripheral.name {
            btDevice.name = name
        } else {
            btDevice.name = peripheral.identifier.uuidString
        }
        btDevice.rssi = RSSI
        self.devices.append(btDevice)
        self.tableView.reloadData()
    }
}

class BlueDev {
    var name : String = ""
    var rssi : NSNumber = 0
}
