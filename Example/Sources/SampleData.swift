/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import MessageKit
import CoreLocation

final class SampleData {

    static let shared = SampleData()

    private init() {}

    let messageTextValues = [
        "Ok",
        "k",
        "lol",
        "1-800-555-0000",
        "One Infinite Loop Cupertino, CA 95014 This is some extra text that should not be detected.",
        "This is an example of the date detector 11/11/2017. April 1st is April Fools Day. Next Friday is not Friday the 13th.",
        "https://github.com/SD10",
        "Check out this awesome UI library for Chat",
        "My favorite things in life don’t cost any money. It’s really clear that the most precious resource we all have is time.",
        """
            You know, this iPhone, as a matter of fact, the engine in here is made in America.
            And not only are the engines in here made in America, but engines are made in America and are exported.
            The glass on this phone is made in Kentucky. And so we've been working for years on doing more and more in the United States.
            """,
        """
            Remembering that I'll be dead soon is the most important tool I've ever encountered to help me make the big choices in life.
            Because almost everything - all external expectations, all pride, all fear of embarrassment or failure -
            these things just fall away in the face of death, leaving only what is truly important.
            """,
        "I think if you do something and it turns out pretty good, then you should go do something else wonderful, not dwell on it for too long. Just figure out what’s next.",
        "Price is rarely the most important thing. A cheap product might sell some units. Somebody gets it home and they feel great when they pay the money, but then they get it home and use it and the joy is gone."
    ]

    let messagePhotoDescriptions = [
        "This is a short photo description.",
        "This is a long photo description. Price is rarely the most important thing. A cheap product might sell some units. Somebody gets it home and they feel great when they pay the money, but then they get it home and use it and the joy is gone",
        "This is a long photo description with new line.\nYou know, this iPhone, as a matter of fact, the engine in here is made in America. And not only are the engines in here made in America, but engines are made in America and are exported."
    ]

    let messageImageURLs: [URL] = [
        URL(string: "https://mediaindia.eu/wp-content/uploads/2017/09/shinjuku.jpg")!,
        URL(string: "https://my.staging.kaodim.com/attachments/7a778d7433922e57e08d3756bd8c28c328333e15/store/fit/600/420/64fd78d9e366e876988c486d8428ef35ce4683559bb64d9b8caad00e570d/attachment.jpeg")!,
        URL(string: "https://my.staging.kaodim.com/attachments/b90e2b762ddddd46cc95dad3dafd069bb14893d5/store/fit/600/420/b0ce5d3f066ab5863063600558efe0e474deb949ec1ed17347ba992a3d84/attachment.jpeg")!
    ]

    let dan = Sender(id: "123456", displayName: "Dan Leonard")
    let steven = Sender(id: "654321", displayName: "Steven")
    let jobs = Sender(id: "000001", displayName: "Steve Jobs")
    let cook = Sender(id: "656361", displayName: "Tim Cook")

    lazy var senders = [dan, steven, jobs, cook]

    var currentSender: Sender {
        return steven
    }

    let messageImages: [UIImage] = [#imageLiteral(resourceName: "Dan-Leonard"), #imageLiteral(resourceName: "Tim-Cook"), #imageLiteral(resourceName: "Steve-Jobs")]

    var now = Date()

    let messageTypes = ["CustomPhoto", "CustomLocation", "CustomPhotoText", "CustomLocationText", "CustomFile"]

    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]

    let fileNames = ["file_1.pdf", "file2.pptx", "file_improtant_with_long_message_text.pdf"]

    let locations: [CLLocation] = [
        CLLocation(latitude: 37.3118, longitude: -122.0312),
        CLLocation(latitude: 33.6318, longitude: -100.0386),
        CLLocation(latitude: 29.3358, longitude: -108.8311),
        CLLocation(latitude: 39.3218, longitude: -127.4312),
        CLLocation(latitude: 35.3218, longitude: -127.4314),
        CLLocation(latitude: 39.3218, longitude: -113.3317)
    ]

    let emojis = [
        "👍",
        "👋",
        "👋👋👋",
        "😱😱",
        "🎈",
        "🇧🇷"
    ]

    func attributedString(with text: String) -> NSAttributedString {
        let nsString = NSString(string: text)
        var mutableAttributedString = NSMutableAttributedString(string: text)
        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
        let range = NSRange(location: 0, length: nsString.length)

        switch attributes[randomAttribute] {
        case "Font1":
            mutableAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
        case "Font2":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
        case "Font3":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Font4":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Color":
            mutableAttributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: range)
        case "Combo":
            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
            let msg9Text = NSString(string: msg9String)
            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))

            msg9AttributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
            mutableAttributedString = msg9AttributedText
        default:
            fatalError("Unrecognized attribute for mock message")
        }

        return NSAttributedString(attributedString: mutableAttributedString)
    }

    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }

    func randomMessage() -> MockMessage {

        let randomNumberSender = Int(arc4random_uniform(UInt32(senders.count)))
        let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
        let randomMessageType = Int(arc4random_uniform(UInt32(messageTypes.count)))
        let randomPhotoDesc = Int(arc4random_uniform(UInt32(messagePhotoDescriptions.count)))
        let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
        let randomFileName = Int(arc4random_uniform(UInt32(fileNames.count)))
        let randomImageURL = Int(arc4random_uniform(UInt32(messageImageURLs.count)))
        let uniqueID = NSUUID().uuidString
        let sender = senders[randomNumberSender]
        let date = dateAddingRandomTime()

        switch messageTypes[randomMessageType] {
        case "CustomPhoto":
            let imageURL = messageImageURLs[randomImageURL]
            return MockMessage(imageURL: imageURL, attributedText: nil, sender: sender, messageId: uniqueID, date: date)
        case "CustomLocation":
            let location = locations[randomNumberLocation]
            return MockMessage(location: location, attributedText: nil, sender: sender, messageId: uniqueID, date: date)
        case "CustomPhotoText":
            let imageURL = messageImageURLs[randomImageURL]
            let description = messagePhotoDescriptions[randomPhotoDesc]
            let attributedText = NSAttributedString(string: description, attributes: [
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13.0),
                NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            ])
            return MockMessage(imageURL: imageURL, attributedText: attributedText, sender: sender, messageId: uniqueID, date: date)
        case "CustomLocationText":
            let location = locations[randomNumberLocation]
            let description = messagePhotoDescriptions[randomPhotoDesc]
            let attributedText = NSAttributedString(string: description, attributes: [
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0),
                NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            ])
            return MockMessage(location: location, attributedText: attributedText, sender: sender, messageId: uniqueID, date: date)
        case "CustomFile":
            let fileName = fileNames[randomFileName]
            let icon = messageImages[randomNumberImage]
            let attributedText = NSAttributedString(string: fileName, attributes: [
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13.0),
                NSAttributedStringKey.foregroundColor: UIColor.darkGray
            ])
            return MockMessage(icon: icon, attributedText: attributedText, sender: sender, messageId: uniqueID, date: date)
        default:
            fatalError("Unrecognized mock message type")
        }
    }

    func getMessages(count: Int, completion: ([MockMessage]) -> Void) {
        var messages: [MockMessage] = []
        for _ in 0..<count {
            messages.append(randomMessage())
        }
        completion(messages)
    }

    func getAvatarFor(sender: Sender) -> Avatar {
        switch sender {
        case dan:
            return Avatar(image: #imageLiteral(resourceName: "Dan-Leonard"), initials: "DL")
        case steven:
            return Avatar(initials: "S")
        case jobs:
            return Avatar(image: #imageLiteral(resourceName: "Steve-Jobs"), initials: "SJ")
        case cook:
            return Avatar(image: #imageLiteral(resourceName: "Tim-Cook"))
        default:
            return Avatar()
        }
    }

}
