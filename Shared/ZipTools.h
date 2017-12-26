//
//  ZipTools.h
//  Platypus
//
//  Created by Sveinbjorn Thordarson on 26/12/2017.
//  Copyright © 2017 Sveinbjorn Thordarson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipTools : NSObject

+ (BOOL)isZipFile:(NSString *)path;
+ (BOOL)isZipFileData:(NSData *)data;
+ (BOOL)extractFile:(NSString *)name fromZipFile:(NSString *)zipFilePath toPath:(NSString *)destinationPath;
    
@end


