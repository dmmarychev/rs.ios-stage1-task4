#import "SquareDecomposer.h"

@implementation SquareDecomposer

- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
  
    NSInteger sourceValue = [number intValue];
    NSArray *result = nil;
            
    for (NSInteger currentValue = sourceValue - 1; currentValue > 1; currentValue--) {
        
        long square = pow(sourceValue, 2);
        result = [self decomposeValue:currentValue withSquareOfSourceValue:square];
        
        if (result != nil) {
            break;
        }
    }
    
    return result;
}


- (NSArray *)decomposeValue:(NSInteger)value withSquareOfSourceValue:(NSInteger)square {
    
    NSInteger squareValue = pow(value, 2);
    
    if (squareValue == square) {
        
        NSNumber *valueNumber = [NSNumber numberWithInteger:value];
        return @[valueNumber];
    
    } else if (squareValue < square) {
        
        square -= squareValue;
        
        for (long j = value - 1; j > 0; j--) {
            
            NSArray *tempValues = [self decomposeValue:j withSquareOfSourceValue:square];
                
            if (tempValues != NULL) {
                
                NSMutableArray *result = [NSMutableArray arrayWithArray:tempValues];
                [result addObject:[NSNumber numberWithInteger:value]];
                
                return result;
                
            } else {
                continue;
            }
        }
    }
        
    return nil;
}

@end
