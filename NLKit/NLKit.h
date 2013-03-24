//
//  NLKit.h
//
//  Created by Jesper Skrufve <jesper@neolo.gy>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "NLMacros.h"
#import "NLMath.h"
#import "NLTiming.h"
#import "NLAtomic.h"

// Categories
#import "NLKit/NSArray+NLKit.h"
#import "NLKit/NSData+NLKit.h"
#import "NLKit/NSDate+NLKit.h"
#import "NLKit/NSDateFormatter+NLKit.h"
#import "NLKit/NSDictionary+NLKit.h"
#import "NLKit/NSMutableArray+NLKit.h"
#import "NLKit/NSNotificationCenter+NLKit.h"
#import "NLKit/NSNotificationCenter+NLKit_Threading.h"
#import "NLKit/NSNumber+NLKit.h"
#import "NLKit/NSOrderedSet+NLKit.h"
#import "NLKit/NSSet+NLKit.h"
#import "NLKit/NSString+NLKit.h"
#import "NLKit/NSString+NLKit_Hash.h"
#import "NLKit/NSUserDefaults+NLKit.h"
#import "NLKit/UIApplication+NLKit_NetworkActivity.h"
#import "NLKit/UIBarButtonItem+NLKit.h"
#import "NLKit/UICollectionView+NLKit.h"
#import "NLKit/UIColor+NLKit.h"
#import "NLKit/UIDevice+NLKit.h"
#import "NLKit/UIImage+NLKit.h"
#import "NLKit/UITableView+NLKit.h"
#import "NLKit/UIView+NLKit.h"
#import "NLKit/UIView+NLKit_Animations.h"
#import "NLKit/UIViewController+NLKit.h"
#import "NLKit/UIWindow+NLKit.h"

// View Controllers
#import "NLKit/NLViewController.h"
#import "NLKit/NLTableViewController.h"
#import "NLKit/NLCollectionViewController.h"
#import "NLKit/NLFetchedResultsCollectionViewController.h"
#import "NLKit/NLFetchedResultsTableViewController.h"

// Views
#import "NLKit/NLTableViewCell.h"
#import "NLKit/NLFastDrawTableViewCell.h"
#import "NLKit/NLActivityIndicatorView.h"
#import "NLKit/NLDotActivityIndicatorView.h"
#import "NLKit/NLProgressView.h"
#import "NLKit/NLBarActivityIndicatorView.h"
#import "NLKit/NLAutoCompleteTextField.h"
#import "NLKit/NLTopmostView.h"

// Decorators
#import "NLKit/NLKeychain.h"
#import "NLKit/NLLocationController.h"

// External
#import "NLKit/NSData+Base64.h"
