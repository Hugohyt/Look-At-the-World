//
//  VideoResourceLoader.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/4/7.
//

#import "VideoResourceLoader.h"

@interface VideoResourceLoader ()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSMutableArray *pendingRequests;
@property (nonatomic, strong) NSMutableData *downloadedData;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end

@implementation VideoResourceLoader

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
        self.pendingRequests = [NSMutableArray array];
        self.downloadedData = [NSMutableData data];
    }
    return self;
}

- (AVURLAsset *)createPlayableAsset {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self.url resolvingAgainstBaseURL:NO];
    components.scheme = @"streaming"; // 修改 scheme，触发 AVAssetResourceLoader
    NSURL *customURL = components.URL;
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:customURL options:nil];
    [asset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    [self startDownloadingOriginalURL];
    return asset;
}

- (void)startDownloadingOriginalURL {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    self.dataTask = [session dataTaskWithURL:self.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [self.downloadedData appendData:data];
            [self processPendingRequests];
        }
    }];
    [self.dataTask resume];
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.pendingRequests addObject:loadingRequest];
    [self processPendingRequests];
    return YES;
}

- (void)processPendingRequests {
    NSMutableArray *finishedRequests = [NSMutableArray array];
    
    for (AVAssetResourceLoadingRequest *request in self.pendingRequests) {
        if ([self respondToRequest:request]) {
            [finishedRequests addObject:request];
            [request finishLoading];
        }
    }
    [self.pendingRequests removeObjectsInArray:finishedRequests];
}

- (BOOL)respondToRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSUInteger requestedOffset = loadingRequest.dataRequest.requestedOffset;
    NSUInteger requestedLength = loadingRequest.dataRequest.requestedLength;
    
    if (self.downloadedData.length < requestedOffset + requestedLength) {
        return NO;
    }

    NSData *subdata = [self.downloadedData subdataWithRange:NSMakeRange(requestedOffset, requestedLength)];
    [loadingRequest.dataRequest respondWithData:subdata];
    
    if (loadingRequest.contentInformationRequest) {
        loadingRequest.contentInformationRequest.contentType = AVFileTypeMPEG4;
        loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
        loadingRequest.contentInformationRequest.contentLength = self.downloadedData.length;
    }
    
    return YES;
}

@end
