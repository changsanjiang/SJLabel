# SJVideoPlayerAssetCarrier

```Objective-C
    - (instancetype)initWithAssetURL:(NSURL *)assetURL;

    /// unit is sec.
    - (instancetype)initWithAssetURL:(NSURL *)assetURL
                           beginTime:(NSTimeInterval)beginTime;

    - (instancetype)initWithAssetURL:(NSURL *)assetURL
                          scrollView:(__unsafe_unretained UIScrollView * __nullable)scrollView
                           indexPath:(__weak NSIndexPath * __nullable)indexPath
                        superviewTag:(NSInteger)superviewTag;

    - (instancetype)initWithAssetURL:(NSURL *)assetURL
                           beginTime:(NSTimeInterval)beginTime
                          scrollView:(__unsafe_unretained UIScrollView *__nullable)scrollView
                           indexPath:(__weak NSIndexPath *__nullable)indexPath
                        superviewTag:(NSInteger)superviewTag;


    #pragma mark - screenshot
    - (UIImage * __nullable)screenshot;

    - (void)screenshotWithTime:(NSTimeInterval)time
    completion:(void(^)(SJVideoPlayerAssetCarrier *asset, SJVideoPreviewModel * __nullable images, NSError *__nullable error))block;

    - (void)screenshotWithTime:(NSTimeInterval)time
    size:(CGSize)size
    completion:(void(^)(SJVideoPlayerAssetCarrier *asset, SJVideoPreviewModel * __nullable images, NSError *__nullable error))block;


    #pragma mark - blocks
    @property (nonatomic, copy, readwrite, nullable) void(^playerItemStateChanged)(SJVideoPlayerAssetCarrier *asset, AVPlayerItemStatus status);

    @property (nonatomic, copy, readwrite, nullable) void(^playTimeChanged)(SJVideoPlayerAssetCarrier *asset, NSTimeInterval currentTime, NSTimeInterval duration);

    @property (nonatomic, copy, readwrite, nullable) void(^playDidToEnd)(SJVideoPlayerAssetCarrier *asset);
    /// 缓冲进度回调
    @property (nonatomic, copy, readwrite, nullable) void(^loadedTimeProgress)(float progress);
    /// 缓冲已为空, 开始缓冲
    @property (nonatomic, copy, readwrite, nullable) void(^beingBuffered)(BOOL state);

    @property (nonatomic, copy, readwrite, nullable) void(^deallocCallBlock)(SJVideoPlayerAssetCarrier *asset);

    @property (nonatomic, copy, readwrite, nullable) void(^scrollViewDidScroll)(SJVideoPlayerAssetCarrier *asset);


    #pragma mark - preview images
    @property (nonatomic, assign, readonly) BOOL hasBeenGeneratedPreviewImages;
    @property (nonatomic, strong, readonly) NSArray<SJVideoPreviewModel *> *generatedPreviewImages;
    - (void)generatedPreviewImagesWithMaxItemSize:(CGSize)itemSize
    completion:(void(^)(SJVideoPlayerAssetCarrier *asset, NSArray<SJVideoPreviewModel *> *__nullable images, NSError *__nullable error))block;
    - (void)cancelPreviewImagesGeneration;


    #pragma mark - properties
    @property (nonatomic, strong, readonly) AVURLAsset *asset;
    @property (nonatomic, strong, readonly) AVPlayerItem *playerItem;
    @property (nonatomic, strong, readonly) AVPlayer *player;
    @property (nonatomic, strong, readonly) NSURL *assetURL;
    @property (nonatomic, assign, readonly) NSTimeInterval beginTime; // unit is sec.
    @property (nonatomic, assign, readonly) NSTimeInterval duration; // unit is sec.
    @property (nonatomic, assign, readonly) NSTimeInterval currentTime; // unit is sec.
    @property (nonatomic, assign, readonly) float progress; // 0..1
    @property (nonatomic, weak, readonly, nullable) NSIndexPath *indexPath;
    @property (nonatomic, assign, readonly) NSInteger superviewTag;
    @property (nonatomic, unsafe_unretained, readonly, nullable) UIScrollView *scrollView;
```
