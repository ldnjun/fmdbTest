//
//  ViewController.m
//  将任意对象存进数据库
//
//  Created by 宋林涛 on 15-6-4.
//  Copyright (c) 2015年 yamon. All rights reserved.
//

#import "ViewController.h"
#import "SJShop.h"
#import "FMDB.h"
@interface ViewController ()
@property(nonatomic ,strong)FMDatabase *db;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *path = NSHomeDirectory();
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *docDic = [paths objectAtIndex:0];
//    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    [self setup];
    //[self addShops];
    [self readShop];
}
- (void)setup{
    NSString *path = @"/Users/songlintao/Desktop/shops.data";
    self.db = [FMDatabase databaseWithPath:path];
    [self.db open];
    //创表
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop(id integer PRIMARY KEY,shop blob NOT NULL);"];
}

- (void)readShop{
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_shop LIMIT 10,10"];
    while (set.next) {
      NSData *data = [set objectForColumnName:@"shop"];
        SJShop *shop = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"------%@",shop.name);
    }
}

- (void)addShops{
    for (int i = 0; i<1000; i++) {
        SJShop *shop = [[SJShop alloc]init];
        shop.name = [NSString stringWithFormat:@"商品--%d",i];
        shop.price = arc4random()%10000;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shop];
        [self.db executeUpdateWithFormat:@"INSERT INTO t_shop(shop) VALUES(%@);",data];
         
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];}

@end
