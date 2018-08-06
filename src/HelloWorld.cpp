

#include "Hvr/Codec/HelloWorld.hpp"
extern "C"
{
#include "libavcodec/avcodec.h"
}

std::string HelloWorld::helloWorld()
{
  AVCodecContext* ctx;
  avcodec_close(ctx);
  return std::string("Hello World");
}
