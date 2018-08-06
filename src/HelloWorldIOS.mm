
#import "Hvr/Codec/HelloWorldIOS.h"
#include "Hvr/Codec/HelloWorld.hpp"

@implementation HelloWorldIOS

HelloWorld _h;

- (NSString *)getHelloWorld
{
  NSString *text = [NSString stringWithUTF8String:_h.helloWorld().c_str()];
  return text;
}

@end
