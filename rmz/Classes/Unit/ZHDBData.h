//
//  ZHDBData.h
//  Dyrs
//
//  Created by mbp  on 13-9-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { DLog(@"Failure on line %d", __LINE__); abort(); } }


#define ImageType_Dept                  0
#define ImageType_Case                  1
#define ImageType_Designer_BigAvart     2
#define ImageType_AccessType            3
#define ImageType_Access                4
#define ImageType_Designer_Avart        5


#define Member_Manage     0
#define Member_Designer     1
#define Member_DesignerVIP     2

    

@interface ZHDBData : NSObject
{
    FMDatabase *db;

    
}

+ (ZHDBData *)share;


- (void)stringToDBSqlString:(NSString *)sqlString;
- (void)insertTable:(NSString *)sql;





- (void)updatePicDownLoaded:(NSString *)pid;
- (void)deleteAllData;



/** 获取设计师信.
 返回：设计师姓名，电话， 邮箱，介绍，
 real_name, mobile, email, adress, introduction 
 */
- (NSMutableDictionary *)getDesignerForD_Id:(NSString * )designer_id;

/** 获取案例列表.
 返回：列表 照片，名称
 
*/
- (NSMutableArray *)getCasesForD_Id:(NSString * )designer_id;

/**  获取案例详情.
 返回： 案例图片list，
 */
- (NSMutableArray *)getCasesDetailForC_Id:(NSString * )case_id;

/** 获取手绘列表.
 返回：图片组
 
*/
- (NSMutableArray *)getPhotoForD_Id:(NSString * )designer_id;

/** 获取设计师 文档列表.
 返回：文档list ， 名称， 物理地址
 
*/
- (NSMutableArray *)getFilesForD_Id:(NSString * )designer_id;


/** 获取设计师 标签信息.
 返回： 所有标签
 */
- (NSMutableArray *)getTagsForD_Id:(NSString * )designer_id;



/** 获取 标签信息 .
 返回： 所有标签
 */
- (NSMutableArray *)getTagsForSort:(NSString * )sort;


/** 获取设计师 案例.
 tags：   多标签
 返回： 案例list
 */
- (NSMutableArray *)getCaseForTags:(NSMutableArray * )tagsArray;

/** 获取设计师 案例.
 key word：
 返回： 案例list
 */
- (NSMutableArray *)getCaseForWords:(NSString * )keyWord;


/** 获取  所有需要下载的图片

 返回： 图片信息
 */
- (NSMutableArray *)getPics;


@end
