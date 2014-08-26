//
//  SVGGradientLayer.h
//  SVGKit-iOS
//
//  Created by zhen ling tsai on 19/7/13.
//  Copyright (c) 2013 na. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SVGTransformable.h"

static NSString * const kExt_CAGradientLayerRadial = @"radialGradient";

@interface SVGGradientLayer : CAGradientLayer <SVGTransformable>

@property (nonatomic, readwrite) CGPathRef maskPath;
@property (nonatomic, readwrite, retain) NSArray *stopIdentifiers;

- (void)setStopColor:(UIColor *)color forIdentifier:(NSString *)identifier;

@end
