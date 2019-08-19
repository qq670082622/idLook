//
//  Public.m
//  Alicall
//
//  Created by Fire on 23/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Public.h"
#import <CommonCrypto/CommonDigest.h>
#include <netinet/in.h>
#import <arpa/inet.h>
#import <sys/types.h>
#import <sys/socket.h>
#include <sys/socket.h> 
#include <sys/sysctl.h>
#include <ifaddrs.h>
#import <netdb.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CFNetwork/CFNetwork.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "UserInfoManager.h"
#import "GTMBase64.h"
#import "DeviceHardwareInfo.h"
#include <math.h>

typedef unsigned char BYTE;
typedef BYTE * LPBYTE;

NSString * GetHostAddress(const char * hostName)
{
	struct hostent *host_entry;
	
	NSString * strIp=nil;
	
	BOOL isIpAddress=TRUE;
	long l = strlen(hostName);
	
	for ( int i=0; i<l; i++ )
	{
		if(hostName[i]!='.' && (hostName[i]<'0' || hostName[i]>'9') )
		{
			isIpAddress = FALSE;
		}
	}
	
	if(isIpAddress)
	{
		strIp = [[NSString alloc] initWithUTF8String: hostName];
	}
	else
	{
		host_entry=gethostbyname(hostName);
		
		if(host_entry!=0)
		{
			
			strIp = [[NSString alloc] initWithFormat:@"%d.%d.%d.%d",
					  (host_entry->h_addr_list[0][0]&0x00ff),
					  (host_entry->h_addr_list[0][1]&0x00ff),
					  (host_entry->h_addr_list[0][2]&0x00ff),
					  (host_entry->h_addr_list[0][3]&0x00ff)];
		}
		else {
			strIp = [[NSString alloc] initWithUTF8String: "0.0.0.0"];
		}
		
		return strIp;
	}
	return strIp;
}

NSString *TrimPhoneNumber(NSString *number)
{
	if(number==nil || [number length]==0)
    {
		return @"";
    }
    number=[number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    number=[number stringByReplacingOccurrencesOfString:@"+" withString:@""];
    number=[number stringByReplacingOccurrencesOfString:@"(" withString:@""];
    number=[number stringByReplacingOccurrencesOfString:@")" withString:@""];
    number=[number stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	if([number length]>4 && [[number substringWithRange:NSMakeRange(0,4)] isEqualToString:@"0086"])
	{
		number = [number substringFromIndex:4];
	}
	
	if([number length]>2 && [[number substringWithRange:NSMakeRange(0,2)] isEqualToString:@"86"])
	{
		number = [number substringFromIndex:2];
	}
	return number;
}

NSString * MD5Str(NSString *input)
{
    const char *cStr = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

NSString * GetLocalAddress()
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    if ([address isEqualToString:@"error"]) {
        return @"";
    }
    return address;
}

NSObject *  safeObjectForKey(NSObject *dic, id key)
{
    NSObject * retval=nil;
    
    if( dic!=nil && [dic isKindOfClass:[NSDictionary class]])
    {
        retval= [((NSDictionary *)dic) objectForKey:key];
        if(retval!=nil && [retval isKindOfClass:[NSNull class]])
            return nil;
    }
    return retval;
}


/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
BOOL IsBankCardNumber (NSString *cardNumber)
{
    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    
    // 循环加和
    for (NSInteger i = 1; i <= cardNumber.length; i++)
    {
        NSString *theNumber = [cardNumber substringWithRange:NSMakeRange(cardNumber.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i%2 == 0)
        {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9)
            {
                lastNumber -=9;
            }
            evenSum += lastNumber;
        }
        else
        {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum%10 == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


long GetCurrentTimeMillis()
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1000+tv.tv_usec/1000;
}

unsigned long long GetFileSize(NSString * localFile)
{
    NSFileManager *fm  = [NSFileManager defaultManager];
    // 取文件大小
    NSError *error = nil;
    NSDictionary* dictFile = [fm attributesOfItemAtPath:localFile error:&error];
    if (error)
    {
        return NO;
    }
    unsigned long long nFileSize = [dictFile fileSize]; //得到文件大小
    return nFileSize;
}

long GetDaysFromTwoDates(NSDate* lastDate ,NSDate* today) {
    NSDate *startDate = lastDate;
    NSDate *endDate = today;
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:startDate
                                                  toDate:endDate options:0];
    long days = [components day];
    return days;
}

//获取工程跟目录
NSString * applicationDocumentsDirectory()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

BOOL IsFileExist(NSString * filename)
{
	//创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    //参数NSDocumentDirectory要获取那种路径
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    NSString *documentsDirectory = applicationDocumentsDirectory();
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
	return [fileManager fileExistsAtPath:path];
}


BOOL IsCorrectPhoneNumber(NSString *number)
{
    NSInteger l = [number length];
    const char * pStr = [number UTF8String];
    BOOL bMobile = NO;
    
    if([number isEqualToString:@"8001"] || [number isEqualToString:@"8002"])
        return YES;
    
    if(l<6 || l>20)
        return FALSE;
    
    if(l==11)
    {
        if(pStr[0]=='1')
        {
            //手机号码
            if(pStr[1]!='3' && pStr[1]!='4' && pStr[1]!='5' && pStr[1]!='7' && pStr[1]!='8' && pStr[1]!='6' && pStr[1]!='9' )
                return FALSE;
            else
                bMobile = TRUE;
        }
        else
        {
            return false;
        }
    }
    
    if(pStr[0]=='1'  && l!=11)
    {
        return FALSE;
    }
    
    if(bMobile==FALSE)
    {
        char temp[4]={0};
        
        strncpy(temp,[number UTF8String],3);
        if(strcmp(temp,"00000")==0 ||
           strcmp(temp,"99999")==0 ||
           strcmp(temp,"66666")==0 ||
           strcmp(temp,"88888")==0 )
            return FALSE;
    }
    
    for ( int idx=1; idx<l; idx++ )
    {
        if(pStr[idx]<'0' || pStr[idx]>'9' )
            return FALSE;
    }
    return TRUE;
}

BOOL IsCorrectFixedTelephoneNumber(NSString *number)
{
    NSString * FT = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", FT];
    
    return [regextestcm evaluateWithObject:number];
}

BYTE toHex( BYTE x)
{
	return x > 9 ? x + 55: x + 48;
}

NSString * UrlDecode (NSString * str)
{
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

NSString *  UrlEncode(const char * strIn)
{
	NSString * strRet=@"";
	char * strOut;
	
    if (strIn==nil)
    {
        return strRet;
    }
    
	const size_t nLen = strlen(strIn) + 1;
	
	register LPBYTE pOutTmp = NULL;
	
	LPBYTE pOutBuf = NULL;
	
	register LPBYTE pInTmp = NULL;
	
	LPBYTE pInBuf =(LPBYTE)strIn;
	
	strOut = (char *)malloc(nLen*3);
	
	pOutBuf = (LPBYTE)strOut;
	
	if(pOutBuf)
	{
		pInTmp   = pInBuf;
		pOutTmp  = pOutBuf;
		while (*pInTmp)
		{
			if(isalnum(*pInTmp))
				*pOutTmp++ = *pInTmp;
			
			else
				if(isspace(*pInTmp))
					*pOutTmp++ = '+';
				else
				{
					*pOutTmp++ = '%';
					*pOutTmp++ = toHex(*pInTmp>>4);
					*pOutTmp++ = toHex(*pInTmp%16);
				}
			
			pInTmp++;
		}
		
		*pOutTmp = '\0';
        strRet = [NSString stringWithUTF8String:strOut];
		free(strOut);
	}
	return strRet;
}

BOOL IsWIFIConnection(void)
{
    BOOL ret = YES;
    struct ifaddrs * first_ifaddr, * current_ifaddr;
    NSMutableArray* activeInterfaceNames = [NSMutableArray array];
    getifaddrs( &first_ifaddr );
    current_ifaddr = first_ifaddr;
    while( current_ifaddr!=NULL )
    {
        if( current_ifaddr->ifa_addr->sa_family==AF_INET )
        {
            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s", current_ifaddr->ifa_name]];
        }
        current_ifaddr = current_ifaddr->ifa_next;
    }
    ret = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
    return ret;
}

NSString * GetParamValue(const NSString * sSourceString, NSString * sParam)
{
	NSMutableString * value = [[NSMutableString alloc] initWithString: @""];
	
	@try
	{
		NSRange iStart  = [sSourceString rangeOfString :sParam];
		if(iStart.length>0)
		{
			NSString * sSubString = [sSourceString substringFromIndex:iStart.location+iStart.length];
			NSRange iEnd    = [sSubString rangeOfString :@"\r\n" ];
            
            if(iEnd.location!=NSNotFound && iEnd.length>0)
            {
                [value appendString:[sSubString substringToIndex:iEnd.location ]];
            
                NSString *trimmedString = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                return trimmedString;
            }
		}
	}
	@catch( NSException * ex)
	{
    }
    
	return value;
}


NSString * GetSectionValue(const NSString * sSourceString, const NSString * sStartTagValue, const NSString * sEndTagValue, int nStartPos, int * nNextPos)
{
    NSString * findString = [sSourceString substringFromIndex:nStartPos];
    NSString * subString = [[NSString alloc] initWithString: @""];
    
    *nNextPos=-1;
    
    @try
    {
        NSRange iStart  = [findString rangeOfString :sStartTagValue];
        iStart.location += sStartTagValue.length;
        if(iStart.length>0)
        {
            NSRange iEnd    = [findString rangeOfString :sEndTagValue ];
            
            if(iEnd.location!=NSNotFound)
            {
                while(1)
                {
                    NSRange r = iEnd;
                    r.location++;
                    if((r.location+r.length)<=[findString length])
                    {
                        NSString * s = [findString substringWithRange:r];
                        if([s isEqualToString:sEndTagValue])
                        {
                            iEnd=r;
                        }
                        else
                        {
                            break;
                        }
                    }
                    else
                    {
                        break;
                    }
                }
            }
            int iLength     = iEnd.location - iStart.location;
            if(iLength>=0) {
                subString       = [findString substringWithRange: NSMakeRange( iStart.location, iLength ) ];
                *nNextPos = iEnd.location+sEndTagValue.length+nStartPos;
            }
        }
    }
    @catch( NSException * ex)
    {}
    return subString;
}



#if 1


const UInt8 kBase64EncodeTable[64] = {
    /*  0 */ 'A',	/*  1 */ 'B',	/*  2 */ 'C',	/*  3 */ 'D',
    /*  4 */ 'E',	/*  5 */ 'F',	/*  6 */ 'G',	/*  7 */ 'H',
    /*  8 */ 'I',	/*  9 */ 'J',	/* 10 */ 'K',	/* 11 */ 'L',
    /* 12 */ 'M',	/* 13 */ 'N',	/* 14 */ 'O',	/* 15 */ 'P',
    /* 16 */ 'Q',	/* 17 */ 'R',	/* 18 */ 'S',	/* 19 */ 'T',
    /* 20 */ 'U',	/* 21 */ 'V',	/* 22 */ 'W',	/* 23 */ 'X',
    /* 24 */ 'Y',	/* 25 */ 'Z',	/* 26 */ 'a',	/* 27 */ 'b',
    /* 28 */ 'c',	/* 29 */ 'd',	/* 30 */ 'e',	/* 31 */ 'f',
    /* 32 */ 'g',	/* 33 */ 'h',	/* 34 */ 'i',	/* 35 */ 'j',
    /* 36 */ 'k',	/* 37 */ 'l',	/* 38 */ 'm',	/* 39 */ 'n',
    /* 40 */ 'o',	/* 41 */ 'p',	/* 42 */ 'q',	/* 43 */ 'r',
    /* 44 */ 's',	/* 45 */ 't',	/* 46 */ 'u',	/* 47 */ 'v',
    /* 48 */ 'w',	/* 49 */ 'x',	/* 50 */ 'y',	/* 51 */ 'z',
    /* 52 */ '0',	/* 53 */ '1',	/* 54 */ '2',	/* 55 */ '3',
    /* 56 */ '4',	/* 57 */ '5',	/* 58 */ '6',	/* 59 */ '7',
    /* 60 */ '8',	/* 61 */ '9',	/* 62 */ '+',	/* 63 */ '/'
};

/*
 -1 = Base64 end of data marker.
 -2 = White space (tabs, cr, lf, space)
 -3 = Noise (all non whitespace, non-base64 characters)
 -4 = Dangerous noise
 -5 = Illegal noise (null byte)
 */

const SInt8 kBase64DecodeTable[128] = {
    /* 0x00 */ -5, 	/* 0x01 */ -3, 	/* 0x02 */ -3, 	/* 0x03 */ -3,
    /* 0x04 */ -3, 	/* 0x05 */ -3, 	/* 0x06 */ -3, 	/* 0x07 */ -3,
    /* 0x08 */ -3, 	/* 0x09 */ -2, 	/* 0x0a */ -2, 	/* 0x0b */ -2,
    /* 0x0c */ -2, 	/* 0x0d */ -2, 	/* 0x0e */ -3, 	/* 0x0f */ -3,
    /* 0x10 */ -3, 	/* 0x11 */ -3, 	/* 0x12 */ -3, 	/* 0x13 */ -3,
    /* 0x14 */ -3, 	/* 0x15 */ -3, 	/* 0x16 */ -3, 	/* 0x17 */ -3,
    /* 0x18 */ -3, 	/* 0x19 */ -3, 	/* 0x1a */ -3, 	/* 0x1b */ -3,
    /* 0x1c */ -3, 	/* 0x1d */ -3, 	/* 0x1e */ -3, 	/* 0x1f */ -3,
    /* ' ' */ -2,	/* '!' */ -3,	/* '"' */ -3,	/* '#' */ -3,
    /* '$' */ -3,	/* '%' */ -3,	/* '&' */ -3,	/* ''' */ -3,
    /* '(' */ -3,	/* ')' */ -3,	/* '*' */ -3,	/* '+' */ 62,
    /* ',' */ -3,	/* '-' */ -3,	/* '.' */ -3,	/* '/' */ 63,
    /* '0' */ 52,	/* '1' */ 53,	/* '2' */ 54,	/* '3' */ 55,
    /* '4' */ 56,	/* '5' */ 57,	/* '6' */ 58,	/* '7' */ 59,
    /* '8' */ 60,	/* '9' */ 61,	/* ':' */ -3,	/* ';' */ -3,
    /* '<' */ -3,	/* '=' */ -1,	/* '>' */ -3,	/* '?' */ -3,
    /* '@' */ -3,	/* 'A' */ 0,	/* 'B' */  1,	/* 'C' */  2,
    /* 'D' */  3,	/* 'E' */  4,	/* 'F' */  5,	/* 'G' */  6,
    /* 'H' */  7,	/* 'I' */  8,	/* 'J' */  9,	/* 'K' */ 10,
    /* 'L' */ 11,	/* 'M' */ 12,	/* 'N' */ 13,	/* 'O' */ 14,
    /* 'P' */ 15,	/* 'Q' */ 16,	/* 'R' */ 17,	/* 'S' */ 18,
    /* 'T' */ 19,	/* 'U' */ 20,	/* 'V' */ 21,	/* 'W' */ 22,
    /* 'X' */ 23,	/* 'Y' */ 24,	/* 'Z' */ 25,	/* '[' */ -3,
    /* '\' */ -3,	/* ']' */ -3,	/* '^' */ -3,	/* '_' */ -3,
    /* '`' */ -3,	/* 'a' */ 26,	/* 'b' */ 27,	/* 'c' */ 28,
    /* 'd' */ 29,	/* 'e' */ 30,	/* 'f' */ 31,	/* 'g' */ 32,
    /* 'h' */ 33,	/* 'i' */ 34,	/* 'j' */ 35,	/* 'k' */ 36,
    /* 'l' */ 37,	/* 'm' */ 38,	/* 'n' */ 39,	/* 'o' */ 40,
    /* 'p' */ 41,	/* 'q' */ 42,	/* 'r' */ 43,	/* 's' */ 44,
    /* 't' */ 45,	/* 'u' */ 46,	/* 'v' */ 47,	/* 'w' */ 48,
    /* 'x' */ 49,	/* 'y' */ 50,	/* 'z' */ 51,	/* '{' */ -3,
    /* '|' */ -3,	/* '}' */ -3,	/* '~' */ -3,	/* 0x7f */ -3
};

const UInt8 kBits_00000011 = 0x03;
const UInt8 kBits_00001111 = 0x0F;
const UInt8 kBits_00110000 = 0x30;
const UInt8 kBits_00111100 = 0x3C;
const UInt8 kBits_00111111 = 0x3F;
const UInt8 kBits_11000000 = 0xC0;
const UInt8 kBits_11110000 = 0xF0;
const UInt8 kBits_11111100 = 0xFC;

size_t EstimateBas64EncodedDataSize(size_t inDataSize)
{
    size_t theEncodedDataSize = (int)ceil(inDataSize / 3.0) * 4;
    theEncodedDataSize = theEncodedDataSize / 72 * 74 + theEncodedDataSize % 72;
    return(theEncodedDataSize);
}

size_t EstimateBas64DecodedDataSize(size_t inDataSize)
{
    size_t theDecodedDataSize = (int)ceil(inDataSize / 4.0) * 3;
    //theDecodedDataSize = theDecodedDataSize / 72 * 74 + theDecodedDataSize % 72;
    return(theDecodedDataSize);
}

bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize)
{
    BOOL wrapped=NO;
    size_t theEncodedDataSize = EstimateBas64EncodedDataSize(inInputDataSize);
    if (*ioOutputDataSize < theEncodedDataSize)
        return(false);
    *ioOutputDataSize = theEncodedDataSize;
    const UInt8 *theInPtr = (const UInt8 *)inInputData;
    UInt32 theInIndex = 0, theOutIndex = 0;
    for (; theInIndex < (inInputDataSize / 3) * 3; theInIndex += 3)
    {
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_11111100) >> 2];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_00000011) << 4 | (theInPtr[theInIndex + 1] & kBits_11110000) >> 4];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex + 1] & kBits_00001111) << 2 | (theInPtr[theInIndex + 2] & kBits_11000000) >> 6];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex + 2] & kBits_00111111) >> 0];
        if (wrapped && (theOutIndex % 74 == 72))
        {
            outOutputData[theOutIndex++] = '\r';
            outOutputData[theOutIndex++] = '\n';
        }
    }
    const size_t theRemainingBytes = inInputDataSize - theInIndex;
    if (theRemainingBytes == 1)
    {
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_11111100) >> 2];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_00000011) << 4 | (0 & kBits_11110000) >> 4];
        outOutputData[theOutIndex++] = '=';
        outOutputData[theOutIndex++] = '=';
        if (wrapped && (theOutIndex % 74 == 72))
        {
            outOutputData[theOutIndex++] = '\r';
            outOutputData[theOutIndex++] = '\n';
        }
    }
    else if (theRemainingBytes == 2)
    {
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_11111100) >> 2];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex] & kBits_00000011) << 4 | (theInPtr[theInIndex + 1] & kBits_11110000) >> 4];
        outOutputData[theOutIndex++] = kBase64EncodeTable[(theInPtr[theInIndex + 1] & kBits_00001111) << 2 | (0 & kBits_11000000) >> 6];
        outOutputData[theOutIndex++] = '=';
        if (wrapped && (theOutIndex % 74 == 72))
        {
            outOutputData[theOutIndex++] = '\r';
            outOutputData[theOutIndex++] = '\n';
        }
    }
    return(true);
}

bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize)
{
    memset(ioOutputData, '.', *ioOutputDataSize);
    
    size_t theDecodedDataSize = EstimateBas64DecodedDataSize(inInputDataSize);
    if (*ioOutputDataSize < theDecodedDataSize)
        return(false);
    *ioOutputDataSize = 0;
    const UInt8 *theInPtr = (const UInt8 *)inInputData;
    UInt8 *theOutPtr = (UInt8 *)ioOutputData;
    size_t theInIndex = 0, theOutIndex = 0;
    UInt8 theOutputOctet = '\0';
    size_t theSequence = 0;
    for (; theInIndex < inInputDataSize; )
    {
        SInt8 theSextet = 0;
        
        SInt8 theCurrentInputOctet = theInPtr[theInIndex];
        theSextet = kBase64DecodeTable[theCurrentInputOctet];
        if (theSextet == -1)
            break;
        while (theSextet == -2)
        {
            theCurrentInputOctet = theInPtr[++theInIndex];
            theSextet = kBase64DecodeTable[theCurrentInputOctet];
        }
        while (theSextet == -3)
        {
            theCurrentInputOctet = theInPtr[++theInIndex];
            theSextet = kBase64DecodeTable[theCurrentInputOctet];
        }
        if (theSequence == 0)
        {
            theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 2 & kBits_11111100;
        }
        else if (theSequence == 1)
        {
            theOutputOctet |= (theSextet >- 0 ? theSextet : 0) >> 4 & kBits_00000011;
            theOutPtr[theOutIndex++] = theOutputOctet;
        }
        else if (theSequence == 2)
        {
            theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 4 & kBits_11110000;
        }
        else if (theSequence == 3)
        {
            theOutputOctet |= (theSextet >= 0 ? theSextet : 0) >> 2 & kBits_00001111;
            theOutPtr[theOutIndex++] = theOutputOctet;
        }
        else if (theSequence == 4)
        {
            theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 6 & kBits_11000000;
        }
        else if (theSequence == 5)
        {
            theOutputOctet |= (theSextet >= 0 ? theSextet : 0) >> 0 & kBits_00111111;
            theOutPtr[theOutIndex++] = theOutputOctet;
        }
        theSequence = (theSequence + 1) % 6;
        if (theSequence != 2 && theSequence != 4)
            theInIndex++;
    }
    *ioOutputDataSize = theOutIndex;
    
    return(true);
}
#endif


BOOL IsBoldSize()   //是否粗体文本
{
    if ([[UIFont systemFontOfSize:12].fontName isEqualToString:@".SFUIText-Semibold"]) {
        return YES;
    }
    return NO;
}
