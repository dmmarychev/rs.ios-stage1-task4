#import "FullBinaryTrees.h"
#import "TreeNode.h"

@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count {

    NSArray *trees = [self createAllBinaryTreesForCount:count];
    NSString *result = [self createResultStringFromNodes:trees count:count];
    
    return result;
}


- (NSArray *)createAllBinaryTreesForCount:(NSInteger)count {
    
    NSMutableArray *binaryTrees = [NSMutableArray array];
    
    if (count % 2 == 0) {
        return binaryTrees;
    }
    
    if (count == 1) {
        TreeNode *currentNode = [[TreeNode alloc] init];
        [binaryTrees addObject:currentNode];
        
        return binaryTrees;
    }
    
    for (int i = 1; i < count; i += 2) {
    
        for (TreeNode *currentLeftNode in [self createAllBinaryTreesForCount:i]) {
            
            for (TreeNode *currentRightNode in [self createAllBinaryTreesForCount:count - i - 1]) {
                
                TreeNode *currentRootNode = [TreeNode new];
                currentRootNode.leftNode = currentLeftNode;
                currentRootNode.rightNode = currentRightNode;
                
                [binaryTrees addObject:currentRootNode];
            }
        }
    }
    
    return binaryTrees;
}


- (NSString *)createResultStringFromNodes:(NSArray *)nodes count:(NSInteger)count {
    
    NSMutableString *result = [NSMutableString stringWithString:@"["];
    
    for (TreeNode *currentNode in nodes) {
        
        NSMutableString *currentNodeString = [NSMutableString stringWithString:@"["];
        
        [currentNodeString appendString:[self createResultStringFromNode:currentNode count:count]];
        [currentNodeString appendString:[currentNode isEqual:[nodes lastObject]] ? @"]" : @"],"];
        
        [result appendString:currentNodeString];
    }
    
    [result appendString:@"]"];
    
    return result;
}


- (NSString *)createResultStringFromNode:(TreeNode *)treeNode count:(NSInteger)count {
    
    NSMutableString *result = [NSMutableString stringWithString:@"0,"];
    NSMutableArray *nodes = [NSMutableArray arrayWithObject:treeNode];
    
    NSInteger currentNodesCount = 0;
    NSInteger subNodesCount = 1; //defaulf 1 (only root node)
    
    while (currentNodesCount < count) {

        currentNodesCount++;

        TreeNode *currentNode = [nodes firstObject];
        [nodes removeObjectAtIndex:0];
        
        if (currentNode.leftNode && currentNode.rightNode) {
            
            [result appendString:@"0,0,"];
            [nodes addObject:currentNode.leftNode];
            [nodes addObject:currentNode.rightNode];
            
            subNodesCount += 2;
            
        } else {
            subNodesCount < count ? [result appendString:@"null,null,"] : 0;
        }
    }
    
    [result deleteCharactersInRange:NSMakeRange([result length] - 1, 1)]; //removing "," character after last node value
    
    return result;
}

@end
