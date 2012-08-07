#import <Cocoa/Cocoa.h>

#define EnumDecl(class, name) + (class*) name;
#define EnumImpl(class, name) + (class*) _enum__##name {return nil;} + (class*) name {return nil;}

@interface Enum : NSObject <NSCoding>

@property (readonly) NSString* name;

// The ordering enum items are returned in is undefined.
+ (NSArray*) allEnumItems;

@end