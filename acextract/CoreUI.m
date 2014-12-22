//
//  CoreUI.m
//  acextract
//
//  Created by Bartosz Janda on 21.12.2014.
//  Copyright (c) 2014 Bartosz Janda. All rights reserved.
//

#import <Foundation/Foundation.h>

NSData *GetRenditionSrcData(id rendition)
{
    intptr_t renditionAddress = (intptr_t)objc_unretainedPointer(rendition);
    intptr_t dataPointerAddress = renditionAddress + 0x88;
    intptr_t dataAddress = *((intptr_t *)dataPointerAddress);
    NSData *data = (__bridge NSData *)((void *)dataAddress);
    
    return data;
}