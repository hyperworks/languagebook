//
//  UnitTests.m
//  UnitTests
//
//  Created by Jonathan Wight on 11/29/12.
//  Copyright (c) 2012 toxicsoftware. All rights reserved.
//

#import "UnitTests.h"

#import "NSData+Base64.h"

@implementation UnitTests

- (void)test1
	{
	NSString *s = @"Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	
	NSString *theExpectedEncodedData = @"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz\r\n\
		IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg\r\n\
		dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu\r\n\
		dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo\r\n\
		ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=";
	theExpectedEncodedData = [theExpectedEncodedData stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	theExpectedEncodedData = [theExpectedEncodedData stringByReplacingOccurrencesOfString:@" " withString:@""];
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

- (void)test2
	{
	NSString *s = @"any carnal pleasure.";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	NSString *theExpectedEncodedData = @"YW55IGNhcm5hbCBwbGVhc3VyZS4=";
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

- (void)test3
	{
	NSString *s = @"any carnal pleasure";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	NSString *theExpectedEncodedData = @"YW55IGNhcm5hbCBwbGVhc3VyZQ==";
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

- (void)test4
	{
	NSString *s = @"any carnal pleasur";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	NSString *theExpectedEncodedData = @"YW55IGNhcm5hbCBwbGVhc3Vy";
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

- (void)test5
	{
	NSString *s = @"any carnal pleasu";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	NSString *theExpectedEncodedData = @"YW55IGNhcm5hbCBwbGVhc3U=";
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

- (void)test6
	{
	NSString *s = @"any carnal pleas";
	NSData *d = [s dataUsingEncoding:NSASCIIStringEncoding];
	NSString *theEncodedData = [d asBase64EncodedString:Base64Flags_IncludeNewlines];
	NSString *theExpectedEncodedData = @"YW55IGNhcm5hbCBwbGVhcw==";
	STAssertEqualObjects(theEncodedData, theExpectedEncodedData, NULL);

	NSData *theDecodedData = [NSData dataWithBase64EncodedString:theEncodedData];
	STAssertEqualObjects(d, theDecodedData, NULL);
	}

@end
