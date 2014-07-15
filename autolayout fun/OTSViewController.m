//
//  OTSViewController.m
//  autolayout fun
//
//  Created by otiose on 7/13/14.
//  Copyright (c) 2014 otiose. All rights reserved.
//

#import "OTSViewController.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "OTSCollectionViewCell.h"

static NSString * const kOTSCollectionCellIdentifier = @"OTSCollectionViewCell";

@interface OTSViewController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *texts;

@property (strong, nonatomic) OTSCollectionViewCell *prototypeCell;
@end

@implementation OTSViewController

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self generateItems];

    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumColumnSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.columnCount = 2;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:@"OTSCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:kOTSCollectionCellIdentifier];
    self.prototypeCell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    NSDictionary *views = NSDictionaryOfVariableBindings(collectionView);
    NSArray *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:views];
    NSArray *horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"|[collectionView]|" options:0 metrics:nil views:views];
    [self.view addConstraints:horizontal];
    [self.view addConstraints:vertical];
}

#pragma mark - UICollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OTSCollectionViewCell *cell = (OTSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kOTSCollectionCellIdentifier forIndexPath:indexPath];

    NSString *title = self.titles[indexPath.item];
    NSString *text = self.texts[indexPath.item];
    if ([text isEqual:@"."]) {
        NSLog(@"");
    }
    [cell configureWithTitle:title text:text];

    CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if ([text isEqual:@"."]) {
        NSLog(@"dconfigure stupid dot size: %@", NSStringFromCGSize(size));
        NSLog(@"actual size: %@", NSStringFromCGSize(cell.bounds.size));
    }


    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titles[indexPath.item];
    NSString *text = self.texts[indexPath.item];

    [self.prototypeCell configureWithTitle:title text:text];

    CGSize size = [self.prototypeCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if ([text isEqual:@"."]) {
        NSLog(@"stupid dot size: %@", NSStringFromCGSize(size));
    }

    return size;
}

- (void)generateItems {
    NSArray *defaultTitles = [self generateTitles];
    NSArray *defaultTexts = [self generateTexts];

    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *texts = [NSMutableArray array];

    for (NSInteger i = 0; i < 300; i++) {
        NSString *title = defaultTitles[arc4random_uniform(defaultTitles.count)];
        NSString *text = defaultTexts[arc4random_uniform(defaultTexts.count)];
        [titles addObject:title];
        [texts addObject:text];
    }

    self.titles = titles;
    self.texts = texts;
}

- (NSArray *)generateTitles {
    return @[@"#iphonedev",
             @"#iphonedev-chat",
             @"we need some longer titles too",
             @"_"];
}

- (NSArray *)generateTexts {
    return @[@"This is a text field that is supposed to grow",
             @"Because there are two that are both dynamic, the layout ends up ambiguous and stuff",
             @"no work",
             @"."];
}

@end
