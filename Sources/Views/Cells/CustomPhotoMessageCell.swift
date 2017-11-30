//
//  CustomPhotoMessageCell.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 29/11/2017.
//

import UIKit

open class CustomPhotoMessageCell: MessageCollectionViewCell<UIView> {
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

    override func setupSubviews() {
        super.setupSubviews()
        messageContentView.addSubview(customImageView)
        messageContentView.addSubview(customLabel)
    }

    // MARK: - Methods

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        let isFromCurrentSender = messagesCollectionView.messagesDataSource?.isFromCurrentSender(message: message) ?? false
        let imageInset: UIEdgeInsets
        if isFromCurrentSender {
            imageInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 10.0)
        } else {
            imageInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
        }

        switch message.data {
        case .customPhoto(let image, let attributedText):
            customImageView.frame = UIEdgeInsetsInsetRect(messageContentView.bounds, imageInset)
            customImageView.image = image
            customLabel.attributedText = attributedText
    
            if let attributed = attributedText, !attributed.string.isEmpty {
                let labelWidth: CGFloat = customImageView.bounds.width - 16.0
                let labelHeight: CGFloat = attributed.height(considering: labelWidth) + 16.0
                let contentHeight: CGFloat = messageContentView.bounds.height
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
