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

@import Foundation;

typedef NS_ENUM(NSInteger, CUIDeviceIdiom) {
    CUIDeviceIdiomUniversal  = 0,
    CUIDeviceIdiomIPhone     = 1,
    CUIDeviceIdiomIPad       = 2,
    CUIDeviceIdiomAppleTV    = 3,
    CUIDeviceIdiomAppleWatch = 5,
};

typedef NS_ENUM(NSUInteger, CUISubtype) {
    CUISubtypeNormal       = 0,
    CUISubtypeAppleWatch38 = 320,
    CUISubtypeAppleWatch42 = 384,
    CUISubtypeIPhone4Inch  = 568,
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

@class CUIRenditionKey, CUIThemeRendition, CUIRenditionSliceInformation;

@interface CUINamedLookup : NSObject

@property(copy, nonatomic, nonnull) NSString *name;
@property(readonly, nonatomic) BOOL representsOnDemandContent;
- (nonnull CUIRenditionKey *)renditionKey;
- (nonnull NSString *)renditionName;
- (nonnull CUIThemeRendition *)_rendition;

@end

@interface CUINamedImage : CUINamedLookup
// Device idiom:
// - idiom()
// - subtype()
// - scale
//
// Size class:
// - sizeClassVertical()
// - sizeClassHorizontal()
//
// Alignment:
// - hasAlignmentInformation
// - alignmentEdgeInsets
//
// Slices:
// - hasSliceInformation
// - resizingMode
// - imageType
// - _rendition().type()
// - _rendition().sliceInformation()?.renditionType
// - _rendition().sliceInformation()?.edgeInsets
//
// Template:
// - isTemplate
// - templateRenderingMode

@property(readonly, nonatomic) int exifOrientation;
@property(readonly, nonatomic) CUIRenderMode templateRenderingMode;
@property(readonly, nonatomic) BOOL isTemplate;
@property(readonly, nonatomic) BOOL isVectorBased;
@property(readonly, nonatomic) BOOL hasAlignmentInformation;
@property(readonly, nonatomic) BOOL hasSliceInformation;
@property(readonly, nonatomic) CUIResizingMode resizingMode;
@property(readonly, nonatomic) int blendMode;
@property(readonly, nonatomic) double opacity;
@property(readonly, nonatomic) NSEdgeInsets alignmentEdgeInsets;
@property(readonly, nonatomic) NSEdgeInsets edgeInsets;
@property(readonly, nonatomic) CUIImageType imageType;
@property(readonly, nonatomic) double scale;
@property(readonly, nonatomic) struct CGSize size;
@property(readonly, nonatomic, nonnull) struct CGImage *image;
- (CUIUserInterfaceSizeClass)sizeClassVertical;
- (CUIUserInterfaceSizeClass)sizeClassHorizontal;
- (CUISubtype)subtype;
- (CUIDeviceIdiom)idiom;

- (nonnull CUIRenditionKey *)baseKey;
- (long long)graphicsClass;
- (long long)memoryClass;


@end

@interface CUIRenditionKey : NSObject <NSCopying, NSCoding>

- (long long)themeGraphicsClass;
- (long long)themeMemoryClass;

@end

@interface CUIThemeRendition : NSObject

- (nonnull NSString *)name;
- (CUIImageType)type;
- (unsigned int)subtype;
- (nullable NSString *)utiType;
- (nullable NSData *)data;
- (nullable CGPDFDocumentRef)pdfDocument;
- (nullable CUIRenditionSliceInformation *)sliceInformation;
- (nullable CGImageRef)unslicedImage;

@end

@interface CUIRenditionSliceInformation : NSObject <NSCopying>

@property(readonly, nonatomic) NSEdgeInsets edgeInsets;
@property(readonly, nonatomic) struct CGRect destinationRect;
@property(readonly, nonatomic) CUIImageType renditionType;
- (struct CGSize)_bottomRightCapSize;
- (struct CGSize)_topLeftCapSize;
- (nonnull NSString *)description;

@end

@interface CUICatalog : NSObject

- (nullable instancetype)initWithURL:(nonnull NSURL *)url error:(NSError *_Nullable __autoreleasing *_Nullable)error;
- (nonnull NSArray<NSString *> *)allImageNames;
- (nonnull NSArray<CUINamedImage *> *)imagesWithName:(nonnull NSString *)name;

@end
