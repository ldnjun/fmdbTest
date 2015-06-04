//
//  SJShop.m
//  将任意对象存进数据库
//
//  Created by 宋林涛 on 15-6-4.
//  Copyright (c) 2015年 yamon. All rights reserved.
//

#import "SJShop.h"

@implementation SJShop


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeFloat:self.price forKey:@"price"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
      self.name = [aDecoder decodeObjectForKey:@"name"];
      self.price = [aDecoder decodeFloatForKey:@"price"];
    }
    return self;
}
@end
