//
//  TreeNode.h
//  RSSchool_T4
//
//  Created by Dmitry Marchenko on 4/12/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property (assign, nonatomic) NSInteger value;
@property (strong, nonatomic) TreeNode *leftNode;
@property (strong, nonatomic) TreeNode *rightNode;

@end

NS_ASSUME_NONNULL_END
