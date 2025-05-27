//
//  PinnedSessionDelegate.swift
//  RickMortyApi

import Foundation

final class PinnedSessionDelegate: NSObject, URLSessionDelegate {
    private let pinnedCertData: Data

    override init() {
        // Cargar el certificado desde el bundle
        guard let certPath = Bundle.main.path(forResource: "rickmorty", ofType: "cer"),
              let certData = try? Data(contentsOf: URL(fileURLWithPath: certPath)) else {
            fatalError("No se pudo cargar el certificado")
        }
        self.pinnedCertData = certData
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let serverCert = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        let serverCertData = SecCertificateCopyData(serverCert) as Data

        // Comparar los certificados
        if serverCertData == pinnedCertData {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
