//
//  ViewController.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchBTN.isEnabled = false
        searchBTN.backgroundColor = UIColor.gray
        
        insertText.addTarget(self, action: #selector(checkText(_:)), for: .editingDidEnd)
        insertPer.addTarget(self, action: #selector(checkText(_:)), for: .editingDidEnd)
    }
    
    @objc func checkText(_ sender: UITextField) {
        
        if insertText.text != "" && insertPer.text != "" {
            
            searchBTN.backgroundColor = UIColor.systemBlue
            
            searchBTN.isEnabled = true
            
        } else {
            
            searchBTN.backgroundColor = UIColor.gray
            searchBTN.isEnabled = false
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        insertText.text = ""
        insertPer.text = ""
    }
    
    @IBOutlet weak var searchBTN: UIButton!
    
    @IBOutlet weak var insertText: UITextField!
    
    @IBOutlet weak var insertPer: UITextField!
    
    @IBAction func searchBTN(_ sender: Any) {
        
        performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImage" {
            
            guard let tabBarController = segue.destination as? UITabBarController,
            
                  let nextView = tabBarController.viewControllers?[0] as? SearchViewController
            
            else { return }
            
            nextView.getSearchText = insertText.text!
            
            nextView.getPerPage = insertPer.text!
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == insertText {
            
            insertPer.becomeFirstResponder()
            
        } else {
            
            textField.endEditing(true)
        }
        
        return true
    }
}


/*
 2. collectionCell 裡面的字要換行
 3. 上拉更新
 4. 收藏我的最愛
 5. 本地儲存
 */
