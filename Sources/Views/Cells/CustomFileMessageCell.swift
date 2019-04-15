//
//  CustomFileMessageCell.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 30/11/2017.
//

import UIKit

open class CustomFileMessageCell: MessageCollectionViewCell {
    open override class func reuseIdentifier() -> String { return "messagekit.cell.customfilemessage" }

    // MARK: - Properties

    private lazy var customIconView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var customLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.isUserInteractionEnabled = true
        return label
    }()

    // MARK: - Methods

    override open func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(customIconView)
        messageContainerView.addSubview(customLabel)
    }

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        let isFromCurrentSender = messagesCollectionView.messagesDataSource?.isFromCurrentSender(message: message) ?? false
        let imageInset: UIEdgeInsets
        if isFromCurrentSender {
            imageInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 15.0)
        } else {
            imageInset = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 5.0)
        }

        switch message.data {
        case .customFile(let icon, let attributedText):
            customIconView.frame = UIEdgeInsetsInsetRect(messageContainerView.bounds, imageInset)
            customIconView.frame.size = CGSize(width: customIconView.bounds.height, height: customIconView.bounds.height)
            customIconView.image = icon
            customLabel.frame = CGRect(
                x: customIconView.bounds.width + 20.0,
                y: customIconView.frame.origin.y,
                width: messageContainerView.bounds.width - customIconView.bounds.width - 35.0,
                height: customIconView.bounds.height
            )
            customLabel.attributedText = attributedText
        default:
            return
        }
    }
    
}
