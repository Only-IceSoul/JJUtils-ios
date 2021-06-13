/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "sk_path.h"
@interface SVGPathParser : NSObject

- (instancetype) initWithPathString:(NSString *)d;
- (sk_path_t *)getPath;

@end
