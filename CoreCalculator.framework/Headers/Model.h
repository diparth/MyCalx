//
//  Model.h
//  CoreCalculator
//
//  Created by Diparth Patel on 6/15/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


+(NSString *) AdditionWithLeftVal:(double)lhv RightVal:(double)rhv;

+(NSString *) MultiplyLeftVal:(double)lhv WithRightval:(double)rhv;

+(NSString *) SubtractWithLeftVal:(double)lhv Rightval:(double)rhv;

+(NSString *) DivideValue:(double)lhv ByVal:(double)rhv;

+(NSString *) SineOfVal:(double)val;

+(NSString *) CosineOfVal:(double)val;

+(NSString *) TangentOfVal:(double)val;



@end







