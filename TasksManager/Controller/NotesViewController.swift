//
//  AccountsViewController.swift
//  converterapp
//
//  Created by Yushkevich Ilya on 25.04.22.
//

import UIKit

final class NotesViewController: UIViewController {
  
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let accountCellIdentifier = "NoteCell"
  }
  
  private let notesRepository: NotesRepositoryProtocol = NotesRepository.instance
  private var notes = [NoteInfo]() {
    didSet {
      notesCollectionView.reloadData()
    }
  }
  
  private var notesCollectionView: UICollectionView = {
    let layout = configureLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    
    return collectionView
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Notes"
    notesCollectionView.register(
      NoteCollectionViewCell.self,
      forCellWithReuseIdentifier: Constants.accountCellIdentifier
    )
    notesCollectionView.delegate = self
    notesCollectionView.dataSource = self
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTapped)
    )
    
    if let notes = notesRepository.getNotes() {
      self.notes = notes
    }
    
    view.addSubview(notesCollectionView)
    notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      notesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
      notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // MARK: - API
  // MARK: - Setups
  
  private static func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  // MARK: - Helpers
  @objc
  private func addTapped() {
    let addNoteVC = AddNoteViewController()
    let eventHandler: (NoteInfo) -> Void = { [weak self] note in
      guard let strongSelf = self else { return }
      strongSelf.notes.append(note)
      strongSelf.notesRepository.saveNote(note)
    }
    addNoteVC.eventHandler = eventHandler
    
    addNoteVC.modalPresentationStyle = .formSheet
    present(addNoteVC, animated: true)
  }
}

extension NotesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return notes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = notesCollectionView.dequeueReusableCell(
      withReuseIdentifier: Constants.accountCellIdentifier,
      for: indexPath
    ) as? NoteCollectionViewCell {
      cell.setNote(notes[indexPath.row])
      
      return cell
    }
    return UICollectionViewCell()
  }
  
}
