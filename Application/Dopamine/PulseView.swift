import SwiftUI
import UIKit

struct PulseView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return RootViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
