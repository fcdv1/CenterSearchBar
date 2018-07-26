//
//  SSSearchBar.m
//  Demo
//
//  Created by xk jiang on 2017/10/10.
//  Copyright © 2017年 xk jiang. All rights reserved.
//

#import "SSSearchBar.h"

@interface SSSearchBar () <UITextFieldDelegate>


@end

// icon宽度
static CGFloat const searchIconW = 14;
// icon与placeholder间距
static CGFloat const iconSpacing = 8;

@implementation SSSearchBar

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setPositionAdjustment:UIOffsetMake([self centerOffSet], 0) forSearchBarIcon:UISearchBarIconSearch];
}
-(CGFloat) centerOffSet{
    UITextField *searchField = [self valueForKey:@"_searchField"];
    CGFloat textLength = [self placeholderWidth];
    CGFloat headerLength = searchIconW + iconSpacing * 2;
    CGFloat totalLength = textLength + headerLength;
    CGFloat offSet = (searchField.frame.size.width - totalLength)/2;
    if (offSet < 0) {
        offSet = 0;
    }
    return offSet;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake([self centerOffSet], 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

- (CGFloat)placeholderWidth {
        UITextField *searchField = [self valueForKey:@"_searchField"];
    CGFloat fontSize = searchField.font.pointSize;
    NSString *text = self.placeholder;
    if (self.text.length > 0) {
        text = self.text;
    }
    if (text.length == 0) {
        return 0;
    } else {
         CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
        return size.width;
    }
}

@end
