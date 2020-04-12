#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    
    if ([number integerValue] < 0) {
        return nil;
    }
    
    NSDictionary *neighborsNumbers = [NSDictionary dictionaryWithObjectsAndKeys: @"24", @"1",  @"135", @"2",
                                                                                 @"26", @"3",  @"157", @"4",
                                                                               @"2468", @"5",  @"359", @"6",
                                                                                 @"48", @"7", @"5790", @"8",
                                                                                 @"68", @"9",    @"8", @"0", nil];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger currentIndex = 0; currentIndex < [number length]; currentIndex++) {
        
        NSRange rangeForCurrentNumber = NSMakeRange(currentIndex, 1);
        NSString *currentNumberString = [number substringWithRange:rangeForCurrentNumber];
        NSString *replacementString = [neighborsNumbers valueForKey:currentNumberString];
        
        for (NSInteger currentReplaceIndex = 0; currentReplaceIndex < [replacementString length]; currentReplaceIndex++) {
            
            NSRange rangeForCurrentReplacementNumber = NSMakeRange(currentReplaceIndex, 1);
            NSString *currentReplacementString = [replacementString substringWithRange:rangeForCurrentReplacementNumber];
            
            NSString *resultString = [number stringByReplacingCharactersInRange:rangeForCurrentNumber
                                                                     withString:currentReplacementString];
            
            [result addObject:resultString];
        }
    }
    
    return result;
}

@end
