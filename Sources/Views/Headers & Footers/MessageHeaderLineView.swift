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
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        self.backgroundColor = UIColor.color(0xf2f2f2)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: bounds.height + 26),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor), titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
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
