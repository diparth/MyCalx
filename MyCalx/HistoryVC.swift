//
//  HistoryVC.swift
//  MyCalx
//
//  Created by Diparth Patel on 6/22/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HistoryVC: UIViewController {
    
    @IBOutlet weak var resultsTextView: UITextView!
    
    var ref = DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        resultsTextView.text = ""
        getResults()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func deleteHisory(_ sender: Any) {
        ref = Database.database().reference(withPath: "/")
        histories = [String]()
        ref.removeValue()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getResults() {
        ref = Database.database().reference(withPath: "/")
        ref.observeSingleEvent(of: .value, with: { (snap) in
            if let result = snap.value as? [String: Any] {
                if let results = result["history"] as? [String] {
                    for text in results {
                        self.resultsTextView.text = self.resultsTextView.text + "\(text) \n"
                    }
                }
            }
        })
    }
    

}
