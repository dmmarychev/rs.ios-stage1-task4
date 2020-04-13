#import "ArrayCalculator.h"

typedef enum {
    NumberSignPositive,
    NumberSignNegative
} NumberSign;

@implementation ArrayCalculator

+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    NSArray *clearArray = [self arrayByRemovingNonIntegerValues:array];
    
    switch ([clearArray count]) {
        
        case 0: return 0;
        case 1: return [[clearArray firstObject] integerValue];
        default:
            
            if (numberOfItems >= [clearArray count]) {
                
                NSInteger result = [[clearArray firstObject] integerValue];
                
                for (int i = 1; i < [clearArray count]; i++) {
                    
                    result *= [[clearArray objectAtIndex:i] integerValue];
                }
                
                return result;
                
            } else {
                
                NSInteger availableProductsCount = numberOfItems;
                NSInteger result = 1;
                
                while (availableProductsCount > 0) {
                    
                    if (availableProductsCount > 1) {
                        
                        NSInteger maxPositiveProduct = [self maxProductOfItemsFromArray:clearArray withNumberSign:NumberSignPositive];
                        NSInteger maxNegativeProduct = [self maxProductOfItemsFromArray:clearArray withNumberSign:NumberSignNegative];
                        
                        result *= (maxPositiveProduct >= maxNegativeProduct) ? maxPositiveProduct : maxNegativeProduct;
                        
                        for (int i = 0; i < 2; i++) {
                            clearArray = [self array:clearArray byRemovingMaxValueWithNumberSign:
                                                                maxPositiveProduct >= maxNegativeProduct ?
                                                                NumberSignPositive : NumberSignNegative];
                        }
                        availableProductsCount -= 2;
                        
                    } else {
                        result *= [[clearArray valueForKeyPath:@"@max.intValue"] integerValue];
                        availableProductsCount--;
                    }
                }
                return result;
            }
    }
}


+ (NSInteger)maxProductOfItemsFromArray:(NSArray *)array withNumberSign:(NumberSign)sign {
    
    NSInteger firstMaxValue = 0;
    NSInteger secondMaxValue = 0;
    
    for (NSNumber *currentNumber in array) {
        
        NSInteger currentIntegerValue = [currentNumber integerValue];
        
        if (sign == NumberSignPositive ? currentIntegerValue >= firstMaxValue && currentIntegerValue > 0 :
                                         currentIntegerValue <= firstMaxValue && currentIntegerValue < 0) {
            
            secondMaxValue = firstMaxValue;
            firstMaxValue = currentIntegerValue;
            
        } else if (sign == NumberSignPositive ? currentIntegerValue > secondMaxValue && currentIntegerValue > 0 :
                                                currentIntegerValue < secondMaxValue && currentIntegerValue < 0){
            
            secondMaxValue = currentIntegerValue;
        }
    }
    
    return firstMaxValue * secondMaxValue;
}


+ (NSArray *)array:(NSArray *)array byRemovingMaxValueWithNumberSign:(NumberSign)sign {
    
    NSMutableArray *result = [NSMutableArray arrayWithArray:array];
    
    [result removeObject:[result valueForKeyPath: sign == NumberSignPositive ? @"@max.intValue" : @"@min.intValue"]];
    
    return result;
}


+ (NSArray *)arrayByRemovingNonIntegerValues:(NSArray *)array {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (id currentObject in array) {
        [currentObject isKindOfClass:[NSNumber class]] ? [resultArray addObject:currentObject] : 0;
    }
    
    return resultArray;
}

@end
