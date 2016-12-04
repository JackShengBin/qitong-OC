//
//  AdsModel.h
//  企同创意-OC
//
//  Created by 梦想 on 16/9/6.
//  Copyright © 2016年 小彬Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsModel : NSObject

/**
 *  cell的text
 */
@property (nonatomic, copy) NSString *name;

/**
 *  图片前缀
 */
@property (nonatomic, copy) NSString *image;
/**
 *  图片数
 */
@property (nonatomic, assign) int count;

@end
