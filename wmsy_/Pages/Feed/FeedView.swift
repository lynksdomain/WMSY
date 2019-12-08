//
//  FeedView.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


class FeedView: UIView {
    
    lazy var header: WmsyHeader = {
        let h = WmsyHeader()
        h.backgroundColor = .purple
        h.delegate = self
        return h
    }()
    
    
    
    lazy var feedTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    
    lazy var filterBar: FilterBar = {
        let fb = FilterBar()
        return fb
    }()
    
    var filterOpened = false {
        didSet{
            UIView.animate(withDuration: 0.5) {
                self.filterBarHeightConstraint?.constant = self.filterOpened ? 33 : 0
                self.layoutIfNeeded()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubviews()
        constrainHeader()
        constrainFeed()
        constrainFilterBar()
    }
    
    func addSubviews() {
        addSubview(header)
        addSubview(feedTableView)
        addSubview(filterBar)
    }
    
    func constrainHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        header.topAnchor.constraint(equalTo: topAnchor),
        header.leadingAnchor.constraint(equalTo: leadingAnchor),
        header.trailingAnchor.constraint(equalTo: trailingAnchor),
        header.heightAnchor.constraint(equalToConstant: 77)
        ])
    }
    
    func constrainFeed() {
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: filterBar.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    var filterBarHeightConstraint: NSLayoutConstraint?
    
    
    func constrainFilterBar() {
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        filterBarHeightConstraint = filterBar.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
                   filterBar.topAnchor.constraint(equalTo: header.bottomAnchor),
                   filterBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                   filterBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                   filterBarHeightConstraint!
               ])
    }
    
}


extension FeedView: wmsyHeaderDelegate {
    func filterSelected() {
        filterOpened.toggle()
    }
}




