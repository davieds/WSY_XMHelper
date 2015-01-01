//
//  XMVideoDetailViewModel.m
//  WSY_XMHelper
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "XMVideoDetailViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XMDataManager.h"


@implementation XMVideoDetailViewModel

+ (instancetype)detailViewModelWithVideoListType:(VIDEO_TYPE)type name:(NSString *)name videoId:(NSString *)ID
{
    return [[self alloc] initDetailViewModelWithVideoListType:type name:name videoId:ID];
}
- (instancetype)initDetailViewModelWithVideoListType:(VIDEO_TYPE)type name:(NSString *)name videoId:(NSString *)ID
{
    self = [super init];
    if (self) {
        self.type = type;
        self.name = name;
        self.ID = ID;
        self.page = 1;
    }
    return self;
}
- (NSMutableArray *)detailList
{
    if (_detailList == nil) {
        _detailList = [NSMutableArray new];
    }
    return _detailList;
}
- (RACSignal *)fetchObject
{
    return [[[XMDataManager defaultDataManager] requestVideoDetailListWithType:_type name:_ID page:_page] doNext:^(NSArray *list) {
        [self.detailList removeAllObjects];
        [self.detailList addObjectsFromArray:list];
    }];
}
- (RACSignal *)fetchMoreObject
{
    return [[[XMDataManager defaultDataManager] requestVideoDetailListWithType:self.type name:self.ID page:self.page] doNext:^(NSArray *list) {
        [self.detailList addObjectsFromArray:list];
    }];
}
-(NSInteger)page
{
    return (_page +1);
}
@end
