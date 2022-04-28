//
//  AddNoteViewController.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 28.04.22.
//

import UIKit

class AddNoteViewController: UIViewController {
  
  // MARK: - Properties
  // MARK: Public
  var eventHandler: ((NoteInfo) -> Void)?
  // MARK: Private
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    
    return stackView
  }()
  
  private let titleTextField: UITextField = {
    let textfield = UITextField()
    
    textfield.translatesAutoresizingMaskIntoConstraints = false
    textfield.borderStyle = .line
    textfield.font = .systemFont(ofSize: 20, weight: .bold)
    
    return textfield
  }()
  
  private let contentTextView: UITextView = {
    let textView = UITextView()
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .systemFont(ofSize: 15, weight: .regular)
    textView.backgroundColor = .clear
    return textView
  }()
  
  private let addButton: UIButton = {
    let button = UIButton()
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Save Note", for: .normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = .systemBlue
    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    addSubviews()
    addConstraints()
    addButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
  }
  
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    view.backgroundColor = .systemYellow
  }
  
  private func addSubviews() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(titleTextField)
    stackView.addArrangedSubview(contentTextView)
    stackView.addArrangedSubview(addButton)
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      titleTextField.heightAnchor.constraint(equalToConstant: 100),
      contentTextView.heightAnchor.constraint(equalToConstant: 500),
      addButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  // MARK: - Helpers
  @objc
  private func addNote() {
    if
      let title = titleTextField.text,
      let content = contentTextView.text
    {
      let note = NoteInfo(title: title, content: content)
      
      eventHandler?(note)
      dismiss(animated: true)
    }
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
