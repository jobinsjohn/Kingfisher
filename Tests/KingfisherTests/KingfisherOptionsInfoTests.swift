//
//  KingfisherOptionsInfoTests.swift
//  Kingfisher
//
//  Created by Wei Wang on 16/1/4.
//
//  Copyright (c) 2019 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import XCTest
@testable import Kingfisher

class KingfisherOptionsInfoTests: XCTestCase {

    func testEmptyOptionsShouldParseCorrectly() {
        let options = KingfisherParsedOptionsInfo(KingfisherOptionsInfo.empty)
        XCTAssertTrue(options.targetCache === nil)
        XCTAssertTrue(options.downloader === nil)

#if os(iOS) || os(tvOS)
        switch options.transition {
        case .none: break
        default: XCTFail("The transition for empty option should be .None. But \(options.transition)")
        }
#endif
        
        XCTAssertEqual(options.downloadPriority, URLSessionTask.defaultPriority)
        XCTAssertFalse(options.forceRefresh)
        XCTAssertFalse(options.fromMemoryCacheOrRefresh)
        XCTAssertFalse(options.cacheMemoryOnly)
        XCTAssertFalse(options.backgroundDecode)
        XCTAssertEqual(options.callbackQueue.queue.label, DispatchQueue.main.label)
        XCTAssertEqual(options.scaleFactor, 1.0)
        XCTAssertFalse(options.keepCurrentImageWhileLoading)
<<<<<<< HEAD
=======
        XCTAssertFalse(options.onlyLoadFirstFrame)
<<<<<<< HEAD
>>>>>>> onevcat/master
=======
        XCTAssertFalse(options.cacheOriginalImage)
>>>>>>> onevcat/master
    }
    
    func testSetOptionsShouldParseCorrectly() {
        let cache = ImageCache(name: "com.onevcat.Kingfisher.KingfisherOptionsInfoTests")
        let downloader = ImageDownloader(name: "com.onevcat.Kingfisher.KingfisherOptionsInfoTests")
        
        let queue = DispatchQueue.global(qos: .default)
        let testModifier = TestModifier()
        let testRedirectHandler = TestRedirectHandler()
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        let serializer = FormatIndicatedCacheSerializer.png
        let modifier = AnyImageModifier { i in return i }

        var options = KingfisherParsedOptionsInfo([
            .targetCache(cache),
            .downloader(downloader),
            .originalCache(cache),
            .downloadPriority(0.8),
            .forceRefresh,
            .forceTransition,
            .fromMemoryCacheOrRefresh,
            .cacheMemoryOnly,
            .waitForCache,
            .onlyFromCache,
            .backgroundDecode,
            .callbackQueue(.dispatch(queue)),
            // Not sure why but we need `KingfisherOptionsInfoItem` to compile...
            KingfisherOptionsInfoItem.scaleFactor(2.0),
            .preloadAllAnimationData,
            .requestModifier(testModifier),
            .redirectHandler(testRedirectHandler),
            .processor(processor),
<<<<<<< HEAD
<<<<<<< HEAD
            .keepCurrentImageWhileLoading
=======
=======
            .cacheSerializer(serializer),
            .imageModifier(modifier),
>>>>>>> onevcat/master
            .keepCurrentImageWhileLoading,
<<<<<<< HEAD
            .onlyLoadFirstFrame
>>>>>>> onevcat/master
=======
            .onlyLoadFirstFrame,
            .cacheOriginalImage
<<<<<<< HEAD
>>>>>>> onevcat/master
        ]
=======
        ])
>>>>>>> onevcat/master
        
        XCTAssertTrue(options.targetCache === cache)
        XCTAssertTrue(options.originalCache === cache)
        XCTAssertTrue(options.downloader === downloader)

        #if os(iOS) || os(tvOS)
        let transition = ImageTransition.fade(0.5)
        options.transition = transition
        switch options.transition {
        case .fade(let duration): XCTAssertEqual(duration, 0.5)
        default: XCTFail()
        }
        #endif
        
        XCTAssertEqual(options.downloadPriority, 0.8)
        XCTAssertTrue(options.forceRefresh)
        XCTAssertTrue(options.fromMemoryCacheOrRefresh)
        XCTAssertTrue(options.forceTransition)
        XCTAssertTrue(options.cacheMemoryOnly)
        XCTAssertTrue(options.waitForCache)
        XCTAssertTrue(options.onlyFromCache)
        XCTAssertTrue(options.backgroundDecode)
        
        XCTAssertEqual(options.callbackQueue.queue.label, queue.label)
        XCTAssertEqual(options.scaleFactor, 2.0)
        XCTAssertTrue(options.preloadAllAnimationData)
        XCTAssertTrue(options.requestModifier is TestModifier)
        XCTAssertTrue(options.redirectHandler is TestRedirectHandler)
        XCTAssertEqual(options.processor.identifier, processor.identifier)
        XCTAssertTrue(options.cacheSerializer is FormatIndicatedCacheSerializer)
        XCTAssertTrue(options.imageModifier is AnyImageModifier)
        XCTAssertTrue(options.keepCurrentImageWhileLoading)
<<<<<<< HEAD
=======
        XCTAssertTrue(options.onlyLoadFirstFrame)
<<<<<<< HEAD
>>>>>>> onevcat/master
=======
        XCTAssertTrue(options.cacheOriginalImage)
    }
    
    func testOptionCouldBeOverwritten() {
        var options = KingfisherParsedOptionsInfo([.downloadPriority(0.5), .onlyFromCache])
        XCTAssertEqual(options.downloadPriority, 0.5)

        options = KingfisherParsedOptionsInfo([.downloadPriority(0.5), .onlyFromCache, .downloadPriority(0.8)])
        XCTAssertEqual(options.downloadPriority, 0.8)
<<<<<<< HEAD
        
        options.append(.downloadPriority(1.0))
        XCTAssertEqual(options.downloadPriority, 1.0)
>>>>>>> onevcat/master
=======
>>>>>>> onevcat/master
    }
}

class TestModifier: ImageDownloadRequestModifier {
    func modified(for request: URLRequest) -> URLRequest? {
        return nil
    }
}

class TestRedirectHandler: ImageDownloadRedirectHandler {
    func handleHTTPRedirection(for task: SessionDataTask, response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(newRequest)
    }
}
