//
//  ZHPassDataJSON.m
//  NetWork
//
//  Created by mbp  on 13-8-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHPassDataJSON.h"
#import "ZHDBData.h"





ZHPassDataJSON *instanceControl;

@implementation ZHPassDataJSON


+ (ZHPassDataJSON *)share
{
    if (instanceControl == nil)
    {
        instanceControl = [[ZHPassDataJSON alloc] init];
    }
    
    return instanceControl;
}


- (id) init
{
    self = [super init];
    if (self){
    }
    return self;
}



- (void)insertDBFromTableName:(NSString *)tableName columns:(NSArray *)columns data:(NSArray *)dataArray
{
    
    NSMutableString *sqlString = [NSMutableString string];
    
    
    
    for (NSDictionary *dict in dataArray) {
        
        [sqlString appendFormat:@"INSERT INTO %@ (", tableName];

        
        for (NSString *string in columns) {
            if (string == columns.lastObject) {
                [sqlString appendFormat:@"%@" , string];
            }
            else {
                [sqlString appendFormat:@"%@," , string];
            }
        }
        
        
        [sqlString appendString:@")"];
        [sqlString appendString:@"VALUES ("];
        
        
        
        for (NSString *string in columns) {
            if (string == columns.lastObject) {
                [sqlString appendFormat:@"'%@'", [dict objectForKey:string]];
            }
            else {
                [sqlString appendFormat:@"'%@',", [dict objectForKey:string]];
            }
        }
        
        [sqlString appendString:@");"];

    }
    
    [[ZHDBData share] insertTable:sqlString];



}

/*
 
 判断该表数据是否存在后
 
 以   table  为键名的   取得表数据
 
 */
- (void)jsonToTableDB:(NSDictionary *)jsonDict
{
    

    
    NSString *detil = @"d_ablum";
    NSArray *detilArray = @[@"chief_photo", @"create_time", @"designer_id", @"id", @"name", @"recommend", @"status", @"view_count"];
    [self insertDBFromTableName:detil columns:detilArray data:[jsonDict objectForKey:@"ablumList"]];

    
    NSString *pic = @"d_ablum_photo";
    NSArray *picArray = @[@"ablum_id", @"id", @"photo_id", @"view_count" ];
    [self insertDBFromTableName:pic columns:picArray data:[jsonDict objectForKey:@"ablumPhotoList"]];

    NSString *product = @"d_ablum_tag";
    NSArray *produtionArray = @[@"id", @"ablum_id", @"tag_id" ];
    [self insertDBFromTableName:product columns:produtionArray data:[jsonDict objectForKey:@"ablumTagList"]];

    NSString *designerList = @"d_designer";
    NSArray *designerArray = @[@"id", @"account_enable", @"address", @"city", @"city_text", @"email", @"identiyId", @"introduction", @"level", @"mobile", @"real_name", @"sex", @"user_id" ];
    [self insertDBFromTableName:designerList columns:designerArray data:[jsonDict objectForKey:@"designerList"]];

    
    NSString *fileList = @"d_file";
    NSArray *fileArray = @[@"id", @"create_time", @"file_type", @"show_name", @"path" ];
    [self insertDBFromTableName:fileList columns:fileArray data:[jsonDict objectForKey:@"fileList"]];

    
    NSString *fileRelaList = @"d_file_rela";
    NSArray *fileRelaArray = @[@"id", @"create_time", @"file_id", @"refer_id", @"status" , @"type"];
    [self insertDBFromTableName:fileRelaList columns:fileRelaArray data:[jsonDict objectForKey:@"fileRelaList"]];
    

    
    NSString *newsList = @"d_news";
    NSArray *newsListArray = @[@"id", @"create_time", @"content", @"creator", @"icon" , @"status", @"title", @"summary"];
    
    [self insertDBFromTableName:newsList columns:newsListArray data:[jsonDict objectForKey:@"newsList"]];
    
    
    
    NSString *photoList = @"d_photo";
    NSArray *photoListArray = @[@"id", @"create_time", @"content", @"path", @"status" , @"store_name", @"type" ];
    
    [self insertDBFromTableName:photoList columns:photoListArray data:[jsonDict objectForKey:@"photoList"]];
    
    NSString *photoRelaList = @"d_photo_rela";
    NSArray *photoRelaListArray = @[@"id", @"designer_id", @"photo_id"];
    
    [self insertDBFromTableName:photoRelaList columns:photoRelaListArray data:[jsonDict objectForKey:@"photoRelaList"]];

    
    NSString *tagList = @"d_tag";
    NSArray *tagListArray = @[@"id", @"create_time", @"des_id", @"label", @"name" , @"ref_counter", @"sort", @"status"];
    
    [self insertDBFromTableName:tagList columns:tagListArray data:[jsonDict objectForKey:@"tagList"]];

}




- (void)jsonToDB:(NSDictionary *)jsonDict
{
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.ple.queue", NULL);
    dispatch_async(queue, ^(void) {
        

        [self jsonToTableDB:jsonDict];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate performSelector:@selector(passDidFinish)];
            
        });
        
        
    });
    

}





@end
