//
//  productCCell.m
//  OrientParkson
//
//  Created by i-Bejoy on 14-1-3.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import "ProductCCell.h"

@implementation ProductCCell
 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"productlist_cell"]];
        _imgView1 = [[ImageView share] addToView:self
                                               imagePathName:nil rect:RectMake2x(2, 2, 462, 384)];
        
        
        
//        [[Button share] addToView:self addTarget:self rect:RectMake2x(0, 0, 466, 388) tag:301 action:@selector(openProductDetail:)];
        
//        [[ImageView share] addToView:_imgView1 imagePathName:@"productlist_cell_blackbox" rect:RectMake2x(10, 285, 446, 93)];
//        
//        
//        ctnameLabel = [[UILabel alloc] initWithFrame:RectMake2x(25, 285, 446, 43)];
//        ctnameLabel.font = [UIFont systemFontOfSize:13];
//        ctnameLabel.textColor = [UIColor whiteColor];
//        ctnameLabel.tag = 201;
//        
//        pbNameLabel = [[UILabel alloc] initWithFrame:RectMake2x(25, 325, 446, 43)];
//        pbNameLabel.font = [UIFont systemFontOfSize:16];
//        pbNameLabel.textColor = [UIColor whiteColor];
//        pbNameLabel.tag = 2001;
//        
//        [_imgView1 addSubview:ctnameLabel];
//        [_imgView1 addSubview:pbNameLabel];

        
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    if (_dict != dict) {
        _dict = dict;
    }
    NSString *nameString = [dict objectForKey:@"pic_name"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:KDocumentName(nameString)];

    self.imgView1.image = img;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
