//
//  CoreUI.h
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Bartosz Janda
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <Foundation/Foundation.h>

typedef struct CUIImageInsets {
    CGFloat bottom;
    CGFloat left;
    CGFloat top;
    CGFloat right;
} CUIImageInsets;

typedef NS_ENUM(NSInteger, CUIDeviceIdiom) {
    CUIDeviceIdiomUniversal = 0,
    CUIDeviceIdiomiPhone    = 1,
    CUIDeviceIdiomiPad      = 2,
};

typedef NS_ENUM(NSUInteger, CUISubtype) {
    CUISubtypeUndetermined  = 0,
    CUISubtypeiPhone4Inch   = 568,
};

typedef NS_ENUM(NSInteger, CUIUserInterfaceSizeClass) {
    CUIUserInterfaceSizeClassAny      = 0,
    CUIUserInterfaceSizeClassCompact  = 1,
    CUIUserInterfaceSizeClassRegular  = 2,
};

typedef NS_ENUM(NSInteger, CUIRenderMode) {
    CUIRenderModeOriginal = 0,
    CUIRenderModeTemplate = 1,
    CUIRenderModeDefault  = 2,
};

typedef NS_ENUM(NSInteger, CUIResizingMode) {
    CUIResizingModeTiles     = 0,
    CUIResizingModeStretches = 1,
};

typedef NS_ENUM(NSInteger, CUIImageType) {
    CUIImageTypeNone                  = 0,
    CUIImageTypeHorizontal            = 1,
    CUIImageTypeVertical              = 2,
    CUIImageTypeHorizontalAndVertical = 3,
};

@interface CUICatalog : NSObject

- (instancetype)initWithURL:(NSURL *)url error:(NSError * __autoreleasing *)error;
- (NSArray *)allImageNames;
- (NSArray *)imagesWithName:(NSString *)name;

@end

@class CUIRenditionKey, CUIThemeRendition;

@interface CUINamedImage : NSObject

@property(copy, nonatomic) NSString *name;
@property(readonly, nonatomic) int exifOrientation;
@property(readonly, nonatomic) CUIRenderMode templateRenderingMode;
@property(readonly, nonatomic) BOOL isTemplate;
@property(readonly, nonatomic) BOOL isVectorBased;
@property(readonly, nonatomic) BOOL hasSliceInformation;
@property(readonly, nonatomic) CUIResizingMode resizingMode;
@property(readonly, nonatomic) int blendMode;
@property(readonly, nonatomic) double opacity;
@property(readonly, nonatomic) CUIImageInsets alignmentEdgeInsets;
@property(readonly, nonatomic) CUIImageInsets edgeInsets;
@property(readonly, nonatomic) CUIImageType imageType;
@property(readonly, nonatomic) double scale;
@property(readonly, nonatomic) struct CGSize size;
@property(readonly, nonatomic) struct CGImage *image;
- (struct CGRect)alignmentRect;
- (CUIUserInterfaceSizeClass)sizeClassVertical;
- (CUIUserInterfaceSizeClass)sizeClassHorizontal;
- (CUISubtype)subtype;
- (CUIDeviceIdiom)idiom;

- (CUIRenditionKey *)baseKey;
- (long long)graphicsClass;
- (long long)memoryClass;
- (CUIThemeRendition *)_rendition;
- (CUIRenditionKey *)renditionKey;

@end

@interface CUIRenditionKey : NSObject <NSCopying, NSCoding>

- (long long)themeGraphicsClass;
- (long long)themeMemoryClass;

@end

@interface CUIThemeRendition : NSObject

- (unsigned int)subtype;
- (NSData *)data;
- (CGPDFDocumentRef)pdfDocument;
- (CGImageRef)unslicedImage;
- (NSString *)utiType;
- (NSString *)name;
- (NSInteger)type;

@end

// Helper functions.
NSData *GetRenditionSrcData(id rendition);
