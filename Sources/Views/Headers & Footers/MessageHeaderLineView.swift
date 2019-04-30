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

        let masterContentView = UIView()
        masterContentView.translatesAutoresizingMaskIntoConstraints = false
        masterContentView.backgroundColor = UIColor.color(0xf2f2f2)
        addSubview(masterContentView)
        NSLayoutConstraint.activate([
            masterContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            masterContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //             contentView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: -16),
            masterContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            masterContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
            ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        titleLabel.textColor = UIColor.color(0x9b9b9b)
        titleLabel.backgroundColor = .clear
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
            titleLabel.centerXAnchor.constraint(equalTo: masterContentView.centerXAnchor), titleLabel.centerYAnchor.constraint(equalTo: masterContentView.centerYAnchor)
            ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 17.0
        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            //             contentView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: -16),
            contentView.topAnchor.constraint(equalTo: masterContentView.topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: masterContentView.bottomAnchor, constant: -10)
            //            contentView.centerXAnchor.constraint(equalTo: centerXAnchor), contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
