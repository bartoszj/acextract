//
//  CoreUI.h
//  acextract
//
//  Created by Bartosz Janda on 14.12.2014.
//  Copyright (c) 2014 Bartosz Janda. All rights reserved.
//

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

@end
