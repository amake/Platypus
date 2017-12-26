//
//  ZipTools.m
//  Platypus
//
//  Created by Sveinbjorn Thordarson on 26/12/2017.
//  Copyright © 2017 Sveinbjorn Thordarson. All rights reserved.
//

#import "ZipTools.h"

@implementation ZipTools

+ (BOOL)isZipFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfMappedFile:path];
    if (!data) {
        return NO;
    }
    return [ZipTools isZipFileData:data];
}
    
+ (BOOL)isZipFileData:(NSData *)data {
    if ([data length] < 4) {
        return NO;
    }
    
    NSData *headerMagicData = [data subdataWithRange:NSMakeRange(0, 4)];
    static char magic[] = { 0x50, 0x4B, 0x03, 0x04 }; // ZIP magic header
    NSData *zipHeaderMagicData = [NSData dataWithBytes:&magic length:4];
    
    return [headerMagicData isEqualToData:zipHeaderMagicData];
}
    
+ (BOOL)extractFile:(NSString *)name fromZipFile:(NSString *)zipFilePath toPath:(NSString *)destinationPath {
    // create task
    NSTask *zipTask = [[NSTask alloc] init];
    [zipTask setLaunchPath:@"/usr/bin/unzip"];
    [zipTask setArguments:@[@"-p", zipFilePath, name]];
    
    // capture output
    [[NSFileManager defaultManager] createFileAtPath:destinationPath contents:nil attributes:nil];
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:destinationPath];
    [zipTask setStandardOutput:fh];
    [zipTask setStandardError:[NSFileHandle fileHandleWithNullDevice]];
    
    // launch
    [zipTask launch];
    [zipTask waitUntilExit];
    int status = [zipTask terminationStatus];
    [fh closeFile];

    return (status == 0);
}

@end

