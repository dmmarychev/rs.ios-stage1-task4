#import "FullBinaryTrees.h"
#import "TreeNode.h"

@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count {

    NSArray *nodes = [self allPossibleFBT:count];
    
    return result;
}

- (NSArray *)allPossibleFBT:(NSInteger)N {
    
    NSMutableArray *ans = [NSMutableArray new];
    
    if (N % 2 == 0) {
        return ans;
    }
    
    if (N == 1) {
        TreeNode *currentNode = [TreeNode new];
        currentNode.value = @"0";
        
        [ans addObject:currentNode];
        
        return ans;
    }
    
    for (int i = 1; i < N; i += 2) {
    
        for (TreeNode *l in [self allPossibleFBT:i]) {
            
            for (TreeNode *r in [self allPossibleFBT:N - i - 1]) {
                TreeNode *root = [TreeNode new];
                root.value = @"0";
                root.leftNode = l;
                root.rightNode = r;
                
                [ans addObject:root];
            }
        }
    }
    return ans;
}

@end
