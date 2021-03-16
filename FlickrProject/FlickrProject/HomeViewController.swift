//
//  HomeViewController.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/3/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insertWordTextField.addTarget(self, action: #selector(checkText(_:)), for: .editingDidEnd)
        insertPerTextField.addTarget(self, action: #selector(checkText(_:)), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBtn.isEnabled = false
        searchBtn.backgroundColor = UIColor.gray
    }
    
    @objc func checkText(_ sender: UITextField) {
        
        if insertWordTextField.text != "" && insertPerTextField.text != "" {
            
            searchBtn.backgroundColor = UIColor.systemBlue
            
            searchBtn.isEnabled = true
            
        } else {
            
            searchBtn.backgroundColor = UIColor.gray
            searchBtn.isEnabled = false
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        insertWordTextField.text = ""
        insertPerTextField.text = ""
    }
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var insertWordTextField: UITextField!
    
    @IBOutlet weak var insertPerTextField: UITextField!
    
    @IBAction func searchBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImage" {
            
            guard let tabBarController = segue.destination as? UITabBarController,
                  
                  let nextView = tabBarController.viewControllers?[0] as? SearchViewController
            
            else { return }
            
            nextView.getSearchText = insertWordTextField.text!
            
            nextView.getPerPage = insertPerTextField.text!
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == insertWordTextField {
            
            insertPerTextField.becomeFirstResponder()
            
        } else {
            
            textField.endEditing(true)
        }
        
        return true
    }
}
