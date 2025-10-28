//
//  Constants.swift
//  nmrusanovPW2
//
//  Created by Nick on 28.10.2025.
//

import UIKit

enum Constants {
    
    // MARK: - Common
    enum Common {
        static let defaultSpace: CGFloat = 20
        static let smallSpace: CGFloat = 8
        static let mediumSpace: CGFloat = 16
        static let largeSpace: CGFloat = 24
        static let cornerRadius: CGFloat = 8
        static let cornerRadiusLarge: CGFloat = 20
        static let borderWidth: CGFloat = 1
        static let shadowOpacity: Float = 0.1
        static let shadowRadius: CGFloat = 8
        static let shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: - Colors
    enum Colors {
        static let defaultBackground = UIColor(hex: "#00A0F0")!
        static let primary = UIColor.systemBlue
        static let secondary = UIColor.systemPink
        static let background = UIColor.systemBackground
        static let textPrimary = UIColor.label
        static let textSecondary = UIColor.secondaryLabel
        static let white = UIColor.white
        static let systemGray = UIColor.systemGray
        static let systemGray2 = UIColor.systemGray2
        static let systemGray6 = UIColor.systemGray6
    }
    
    // MARK: - Font Sizes
    enum FontSizes {
        static let largeTitle: CGFloat = 32
        static let title: CGFloat = 24
        static let headline: CGFloat = 18
        static let body: CGFloat = 16
        static let caption: CGFloat = 14
        static let small: CGFloat = 12
    }
    
    // MARK: - Animation
    enum Animation {
        static let shortDuration: TimeInterval = 0.2
        static let mediumDuration: TimeInterval = 0.3
        static let longDuration: TimeInterval = 0.5
        static let springDamping: CGFloat = 0.7
        static let springVelocity: CGFloat = 0.5
    }
    
    // MARK: - WishMaker
    enum WishMaker {
        static let appName = "WishMaker"
        static let appDescription = """
This app will bring you joy and will fulfill three of your wishes

\u{2022} First  wish is to change the background color
\u{2022} Second wish is to make rainbow header
\u{2022} Third  wish is to hide slider stack by special button
"""
        static let makeRainbowHeader = true
        
        // Sliders
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let redTitle = "Red"
        static let greenTitle = "Green"
        static let blueTitle = "Blue"
        
        // Stack
        static let stackBottom: CGFloat = 40
        static let stackLeading: CGFloat = 20
        static let stackSpacing: CGFloat = 10
        static let stackPadding: CGFloat = 16
        
        // Hex Input
        static let hexTitle = "Hex Color"
        static let hexPrefix = "#"
        static let hexPlaceholder = "RRGGBB"
        
        // Buttons
        static let switchToSlidersTitle = "Sliders"
        static let switchToHexTitle = "Hex Input"
        static let switchToPickerTitle = "Color Picker"
        static let pickerButtonTitle = "Open Color Picker"
        static let wishButtonText = "My wishes"
        
        // Sizes
        static let buttonHeight: CGFloat = 44
        static let textFieldHeight: CGFloat = 40
        static let buttonBottom: CGFloat = 20
    }
    
    // MARK: - WishStoring
    enum WishStoring {
        static let title = "My Wishes"
        static let emptyStateText = "No wishes yet\nTap '+' to add your first wish!"
        static let addWishCellIdentifier = "AddWishCell"
        static let writtenWishCellIdentifier = "WrittenWishCell"
        static let newWishPlaceholder = "Enter your wish..."
        static let editWishTitle = "Edit Wish"
        static let saveActionTitle = "Save"
        static let cancelActionTitle = "Cancel"
        static let deleteActionTitle = "Delete"
        static let shareActionTitle = "Share"
        static let wishesUserDefaultsKey = "savedWishes"
        
        // Sizes
        static let addButtonHeight: CGFloat = 50
        static let tableRowHeight: CGFloat = 60
        static let addWishCellHeight: CGFloat = 80
        static let writtenWishCellHeight: CGFloat = 70
        static let alertTextFieldInset: CGFloat = 32
    }
    
    // MARK: - CustomSlider
    enum CustomSlider {
        static let titleTopInset: CGFloat = 10
        static let titleLeadingInset: CGFloat = 10
        static let valueLabelTrailingInset: CGFloat = 10
        static let sliderTopOffset: CGFloat = 5
        static let sliderBottomInset: CGFloat = 10
        static let sliderHorizontalInset: CGFloat = 20
        static let valueLabelFormat = "%.2f"
    }
    
    // MARK: - Layout
    enum Layout {
        static let priorityRequired: Float = 1000
        static let priorityHigh: Float = 750
        static let priorityMedium: Float = 500
        static let priorityLow: Float = 250
    }
    
    // MARK: - Accessibility
    enum Accessibility {
        enum WishMaker {
            static let titleLabel = "WishMaker App Title"
            static let descriptionLabel = "WishMaker App Description"
            static let addWishButton = "Add New Wish Button"
            static let switchModeButton = "Switch Color Input Mode Button"
            static let colorPickerButton = "Open Color Picker Button"
            static let redSlider = "Red Color Slider"
            static let greenSlider = "Green Color Slider"
            static let blueSlider = "Blue Color Slider"
            static let hexTextField = "Hex Color Text Field"
            static let redHexField = "Red Hex Text Field"
            static let greenHexField = "Green Hex Text Field"
            static let blueHexField = "Blue Hex Text Field"
        }
        
        enum WishStoring {
            static let tableView = "Wishes List"
            static let addButton = "Add New Wish Button"
            static let emptyStateText = "No wishes yet\nUse the field above to add your first wish!"
            static let addWishCell = "Add New Wish Cell"
            static let writtenWishCell = "Written Wish Cell"
        }
    }
    
    // MARK: - Alerts
    enum Alerts {
        static let errorTitle = "Error"
        static let deleteWishTitle = "Delete Wish"
        static let deleteWishMessage = "Are you sure you want to delete this wish?"
        static let okActionTitle = "OK"
        static let wishEmptyError = "Wish cannot be empty"
        static let invalidIndexError = "Invalid index"
    }
}
