//
//  XFPCommonDao.m
//  XFrameworkPackaging
//
//  Created by hjpraul on 15/6/12.
//  Copyright (c) 2015年 hjpraul. All rights reserved.
//

#import "XFPCommonDao.h"
#import "FMDB.h"
#import "MJExtension.h"
#import "JSON.h"

#define XFP_DB_PATH_OF_NAME              [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"XFPDao.db"]
#define XFP_DB_TB_NAME(prefix,className) [NSString stringWithFormat:@"%@_%@",prefix,className]

//#define XFP_FUNCTION_NAMES   @[@""]

@implementation XFPCommonDao

+ (void)storeObjects:(NSArray *)objects
              toDBTB:(NSString *)tbNamePrefix{
    id unitObject = SAFE_GET_ARRAY_OBJECT(objects, 0);
    if (!unitObject) {
        return;
    }
    // 假定objects数组所有成员都是同样类型
    NSString *className = NSStringFromClass([unitObject class]);
    FMDatabase *db = [FMDatabase databaseWithPath:XFP_DB_PATH_OF_NAME];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return;
    }
    
    NSDictionary *unitDic = [(NSObject *)unitObject keyValues];
    if ([db tableExists:XFP_DB_TB_NAME(tbNamePrefix,className)]) {
        // 如果表存在，枚举出列名
        FMResultSet *rs = [db getTableSchema:XFP_DB_TB_NAME(tbNamePrefix,className)];
        NSMutableArray *columnNames = [NSMutableArray array];
        while ([rs next]) {
//            - `cid` - The column ID number
//            - `name` - The name of the column
//            - `type` - The data type specified for the column
//                - `notnull` - whether the field is defined as NOT NULL (i.e. values required)
//                - `dflt_value` - The default value for the column
//                    - `pk` - Whether the field is part of the primary key of the table
            NSString *columnName = [rs stringForColumn:@"name"];
            if (columnName) {
                [columnNames addObject:columnName];
            }
        }
        // 列名与数据对象比对，如果数据对象中有列名列表之外的列，则插入
        for (NSString *key in unitDic.allKeys) {
            BOOL hasKey = NO;
            for (NSString *columnName in columnNames) {
                if ([columnName isEqualToString:key]) {
                    hasKey = YES;
                    break;
                } else {
                    continue;
                }
            }
            if (!hasKey) {
                NSString *insertColumnSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN '%@' VARCHAR",XFP_DB_TB_NAME(tbNamePrefix,className),key];
                if (![db executeUpdate:insertColumnSql]) {
                    goto completed;
                }
            }
        }
    } else {
        // 如果表不存在，新建表
        NSMutableString *columDescSql = [NSMutableString string];
        for (NSString *key in unitDic.allKeys) {
//            id obj = SAFE_PARSE_DICT(dic, key);
            [columDescSql appendFormat:@", '%@' VARCHAR",key];
        }
        NSString *createSql = [NSString stringWithFormat:@"CREATE  TABLE  IF NOT EXISTS '%@' ('autoIncID' INTEGER PRIMARY KEY AUTOINCREMENT%@)",XFP_DB_TB_NAME(tbNamePrefix,className),columDescSql];
        if (![db executeUpdate:createSql]) {
            goto completed;
        }
    }
    
    // 插入数据
    for (id obj in objects) {
        NSDictionary *objDic = [(NSObject *)obj keyValues];
        NSMutableString *columnNamesSql = [NSMutableString string];
        NSMutableString *columnValuesSql = [NSMutableString string];
        for (NSString *key in objDic.allKeys) {
            [columnNamesSql appendFormat:@"'%@',",key];
            id value = SAFE_PARSE_DICT(objDic, key);
            NSString *valueStr = nil;
            ///TODO:暂时都转换成String
            if (value) {
                valueStr = [value JSONString];
            } else {
                valueStr = @"";
            }
            [columnValuesSql appendFormat:@"'%@',",valueStr];
        }
        if (columnNamesSql.length > 0) {
            [columnNamesSql deleteCharactersInRange:NSMakeRange(columnNamesSql.length-1, 1)];
        }
        if (columnValuesSql.length > 0) {
            [columnValuesSql deleteCharactersInRange:NSMakeRange(columnValuesSql.length-1, 1)];
        }
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO '%@' (%@) VALUES (%@)",XFP_DB_TB_NAME(tbNamePrefix,className),columnNamesSql,columnValuesSql];
        BOOL worked = [db executeUpdate:insertSql];
        if (!worked) {
            ;///TODO:
        }
    }
    
completed:
    [db close];
    return;
}

+ (NSArray *)loadObjectsFromDBTB:(NSString *)tbNamePrefix
                       className:(NSString *)className
                           range:(NSRange)range {
    FMDatabase *db = [FMDatabase databaseWithPath:XFP_DB_PATH_OF_NAME];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return nil;
    }
    
    NSMutableArray *tempObjects = [NSMutableArray array];
    NSString *querySql = nil;
    if (range.length > 0) {
        querySql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY autoIncID LIMIT %zd,%zd",XFP_DB_TB_NAME(tbNamePrefix,className),range.location,range.length];
    } else {
        querySql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY autoIncID ",XFP_DB_TB_NAME(tbNamePrefix,className)];
    }
    FMResultSet *rs = [db executeQuery:querySql];
    while ([rs next]) {
        // 解析
        NSMutableDictionary *rs2dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < rs.columnCount; i++) {
            id value = [rs objectForColumnIndex:i];
            ///TODO:
            if ([value isKindOfClass:[NSString class]]) {
                value = [value objectFromJSONString];
            }
            if (!value) {
                value = [rs objectForColumnIndex:i];
            }
            [rs2dic setObject:value forKey:[rs columnNameForIndex:i]];
        }
        id obj = [NSClassFromString(className) objectWithKeyValues:rs2dic];
        if (obj) {
            [tempObjects addObject:obj];
        }
    }
    [db close];
    return [NSArray arrayWithArray:tempObjects];
}

@end
