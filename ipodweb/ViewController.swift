import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create WebView configuration
        let config = WKWebViewConfiguration()

        // iOS 14+ uses WKWebpagePreferences for JavaScript; iOS 12/13 uses the old API.
        if #available(iOS 14.0, *) {
            let pagePrefs = WKWebpagePreferences()
            pagePrefs.allowsContentJavaScript = true
            config.defaultWebpagePreferences = pagePrefs
        } else {
            config.preferences.javaScriptEnabled = true
        }

        // Initialize WebView
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        // Fullscreen constraints
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Loading spinner — .large/.whiteLarge is iOS 13+; use .gray on iOS 12.
        if #available(iOS 13.0, *) {
            spinner = UIActivityIndicatorView(style: .large)
            spinner.color = .gray
        } else {
            spinner = UIActivityIndicatorView(style: .gray)
        }
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        spinner.startAnimating()

        // Load the iPod web app
        let url = URL(string: "https://www.tannerv.com/ipod")!
        webView.load(URLRequest(url: url))
    }

    // Stop spinner when page loads
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }

    // Handle load failure
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
        print("Load failed:", error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
        print("Provisional load failed:", error.localizedDescription)
    }
}
