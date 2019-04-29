//
//  MessageLineHeaderView.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 28/12/2017.
//

import Foundation

open class MessageLineHeaderView: MessageHeaderView {
    open override class func reuseIdentifier() -> String { return "messagekit.header.line" }

    // MARK: - Properties

    let titleLabel = UILabel()

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        titleLabel.textColor = UIColor.color(0x9b9b9b)
        titleLabel.backgroundColor = .clear


        addSubview(titleLabel)

        self.backgroundColor = UIColor.color(0xf2f2f2)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: bounds.height),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor), titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 17.0
        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
             contentView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: -16),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor), contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])

        self.bringSubview(toFront: titleLabel)

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(attributedText: NSAttributedString?) {
        guard let attributedText = attributedText else {
            /// Hide the line
            titleLabel.attributedText = nil
            return
        }
        titleLabel.attributedText = attributedText
    }
}
