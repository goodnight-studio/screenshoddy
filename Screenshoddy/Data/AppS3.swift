//
//  AppS3.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 11/11/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa
import S3

class AppS3 {
    
    typealias ImageUploadCompletion = ((_ imageUrl: URL?) -> Void)
    typealias ImageUploadErrorHandler = ((_ error: Error) -> Void)
    
    enum S3Error: Error {
        case invalidBucket
        case invalidImage
    }
    
    static var shared = AppS3()
    
    var s3 = S3(
        accessKeyId: AppDefaults.s3AccessId,
        secretAccessKey: AppKeychain.s3SecretKey,
        region: Region(rawValue: AppDefaults.s3Region ?? "us-west-1")
    )
    
    func createKeyName() -> String {
        let date = Date()
        let df = DateFormatter()
        df.calendar = .current
        df.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return "\(df.string(from: date)).png"
    }
    
    func handleCredentialChange() {
        self.s3 = S3(
            accessKeyId: AppDefaults.s3AccessId,
            secretAccessKey: AppKeychain.s3SecretKey,
            region: Region(rawValue: AppDefaults.s3Region ?? "us-west-1")
        )
    }
    
    func getRegions() -> [String] {
        return Region.allCases.compactMap { region -> String in
            region.rawValue
        }
    }
    
    func getURL(withKeyName keyName: String) -> URL? {
        
        guard let bucket = AppDefaults.s3Bucket else { return nil }
        guard let region = AppDefaults.s3Region else { return nil }
        let str = "https://\(bucket).s3.\(region).amazonaws.com/\(keyName)"
        
        return URL(string: str)
    }
    
    func upload(image: NSImage, completion: @escaping ImageUploadCompletion, apiErrorHandler: @escaping ImageUploadErrorHandler) throws {
        
        guard let bucket = AppDefaults.s3Bucket else { throw S3Error.invalidBucket }
        guard let imageData = image.png else { throw S3Error.invalidImage}
        
        let keyName = createKeyName()
        
        let objectRequest = S3.PutObjectRequest(
            acl: .publicRead,
            body: imageData,
            bucket: bucket,
            cacheControl: nil,
            contentDisposition: nil,
            contentEncoding: nil,
            contentLanguage: nil,
            contentLength: nil,
            contentMD5: nil,
            contentType: "image/png",
            expires: nil,
            grantFullControl: nil,
            grantRead: nil,
            grantReadACP: nil,
            grantWriteACP: nil,
            key: keyName,
            metadata: nil,
            objectLockLegalHoldStatus: .none,
            objectLockMode: .none,
            objectLockRetainUntilDate: nil,
            requestPayer: .none,
            serverSideEncryption: .none,
            sSECustomerAlgorithm: nil,
            sSECustomerKey: nil,
            sSECustomerKeyMD5: nil,
            sSEKMSEncryptionContext: nil,
            sSEKMSKeyId: nil,
            storageClass: .standard,
            tagging: nil,
            websiteRedirectLocation: nil
        )
        
        let put = s3.putObject(objectRequest)
        
        put.whenSuccess { output in
            print(output)
            
            completion(self.getURL(withKeyName: keyName))
        }
        
        put.whenFailure { error in
            print(error.localizedDescription)
            
            apiErrorHandler(error)
        }
    }
    
    private init() {}
}

public extension Region {
    
    static var allCases: [Region] {
        return [
            .useast1,
            .useast2,
            .uswest1,
            .uswest2,
            .apsouth1,
            .apnortheast2,
            .apsoutheast1,
            .apsoutheast2,
            .apnortheast1,
            .apeast1,
            .cacentral1,
            .euwest1,
            .euwest3,
            .euwest2,
            .eucentral1,
            .eunorth1,
            .eusouth1,
            .saeast1,
            .mesouth1,
            .afsouth1
        ]
    }
}
