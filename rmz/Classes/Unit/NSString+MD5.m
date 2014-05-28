
/*
 * MD5_NSString.m
 *
 * Copyright (c) 2012, Pétur Ingi Egilsson <petur@petur.eu>.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5String)
- (NSString *)md5 {
    
    NSString *md5string = [NSString string];
    const char *cStr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)[self length], buffer);
    
    int i;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        md5string = [md5string stringByAppendingString:[NSString stringWithFormat:@"%02x", buffer[i]]];
    
    return md5string;
}
@end