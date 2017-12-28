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

    open let titleLabel = UILabel()
    open let leadingLineView = UIView()
    open let trailingLineView = UIView()
    
    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 13.0)
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)

        leadingLineView.translatesAutoresizingMaskIntoConstraints = false
        leadingLineView.backgroundColor = UIColor.lightGray
        addSubview(leadingLineView)

        trailingLineView.translatesAutoresizingMaskIntoConstraints = false
        trailingLineView.backgroundColor = UIColor.lightGray
        addSubview(trailingLineView)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let lineHeight: CGFloat = 2.0

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: bounds.height),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            leadingLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingLineView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8.0),
            leadingLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingLineView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])

        NSLayoutConstraint.activate([
            trailingLineView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            trailingLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trailingLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingLineView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(attributedText: NSAttributedString?) {
        guard let attributedText = attributedText else {
            /// Hide the line
            leadingLineView.isHidden = true
            trailingLineView.isHidden = true
            titleLabel.attributedText = nil
            return
        }
        leadingLineView.isHidden = false
        trailingLineView.isHidden = false
        titleLabel.attributedText = attributedText
    }
}
