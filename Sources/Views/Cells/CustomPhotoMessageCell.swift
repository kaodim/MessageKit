//
//  CustomPhotoMessageCell.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 29/11/2017.
//

import UIKit

open class CustomPhotoMessageCell: MessageCollectionViewCell {
    open override class func reuseIdentifier() -> String { return "messagekit.cell.customphotomessage" }

    // MARK: - Properties

    private lazy var customImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var customLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override open func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(customImageView)
        messageContainerView.addSubview(customLabel)
        customImageView.addSubview(activityIndicator)
        setupConstraints()
    }

    private func setupConstraints() {
        let centerX = activityIndicator.centerXAnchor.constraint(equalTo: customImageView.centerXAnchor)
        let centerY = activityIndicator.centerYAnchor.constraint(equalTo: customImageView.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }

    // MARK: - Methods

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        activityIndicator.startAnimating()

        let isFromCurrentSender = messagesCollectionView.messagesDataSource?.isFromCurrentSender(message: message) ?? false
        let imageInset: UIEdgeInsets
        if isFromCurrentSender {
            imageInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 10.0)
        } else {
            imageInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
        }

        switch message.data {
        case .customPhoto(let image, let attributedText):
            activityIndicator.stopAnimating()
            customImageView.frame = UIEdgeInsetsInsetRect(messageContainerView.bounds, imageInset)
            customImageView.image = image
            customLabel.attributedText = attributedText
    
            if let attributed = attributedText, !attributed.string.isEmpty {
                let labelWidth: CGFloat = customImageView.bounds.width - 16.0
                let labelHeight: CGFloat = attributed.height(considering: labelWidth) + 16.0
                let contentHeight: CGFloat = messageContainerView.bounds.height
                let contentPaddings: CGFloat = 15.0
                customImageView.frame.size.height = contentHeight - labelHeight - contentPaddings
                customLabel.frame = CGRect(
                    x: customImageView.frame.origin.x + 8.0,
                    y: customImageView.bounds.height + 8.0,
                    width: labelWidth,
                    height: labelHeight
                )
            } else {
                customLabel.frame = .zero
            }
        case .customImage(let url, let attributedText):
            customImageView.frame = UIEdgeInsetsInsetRect(messageContainerView.bounds, imageInset)
            customImageView.downloadImageAsync(url: url, completion: {
                self.activityIndicator.stopAnimating()
            })
            customLabel.attributedText = attributedText

            if let attributed = attributedText, !attributed.string.isEmpty {
                let labelWidth: CGFloat = customImageView.bounds.width - 16.0
                let labelHeight: CGFloat = attributed.height(considering: labelWidth) + 16.0
                let contentHeight: CGFloat = messageContainerView.bounds.height
                let contentPaddings: CGFloat = 15.0
                customImageView.frame.size.height = contentHeight - labelHeight - contentPaddings
                customLabel.frame = CGRect(
                    x: customImageView.frame.origin.x + 8.0,
                    y: customImageView.bounds.height + 8.0,
                    width: labelWidth,
                    height: labelHeight
                )
            } else {
                customLabel.frame = .zero
            }
        default:
            return
        }
    }
}
