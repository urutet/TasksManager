//
//  AccountCollectionViewCell.swift
//  converterapp
//
//  Created by Yushkevich Ilya on 27.04.22.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let contentViewShadowOpacity: Float = 1
    static let contentViewShadowRadius: CGFloat = 1
    static let contentViewShadowOffset: CGSize = .zero
    static let contentViewCornerRadius: CGFloat = 10
  }
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .center
    
    return label
  }()
  private let contentLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .center
    
    return label
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  // MARK: - API
  func setNote(_ note: NoteInfo) {
    titleLabel.text = note.title
    contentLabel.text = note.content
  }
  
  // MARK: - Setups
  private func setupUI() {
    contentView.backgroundColor = .systemYellow
    contentView.layer.masksToBounds = false
    contentView.layer.shadowOpacity = Constants.contentViewShadowOpacity
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOffset = Constants.contentViewShadowOffset
    contentView.layer.shadowRadius = Constants.contentViewShadowRadius
    contentView.layer.cornerRadius = Constants.contentViewCornerRadius
    
    contentView.addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(contentLabel)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  // MARK: - Helpers
}
