//
//  PinningURLSessionDelegate.swift
//  RickMortyApi

import Foundation
import Security

final class PinningURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust,
              let localCertPath = Bundle.main.path(forResource: "rickandmorty", ofType: "cer"),
              let localCertData = try? Data(contentsOf: URL(fileURLWithPath: localCertPath)),
              let certificateChain = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
              let serverCert = certificateChain.first
        else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        let serverCertData = SecCertificateCopyData(serverCert) as Data

        if serverCertData == localCertData {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            print("SSL Pinning fallido: Certificados no coinciden")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

