//---------------------------------------------------------------------------
//		E L E N A   P r o j e c t:  ELENA RT Engine
//
//                                              (C)2009-2015, by Alexei Rakov
//---------------------------------------------------------------------------

#include "elena.h"
// --------------------------------------------------------------------------
#include "instance.h"
#include "rtman.h"
#include "config.h"

#define PROJECT_CATEGORY            "project"
#define LIBRARY_PATH                "libpath"

using namespace _ELENA_;

// --- Instance::ImageSection ---

void* Instance::ImageSection :: get(size_t position) const
{
   return (unsigned char*)_section + position;
}

bool Instance::ImageSection :: read(size_t position, void* s, size_t length)
{
   if (position < _length && _length >= position + length) {
      memcpy(s, (unsigned char*)_section + position, length);

      return true;
   }
   else return false;
}

// --- Instance ---

Instance :: Instance()
{
}

bool Instance :: loadConfig()
{
   IniConfigFile config;
   if (!config.load(_T("elc.cfg"), feUTF8)) {
      return false;
   }

   Path path(config.getSetting(PROJECT_CATEGORY, LIBRARY_PATH, NULL));
   if (!emptystr(path)) {
      _loader.setRootPath(path);
   }

   return true;
}

void Instance :: init(void* debugSection, const wchar16_t* package)
{
   _debugSection.init(debugSection);

   loadConfig();
   _loader.setPackage(package);
}

int Instance :: readCallStack(size_t framePosition, size_t currentAddress, size_t startLevel, int* buffer, size_t maxLength)
{
   RTManager manager;

   ImageSection image;
   MemoryReader reader(&image);

   return manager.readCallStack(reader, framePosition, currentAddress, startLevel, buffer, maxLength);
}

int Instance :: loadAddressInfo(size_t retPoint, wchar16_t* buffer, size_t maxLength)
{
   RTManager manager;
   MemoryReader reader(&_debugSection, 4);

   return manager.readAddressInfo(reader, retPoint, &_loader, buffer, maxLength);
}