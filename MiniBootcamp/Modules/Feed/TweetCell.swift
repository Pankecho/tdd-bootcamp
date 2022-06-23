//
//  TweetCell.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 14/06/22.
//

import UIKit

class TweetCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userImageView: UIImageView = create {
        $0.image = UIImage(.gato)
        $0.layer.cornerRadius = 25
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let nameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .name)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let usernameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .username)
        $0.textColor = UIColor.systemGray
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .content)
        $0.textColor = UIColor.label
        $0.numberOfLines = 0
    }

    let commentButton: UIButton = create {
        $0.setImage(UIImage(.comment), for: .normal)
        $0.clipsToBounds = true
        $0.tintColor = UIColor.redMain
    }

    let retweetButton: UIButton = create {
        $0.setImage(UIImage(.ret), for: .normal)
        $0.clipsToBounds = true
        $0.tintColor = UIColor.redMain
    }

    let favButton: UIButton = create {
        $0.setImage(UIImage(.fav), for: .normal)
        $0.clipsToBounds = true
        $0.tintColor = UIColor.redMain
    }

    let shareButton: UIButton = create {
        $0.setImage(UIImage(.share), for: .normal)
        $0.clipsToBounds = true
        $0.tintColor = UIColor.redMain
    }

    let buttonStackView: UIStackView = create {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(userImageView)
        addSubview(contentLabel)
        addSubview(buttonStackView)

        buttonStackView.addArrangedSubview(commentButton)
        buttonStackView.addArrangedSubview(retweetButton)
        buttonStackView.addArrangedSubview(favButton)
        buttonStackView.addArrangedSubview(shareButton)
    }

    public func configure(name: String, username: String, text: String) {
        nameLabel.text = name
        usernameLabel.text = username
        contentLabel.text = text
    }

    private func layout() {
        userImageView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             trailing: nil,
                             bottom: nil,
                             padding: .init(top: 12, left: 12, bottom: 12, right: 12),
                             size: .init(width: 50, height: 50))

        nameLabel.anchor(top: topAnchor,
                         leading: userImageView.trailingAnchor,
                         trailing: trailingAnchor,
                         bottom: nil,
                         padding: .init(top: 12, left: 12, bottom: 0, right: 12))

        usernameLabel.anchor(top: nameLabel.bottomAnchor,
                             leading: userImageView.trailingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil,
                             padding: .init(top: 8, left: 12, bottom: 0, right: 12))

        contentLabel.anchor(top: usernameLabel.bottomAnchor,
                             leading: userImageView.trailingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil,
                             padding: .init(top: 8, left: 12, bottom: 0, right: 12))

        buttonStackView.anchor(top: contentLabel.bottomAnchor,
                             leading: userImageView.trailingAnchor,
                             trailing: trailingAnchor,
                             bottom: bottomAnchor,
                             padding: .init(top: 8, left: 12, bottom: 12, right: 12))
    }
}
