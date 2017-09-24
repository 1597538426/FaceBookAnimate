//
//  FaceBookLikeView.m
//  FaceBookLikeView
//
//  Created by 伟哥 on 2017/9/24.
//  Copyright © 2017年 vege. All rights reserved.
//

#import "FaceBookLikeView.h"
#import <Masonry.h>
#import "UIImage+animatedGIF.h"


static CGFloat const EmojiSpace = 4.5;
static CGFloat const EmojiNoramlWidth  = 45.0;
static CGFloat const EmojiSmallWidth  = 36.0;

CGFloat BgSmallHeight = EmojiSmallWidth + 2 * EmojiSpace;
CGFloat BgNoramlHeight = EmojiNoramlWidth + 2 * EmojiSpace;
CGFloat SelectEmojiWidth = (EmojiNoramlWidth - EmojiSmallWidth) * 5 + EmojiNoramlWidth;

@interface FaceBookLikeView ()
{
    UIView * selectEmoji;
}
@property(nonatomic, strong) UIView * emojiBgView;
@property(nonatomic, strong) NSArray * emojiViewArray;
@end
@implementation FaceBookLikeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        _emojiBgView = [[UIView alloc]init];
        _emojiBgView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_emojiBgView];
        [_emojiBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(self);
            make.height.mas_equalTo(BgNoramlHeight);
            make.width.mas_equalTo(6 * EmojiNoramlWidth + 7 * EmojiSpace);
        }];
        
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            NSString * str = [NSString stringWithFormat:@"Emoji%d",i];
            NSURL* imageUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:str ofType:@"gif"]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
            
            UIImageView * emojiImageView = [[UIImageView alloc]init];
            
            UIImage * image = [UIImage animatedImageWithAnimatedGIFData:imageData];
            emojiImageView.image = image;
            [_emojiBgView addSubview:emojiImageView];
            [array addObject:emojiImageView];
        }
        
        _emojiViewArray = [NSArray arrayWithArray:array];
        UIView * firstView = [_emojiViewArray firstObject];
        [_emojiBgView addSubview:firstView];
        
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_emojiBgView).offset(EmojiSpace);
            make.bottom.equalTo(_emojiBgView).offset(-EmojiSpace);
            make.width.mas_equalTo(EmojiNoramlWidth);
            make.height.mas_equalTo(EmojiNoramlWidth);
        }];
        
        for (int i = 1; i < _emojiViewArray.count; i ++) {
            UIView * view = _emojiViewArray[i];
            [_emojiBgView addSubview:view];
            
            UIView * beforeView = _emojiViewArray[i - 1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(firstView);
                make.width.mas_equalTo(EmojiNoramlWidth);
                make.height.mas_equalTo(EmojiNoramlWidth);
                make.left.equalTo(beforeView.mas_right).offset(EmojiSpace);
            }];
        }
        
        
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [_emojiBgView addGestureRecognizer:panGesture];
    
    }
    return self;
}

#pragma mark - Private Methods
-(void)resetUI{
    
    [self.emojiViewArray enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(EmojiNoramlWidth);
            make.height.mas_equalTo(EmojiNoramlWidth);
        }];
    }];
    
    [_emojiBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BgNoramlHeight);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)seletcEmojiWithIndex:(NSInteger)index{
    [self.emojiViewArray enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            [obj mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SelectEmojiWidth);
                make.height.mas_equalTo(SelectEmojiWidth);
            }];
        }else{
            [obj mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(EmojiSmallWidth);
                make.height.mas_equalTo(EmojiSmallWidth);
            }];
        }
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
#pragma mark - Events
-(void)panGesture:(UIPanGestureRecognizer * )recognizer{
    switch (recognizer.state) {
            
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [recognizer locationInView:self];
            if (point.y > 100 || point.y < -100) {
                [self resetUI];
            }else{
                [self.emojiViewArray enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (point.x >= obj.frame.origin.x && point.x <= CGRectGetMaxX(obj.frame)) {
                        [self seletcEmojiWithIndex:idx];
                        *stop = YES;
                    }
                }];
                [_emojiBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(BgSmallHeight);
                }];
                [UIView animateWithDuration:0.25 animations:^{
                    [self layoutIfNeeded];
                }];
            }
            
        }
            
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self resetUI];
        default:
            break;
    }
}
@end
