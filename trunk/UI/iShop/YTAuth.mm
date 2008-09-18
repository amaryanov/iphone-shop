/*
 *  YTAuth.c
 *  certtest
 *
 *  Created by Anton Maryanov on 9/13/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#import "YTAuth.h"
@implementation YTAuth

+ (NSData*) cert
{
	NSData *cert;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data_ark.plist" ofType:nil];
	NSData *plistData;
	NSString *error;
	NSPropertyListFormat format;
	id plist;
	plistData = [NSData dataWithContentsOfFile:path];
	plist = [NSPropertyListSerialization propertyListFromData:plistData
											 mutabilityOption:NSPropertyListImmutable
													   format:&format
											 errorDescription:&error];
	if(!plist)
	{
		NSLog(error);
		[error release];
	}
	else
	{
		NSDictionary *dict = plist;
		cert = [dict objectForKey:@"-DeviceCertificate"];
	}
	return cert;
}

+ (NSData*) signTheData:(NSData*) data
{
	NSData* sig;
	unsigned char *sigret;
	unsigned int siglen;
	EVP_PKEY *pkey;
	OpenSSL_add_all_ciphers();
	OpenSSL_add_all_digests();
	OpenSSL_add_all_algorithms();
	
	BIO *inn;
	//inn = BIO_new_file([[[NSBundle mainBundle] pathForResource:@"device_private_key.pem" ofType:nil] UTF8String], "r");
	inn = BIO_new(BIO_s_mem());
	NSData *file = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"my_key.pem" ofType:nil]];
	NSRange range;
	range.location = [file length] - 1;
	range.length = 1;
	unsigned char buf[1];
	[file getBytes:buf range:range];
	if(buf[0] == '\n')
		BIO_write(inn, [file bytes], [file length] - 1);
	else
		BIO_write(inn, [file bytes], [file length]);
	
    BIO_flush(inn);
	
	pkey = PEM_read_bio_PrivateKey(inn, NULL,NULL, NULL);
	BIO_free(inn);
	
	siglen = EVP_PKEY_size(pkey);
	sigret = (unsigned char*)malloc(siglen);
	EVP_MD_CTX md_ctx;
	EVP_SignInit(&md_ctx, EVP_get_digestbyname("SHA1"));
	EVP_SignUpdate(&md_ctx, [data bytes], [data length]);
	EVP_SignFinal (&md_ctx, sigret, &siglen, pkey);
	EVP_PKEY_free(pkey);
	sig = [NSData dataWithBytes:sigret length:siglen];
	free(sigret);
	return sig;
}

+ (NSString*) getToken
{
	NSString *res = [[NSUserDefaults standardUserDefaults] stringForKey:@"YTAUTHTOKEN"];
	if(res == nil)
	{
		res = [YTAuth updateToken];
	}
	//[res retain];
	return res;
}

+ (NSString*) updateToken
{
	NSString *res;
	NSData* r1;
	NSData* hr1;
	NSData *r2;
	NSData *hmackr2;
	NSString *req;
	NSData * requestData;
	NSData *responseData;
	NSError * err;
	NSMutableURLRequest *urlRequest;
	NSURLResponse * resp;
	NSString *responseStr;
	NSArray *responseArr;
	NSArray *authArr;
	NSString *resStr;
	resp = [NSURLResponse alloc];
	err = [NSError alloc];
	NSData* cert = [YTAuth cert];
	r1 = [NSData randomData:20];
	hr1 = [r1 SHA];
	req = [NSString stringWithFormat:@"hr1=%s", [[hr1 webSafeBase64Encode] UTF8String]];
	requestData = [req dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion:YES];
	
	NSURL *applelogin1 = [NSURL URLWithString:@"http://www.google.com/youtube/accounts/applelogin1"];
	urlRequest = [NSMutableURLRequest  requestWithURL:applelogin1];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:requestData];
	responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&resp error:&err];
	responseStr = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
	responseArr = [responseStr componentsSeparatedByString:@"\n"];
	NSString *r2str = [responseArr objectAtIndex:0];
	NSArray *r2Arr = [r2str componentsSeparatedByString:@"="];
	NSString *r2ResStr = [r2Arr objectAtIndex:1];
	r2 = [r2ResStr webSafeBase64Decode];
	NSString *hmackr2Str = [responseArr objectAtIndex:1];
	NSArray *hmackr2Arr = [hmackr2Str componentsSeparatedByString:@"="];
	NSString *hmackr2ResStr = [hmackr2Arr objectAtIndex:1];
	hmackr2 = [hmackr2ResStr webSafeBase64Decode];
	
	NSMutableData *signData;
	signData = [NSMutableData dataWithData:r2];
	[signData appendData:r1];
	NSData* sig = [YTAuth signTheData:signData];
	
	req = [NSString stringWithFormat:@"r1=%s&r2=%s&cert=%s&sig=%s&hr1=%s&hmackr2=%s",
		   [[r1 webSafeBase64Encode] UTF8String], [[r2 webSafeBase64Encode] UTF8String],
		   [[cert webSafeBase64Encode] UTF8String], [[sig webSafeBase64Encode] UTF8String],
		   [[hr1 webSafeBase64Encode] UTF8String], [[hmackr2 webSafeBase64Encode] UTF8String]];
	requestData = [req dataUsingEncoding: NSUTF8StringEncoding];
	NSURL *applelogin2 = [NSURL URLWithString:@"http://www.google.com/youtube/accounts/applelogin2"];
	urlRequest = [NSMutableURLRequest  requestWithURL:applelogin2];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:requestData];
	responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&resp error:&err];
	responseStr = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
	responseArr = [responseStr componentsSeparatedByString:@"\n"];
	resStr = [responseArr objectAtIndex:0];
	authArr = [resStr componentsSeparatedByString:@"="];
	res = [authArr objectAtIndex:1];
	[[NSUserDefaults standardUserDefaults] setObject:res forKey:@"YTAUTHTOKEN"];
	return res;
}
@end
