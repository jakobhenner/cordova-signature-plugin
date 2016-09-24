//
//  CDVApiSignature.m
//  ApiSignatureTest
//
//  Created by Dmitriy Devayev on 12/11/14.
//  Modified by Jakob Henner to implement proper sha256 hashing
//
//

#import "CDVApiSignature.h"
#import <Cordova/CDV.h>

#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation CDVApiSignature

NSString *secretKey = @"SECRET";

- (void)createApiSignature:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* message = [command.arguments objectAtIndex:0];
    NSString* hmac = [command.arguments objectAtIndex:1];
    
    if (message != nil && [message length] > 0) {
        if ([hmac isEqualToString:@"sha-256"]){
            message = [self sha256: message];
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(NSString *) sha256 :(NSString *) data {
    const char *cKey  = [secretKey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    return hash;
}

@end
