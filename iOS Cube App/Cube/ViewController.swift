//
//  ViewController.swift
//  Cube
//
//  Created by Yunxiao Wang on 8/11/17.
//  Copyright © 2017 Min Zhou. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var arrayOfStates: [Int] = []
    var z = 0
    @IBOutlet var switches: [UISwitch]!
    @IBAction func changed(_ sender: UISwitch) {
        let tagNum = sender.tag;
        let index = 16 * (z) + tagNum - 1
        var x = 0
        var y = 0
        var state = 0
        
        if sender.isOn
        {
            state = 1
        } else
        {
            state = 0
        }
        
        if tagNum % 4 == 0
        {
            x = 3
        }
        else
        {
            x = tagNum % 4 - 1
        }
        
        arrayOfStates[index] = state
        
        switch tagNum {
        case 1...4:
            y = 0
        case 5...8:
            y = 1
        case 9...12:
            y = 2
        case 13...16:
            y = 3
        default:
            break;
        }
        updateServer(x: x, y: y, state: state)
    }
    
    @IBAction func layerChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            z = 0
            for aSwitch in self.switches
            {
                let index = aSwitch.tag - 1
                if (arrayOfStates[index] == 0)
                {
                    aSwitch.setOn(false, animated: false)
                }
                else
                {
                    aSwitch.setOn(true, animated: true)
                }
                print(index)
            }
        case 1:
            z = 1
            for aSwitch in self.switches
            {
                let index = (16 + aSwitch.tag) - 1
                if (arrayOfStates[index] == 0)
                {
                    aSwitch.setOn(false, animated: false)
                }
                else
                {
                    aSwitch.setOn(true, animated: true)
                }
                 print(index)
            }
        case 2:
            z = 2
            for aSwitch in self.switches
            {
                let index = (32 + aSwitch.tag) - 1
                if (arrayOfStates[index] == 0)
                {
                    aSwitch.setOn(false, animated: false)
                }
                else
                {
                    aSwitch.setOn(true, animated: true)
                }
                 print(index)
            }
        case 3:
            z = 3
            for aSwitch in self.switches
            {
                let index = (48 + aSwitch.tag) - 1
                if (arrayOfStates[index] == 0)
                {
                    aSwitch.setOn(false, animated: false)
                }
                else
                {
                    aSwitch.setOn(true, animated: true)
                }
                print(index)
            }
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        INPreferences.requestSiriAuthorization {
                status in
                if status == .authorized {
            }
        }
        for _ in 1...64 {
            arrayOfStates.append(0);
        }
    }

    func updateServer(x: Int, y: Int, state: Int)  {
        var request = URLRequest(url: URL(string: "http://108.61.72.9/processing.php")!)
        request.httpMethod = "POST"
        let postString = "x=\(x)&y=\(y)&z=\(z)&state=\(state)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else
            {    
                print(error!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print(responseString!)
        }
        task.resume()
    }
}

