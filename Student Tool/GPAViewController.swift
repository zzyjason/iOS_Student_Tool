//
//  GPAViewController.swift
//  Student Tool
//
//  Created by Jason Zhao on 8/13/17.
//  Copyright © 2017 N/A. All rights reserved.
//

import UIKit
import CoreData


class GPAViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var coreDataContainer = AppDelegate.persistentContainer
    
    let context = AppDelegate.persistentContainer.viewContext

    @IBOutlet weak var ClassName: UITextField!
        {
        didSet{
            ClassName.delegate=self
        }
    }
    
    @IBOutlet weak var Grade: UITextField!
        {
        didSet{
            Grade.delegate=self

            
        }
    }
    
    @IBOutlet weak var Credits: UITextField!
        {
        didSet{
            Credits.delegate=self
            Credits.keyboardType=UIKeyboardType.numberPad
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == ClassName)
        {
            textField.resignFirstResponder()
            DropDownUI(Show: true)
            
            
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == Grade)
        {
            ClassName.resignFirstResponder()
            Credits.resignFirstResponder()
            DropDownUI(Show: true)
            
            return false

        }
        DropDownUI(Show: false)
        if(textField==Credits)
        {
            CreditUI(Show: true)
        }
        return true
    }


    
    @IBOutlet weak var GradeDropDown: UIPickerView!
        {
        didSet{
            GradeDropDown.delegate=self
            GradeDropDown.dataSource=self

        }
    }
    
    
    let Grades = ["A+","A","A-","B+","B","B-","C+","C","C-","D+","D","D-","F"]
    var Selected: Int = 0
    
    @IBOutlet weak var SelectButton: UIButton!
    
    @IBOutlet weak var SelectUI: UILabel!
    
    @IBAction func SelectGrade(_ sender: UIButton) {
        
        Grade.text = Grades[Selected]
        
        DropDownUI(Show: false)
        
        Credits.becomeFirstResponder()
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField==Credits)
        {
            CreditUI(Show: false)
        }
        return true
    }
    
    func DropDownUI(Show:Bool) {
        if(!Show)
        {
            GradeDropDown.isHidden=true
            
            SelectButton.isHidden=true
            
            SelectUI.isHidden=true
        }
        else
        {
            GradeDropDown.isHidden=false
            
            SelectButton.isHidden=false
            
            SelectUI.isHidden=false
        }
    }
    
    @IBOutlet weak var CreditKeyPadUI: UILabel!
    
    @IBOutlet weak var CreditKeyPadButton: UIButton!
    
    
    func CreditUI(Show:Bool) {
        if(!Show)
        {
            CreditKeyPadUI.isHidden=true
            CreditKeyPadButton.isHidden=true
            Credits.resignFirstResponder()
        }
        else
        {
            CreditKeyPadUI.isHidden=false
            CreditKeyPadButton.isHidden=false

        }
    }
    
    @IBAction func DoneTypingCredit(_ sender: UIButton) {
        CreditUI(Show: false)
    }
    

    @IBAction func Save(_ sender: UIButton) {
        if (!(ClassName.text?.isEmpty)! && !(Grade.text?.isEmpty)! && !(Credits.text?.isEmpty)!)
        {
            let newClass = Class(context: context)
            newClass.title = ClassName.text
            newClass.credits = Int16(Credits.text!)!
            newClass.grade = Grade.text
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
        else
        {
            var Check:Bool = false
            
            if(ClassName.text?.isEmpty)!
            {
                ClassName.backgroundColor = UIColor.red.withAlphaComponent(0.15)
                
                ClassName.becomeFirstResponder()
                Check=true
            }
            else
            {
                ClassName.backgroundColor = UIColor.clear
            }
            
            
            if(Grade.text?.isEmpty)!
            {
                Grade.backgroundColor = UIColor.red.withAlphaComponent(0.15)
                
                if !Check
                {
                    DropDownUI(Show: true)
                    Check=true
                }
            }
            else
            {
                Grade.backgroundColor = UIColor.clear
            }
            
            if( Credits.text?.isEmpty)!
            {
                Credits.backgroundColor = UIColor.red.withAlphaComponent(0.15)
                
                if !Check
                {
                    CreditUI(Show: true)
                    Credits.becomeFirstResponder()
                }
            }
            else
            {
                Credits.backgroundColor = UIColor.clear
            }
            
            
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (GradeDropDown) != nil{
            if(pickerView==GradeDropDown)
            {
                return Grades.count
            }
        }
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (GradeDropDown) != nil{
            if(pickerView==GradeDropDown)
            {
                return Grades[row]
            }
        }
        return "Error"
    }
    

    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Selected = row
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        DropDownUI(Show: false)
        CreditUI(Show: false)
        ClassName.becomeFirstResponder()
    }
    


    
    
    
}
