//
//  PinnedSessionDelegate.swift
//  RickMortyApi

import Foundation

final class PinnedSessionDelegate: NSObject, URLSessionDelegate {
    private let pinnedCertData: Data

    override init() {
        guard let certPath = Bundle.main.path(forResource: "rickmorty", ofType: "cer"),
              let certData = try? Data(contentsOf: URL(fileURLWithPath: certPath)) else {
            fatalError("No se pudo cargar el certificado .cer desde el bundle.")
        }
        self.pinnedCertData = certData
    }

    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        let certCount = SecTrustGetCertificateCount(serverTrust)

        for index in 0..<certCount {
            if let certificate = SecTrustGetCertificateAtIndex(serverTrust, index) {
                let serverCertData = SecCertificateCopyData(certificate) as Data
                if serverCertData == pinnedCertData {
                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                    return
                }
            }
        }

        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}



