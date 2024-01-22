//
//  ViewController.swift
//  Test App
//
//  Created by Aijaz Ali on 22/01/2024.
//

import UIKit
import QuickLook
import PDFKit

class ViewController: UIViewController, QLPreviewControllerDataSource, QLPreviewControllerDelegate {

    var previewController: QLPreviewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a QLPreviewController
        previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self

        // Add the previewController as a child view controller
        addChild(previewController)
        previewController.view.frame = view.bounds
        view.addSubview(previewController.view)
        previewController.didMove(toParent: self)
    }

    // MARK: - QLPreviewControllerDataSource

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 3 // Number of files you want to display
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // Replace these file URLs with the URLs of your PDF, Word, and PowerPoint files
        let fileURLs = [
            Bundle.main.url(forResource: "AijazCV", withExtension: "pdf")!,
            Bundle.main.url(forResource: "AijazD", withExtension: "docx")!,
            Bundle.main.url(forResource: "Abstract", withExtension: "pptx")!
        ]

        return fileURLs[index] as QLPreviewItem
    }

    // MARK: - QLPreviewControllerDelegate (optional)

    func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        // You can add custom handling here if needed
        return true
    }
}

