//
//  settingsCollectionCell.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class SettingsCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    // MARK: - Properties
    
    // MARK: - Initializers methods
    
    // MARK: - Lifecycle methods
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        
    }

    
    // MARK: - Private methods
    
    // MARK: - Public methods
    
    // MARK: - Getter & setter methods
    
    // MARK: - IBActions
    
    // MARK: - Target-Action methods
    
    // MARK: - Notification handler methods
    
    // MARK: - Datasource methods
    
    // MARK: - Delegate methods
}
