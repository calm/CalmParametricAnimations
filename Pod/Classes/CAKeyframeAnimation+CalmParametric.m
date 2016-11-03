#import "CAKeyframeAnimation+CalmParametric.h"

#define kDefaultNumSteps 101

@implementation CAKeyframeAnimation (CalmParametric)


#pragma mark - convenience constructors

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                          fromDouble:(double)fromValue
                            toDouble:(double)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockDouble
                                                                     fromValue:@(fromValue)
                                                                       toValue:@(toValue)];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                           fromPoint:(CGPoint)fromValue
                             toPoint:(CGPoint)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockPoint
                                                                     fromValue:[NSValue valueWithCGPoint:fromValue]
                                                                       toValue:[NSValue valueWithCGPoint:toValue]];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                            fromSize:(CGSize)fromValue
                              toSize:(CGSize)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockSize
                                                                     fromValue:[NSValue valueWithCGSize:fromValue]
                                                                       toValue:[NSValue valueWithCGSize:toValue]];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                            fromRect:(CGRect)fromValue
                              toRect:(CGRect)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockRect
                                                                     fromValue:[NSValue valueWithCGRect:fromValue]
                                                                       toValue:[NSValue valueWithCGRect:toValue]];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                           fromColor:(CGColorRef)fromValue
                             toColor:(CGColorRef)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockColor
                                                                     fromValue:(__bridge id)fromValue
                                                                       toValue:(__bridge id)toValue];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                       fromTransform:(CATransform3D)fromValue
                         toTransform:(CATransform3D)toValue
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:kParametricValueBlockTransform3D
                                                                     fromValue:[NSValue valueWithCATransform3D:fromValue]
                                                                       toValue:[NSValue valueWithCATransform3D:toValue]];
    return animation;
}

#pragma mark - generic core

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                            valueFxn:(ParametricValueBlock)valueFxn
                           fromValue:(NSValue *)fromValue
                             toValue:(NSValue *)toValue;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path
                                                                       timeFxn:timeFxn
                                                                      valueFxn:valueFxn
                                                                     fromValue:fromValue
                                                                       toValue:toValue
                                                                       inSteps:kDefaultNumSteps];
    return animation;
}

+ (instancetype)animationWithKeyPath:(NSString *)path
                             timeFxn:(ParametricTimeBlock)timeFxn
                            valueFxn:(ParametricValueBlock)valueFxn
                           fromValue:(NSValue *)fromValue
                             toValue:(NSValue *)toValue
                             inSteps:(NSUInteger)numSteps
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];

    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numSteps];
    double time = 0.0;
    double timeStep = 1.0 / (double)(numSteps - 1);
    for (NSUInteger i = 0; i < numSteps; i++) {
        NSValue *value = valueFxn(timeFxn(time), fromValue, toValue);
        [values addObject:value];
        time += timeStep;
    }

    animation.calculationMode = kCAAnimationLinear;
    [animation setValues:values];
    return (animation);
}

+ (instancetype)animationWithAnimations:(NSArray *)animations
{
    CGFloat duration = 0;
    NSArray *values = @[];
    CAKeyframeAnimation *canonicalAnimation = animations[0];

    for (CAKeyframeAnimation *animation in animations) {
        duration += animation.duration;
        values = [values arrayByAddingObjectsFromArray:animation.values];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:canonicalAnimation.keyPath];
    animation.calculationMode = canonicalAnimation.calculationMode;
    animation.duration = duration;
    animation.values = values;
    
    return animation;
}

@end
