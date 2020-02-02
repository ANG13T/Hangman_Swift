//
//  ViewController.swift
//  Hangman
//
//  Created by Angelina Tsuboi on 2/1/20.
//  Copyright © 2020 Angelina Tsuboi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var guessWord: UILabel!
   
    
    var words = ["dog", "zebra", "computer", "xcode", "flower", "snowman", "phone"]
    var selectedWord = ""
    var tempWord = [String]()
    var displayWord = [String]()
    var containerWord = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genWord()
    }
    
    func checkWord(letter: String){
        
        if(tempWord.contains(letter)){
            var remIndex = tempWord.firstIndex(of: letter)
            var containLetterIndex = containerWord.firstIndex(of: letter)
            tempWord.remove(at: remIndex!)
            tempWord.isEmpty ? nextLevel() : correct()
            displayWord[containLetterIndex!] = letter
            print(displayWord)
            print(tempWord)
            guessWord.text = ""
            for i in 0..<displayWord.count{
                guessWord.text! += displayWord[i]
            }
            
        }else{
            incorrect()
        }
    }
    
    func incorrect(){
        let ac = UIAlertController(title: "Incorrect!", message: "Try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated:true)
    }
    
    func correct(){
        let ac = UIAlertController(title: "Correct!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated:true)
    }
    
    func nextLevel(){
        let ac = UIAlertController(title: "You found out the word!", message: "Next Word", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default){ (action) in
            self.genWord()
        })
        present(ac, animated:true)
    }
    
    
    
    func genWord(){
        displayWord.removeAll()
        containerWord.removeAll()
        
        words.shuffle()
        selectedWord = words[0]
        print(selectedWord)
        for char in selectedWord{
            tempWord.append(String(char))
            containerWord.append(String(char))
        }
        guessWord.text = String(repeating: "*", count: tempWord.count)
        for i in 0..<tempWord.count{
            displayWord.append("*")
        }
    }

    
    @IBAction func guessButtonClicked(_ sender: Any) {
        var textfield = UITextField()
        let ac = UIAlertController(title: "Guess Letter", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Done", style: .default) { (action) in
            if(textfield.text?.count ?? 0 > 1){
                print("Only one letter")
            }else{
                self.checkWord(letter: textfield.text!)
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Add Letter"
            textfield = alertTextField
        }
        
        present(ac, animated: true)
    }
    
}

