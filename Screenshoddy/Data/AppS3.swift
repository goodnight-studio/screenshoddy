//
//  AppS3.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 11/11/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Foundation
import S3

class AppS3 {
    
    enum S3Error: Error {
        case invalidBucket
        case invalidImage
    }
    
    static var shared = AppS3()
    
    var s3 = S3(
        accessKeyId: AppDefaults.s3AccessId,
        secretAccessKey: AppKeychain.s3SecretKey
    )
    
    func handleCredentialChange() {
        self.s3 = S3(
            accessKeyId: AppDefaults.s3AccessId,
            secretAccessKey: AppKeychain.s3SecretKey
        )
    }
    
    private init() {}
}
