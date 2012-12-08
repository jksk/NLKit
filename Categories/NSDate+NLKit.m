//
//  NSDate+NLKit.m
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

#import "NSDate+NLKit.h"

@implementation NSDate (NLKit)

- (NSComparisonResult)compareIgnoringTime:(NSDate *)other
{
	NSUInteger flags			= NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	NSCalendar* calendar		= [NSCalendar currentCalendar];
	NSDate* selfWithoutTime		= [calendar dateFromComponents:[calendar components:flags fromDate:self]];
	NSDate* otherWithoutTime	= [calendar dateFromComponents:[calendar components:flags fromDate:other]];
	
	return [selfWithoutTime compare:otherWithoutTime];
}

- (NSComparisonResult)compareIgnoringDate:(NSDate *)other
{
	NSUInteger flags			= NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
	NSCalendar* calendar		= [NSCalendar currentCalendar];
	NSDate* selfWithoutDate		= [calendar dateFromComponents:[calendar components:flags fromDate:self]];
	NSDate* otherWithoutDate	= [calendar dateFromComponents:[calendar components:flags fromDate:other]];
	
	return [selfWithoutDate compare:otherWithoutDate];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
	return [self dateByAddingTimeInterval:60 * minutes];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
	return [self dateByAddingTimeInterval:3600 * hours];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
	return [self dateByAddingTimeInterval:86400 * days];
}

- (NSInteger)era
{
	return [[[NSCalendar currentCalendar] components:NSEraCalendarUnit fromDate:self] era];
}

- (NSInteger)year
{
	return [[[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self] year];
}

- (NSInteger)month
{
	return [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self] month];
}

- (NSInteger)day
{
	return [[[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self] day];
}

- (NSInteger)week
{
	return [[[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self] week];
}

- (NSInteger)weekday
{
	return [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self] weekday];
}

- (NSInteger)hour
{
	return [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self] hour];
}

- (NSInteger)minute
{
	return [[[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self] minute];
}

- (NSInteger)second
{
	return [[[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self] second];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	
	[df setDateStyle:dateStyle];
	[df setTimeStyle:timeStyle];
	
	return [df stringFromDate:self];
}

- (NSString *)stringWithShortDateAndTime
{
	return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)stringWithShortDate
{
	return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)stringWithShortTime
{
	return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

@end
