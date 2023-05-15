//
//  TweetComposeViewController.swift
//  TwitterClone
//
//  Created by Lucas Newlands on 15/05/23.
//

import UIKit
import Combine

class TweetComposeViewController: UIViewController {

    private var viewModel = TweetComposeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    private let tweetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "twitterBackgroundColor")
        button.setTitle("Tweet", for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.7), for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let tweetContentTextView: UITextView = {
        let textView = UITextView()
        let size: CGFloat = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: size, left: size, bottom: size, right: size)
        textView.text = "What's happening?"
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        tweetContentTextView.delegate = self
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
        configureConstraints()
        bindViews()
        tweetButton.addTarget(self, action: #selector(didTapToTweet), for: .touchUpInside)
    }
    
    @objc private func didTapToTweet() {
        viewModel.dispatchTweet()
    }
    
    private func bindViews() {
        viewModel.$isValidToTweet.sink{ [weak self] state in
            self?.tweetButton.isEnabled = state
        }.store(in: &subscriptions)
        
        viewModel.$shouldDismissComposer.sink { [weak self ]success in
            if success {
                self?.dismiss(animated: true)
            }
        }
        .store(in: &subscriptions)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    
    
    private func configureConstraints() {
        let tweetButtonConstraints = [
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let tweetContentTextViewConstraints = [
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(tweetButtonConstraints)
        NSLayoutConstraint.activate(tweetContentTextViewConstraints)

    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
}

extension TweetComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateTweet()
    }
}
