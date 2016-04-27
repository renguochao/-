#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RGCTopicTypeAll = 1,
    RGCTopicTypePicture = 10,
    RGCTopicTypeWord = 29,
    RGCTopicTypeVoice = 31,
    RGCTopicTypeVideo = 41
} RGCTopicType;

/** 精华-所有顶部标题的高度 */
UIKIT_EXTERN CGFloat const RGCTitlesViewH;
/** 精华-所有顶部标题的y */
UIKIT_EXTERN CGFloat const RGCTitlesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const RGCTopicCellMargin;
/** 精华-cell-文字内容y值 */
UIKIT_EXTERN CGFloat const RGCTopicCellTextY;
/** 精华-cell-底部工具条高度 */
UIKIT_EXTERN CGFloat const RGCTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const RGCTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度，就用break */
UIKIT_EXTERN CGFloat const RGCTopicCellPictureBreakH;