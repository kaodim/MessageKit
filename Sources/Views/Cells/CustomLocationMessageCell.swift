//
//  CustomLocationMessageCell.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 30/11/2017.
//

import Foundation

import UIKit
import MapKit

open class CustomLocationMessageCell: MessageCollectionViewCell {
    open override class func reuseIdentifier() -> String { return "messagekit.cell.customlocation" }

    // MARK: - Properties

    private lazy var customImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
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
    
    open var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override open func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(customImageView)
        messageContainerView.addSubview(customLabel)
        customImageView.addSubview(activityIndicator)
        setupConstraints()
    }

    private func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let centerX = activityIndicator.centerXAnchor.constraint(equalTo: customImageView.centerXAnchor)
        let centerY = activityIndicator.centerYAnchor.constraint(equalTo: customImageView.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }

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
        case .customLocation(let location, let attributedText):
            guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else { return }
            let options = displayDelegate.snapshotOptionsForLocation(message: message, at: indexPath, in: messagesCollectionView)
            let annotationView = displayDelegate.annotationViewForLocation(message: message, at: indexPath, in: messagesCollectionView)
            let animationBlock = displayDelegate.animationBlockForLocation(message: message, at: indexPath, in: messagesCollectionView)

            customImageView.frame = UIEdgeInsetsInsetRect(messageContainerView.bounds, imageInset)
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
            setMapSnaphotImage(for: location, annotationView: annotationView, options: options, animation: animationBlock)
        default:
            return
        }
    }

    open func setMapSnaphotImage(for location: CLLocation, annotationView: MKAnnotationView?, options: LocationMessageSnapshotOptions, animation: ((UIImageView) -> Void)?) {

        activityIndicator.startAnimating()

        let snapshotOptions = MKMapSnapshotOptions()
        snapshotOptions.region = MKCoordinateRegion(center: location.coordinate, span: options.span)
        snapshotOptions.size = messageContainerView.frame.size
        snapshotOptions.showsBuildings = options.showsBuildings
        snapshotOptions.showsPointsOfInterest = options.showsPointsOfInterest

        let snapShotter = MKMapSnapshotter(options: snapshotOptions)
        snapShotter.start { (snapshot, error) in
            defer {
                self.activityIndicator.stopAnimating()
            }
            guard let snapshot = snapshot, error == nil else {
                //show an error image?
                return
            }

            guard let annotationView = annotationView else {
                self.customImageView.image = snapshot.image
                return
            }

            UIGraphicsBeginImageContextWithOptions(snapshotOptions.size, true, 0)

            snapshot.image.draw(at: .zero)

            var point = snapshot.point(for: location.coordinate)
            //Move point to reflect annotation anchor
            point.x -= annotationView.bounds.size.width / 2
            point.y -= annotationView.bounds.size.height / 2
            point.x += annotationView.centerOffset.x
            point.y += annotationView.centerOffset.y

            annotationView.image?.draw(at: point)
            let composedImage = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()

            self.customImageView.image = composedImage
            animation?(self.customImageView)
        }
    }
}
