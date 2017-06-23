#include "elena.h"
// --------------------------------------------------------------------------
#include "win32_common.h"
#include "directx12.h"

using namespace _ELENA_;

//using Microsoft::WRL::ComPtr;

#define EXTERN_DLL_EXPORT extern "C" __declspec(dllexport)

Path			rootPath;
D12Platform*	d12Platform = NULL;

//// global declarations
//IDXGISwapChain1*	swapchain;             // the pointer to the swap chain interface
//ID3D12Device*		devD12;                     // the pointer to our Direct3D device interface
//ID3D12CommandQueue*	commandQueue;
////ID3D11Device* dev;
////ID3D11DeviceContext *devcon;           // the pointer to our Direct3D device context

void loadDLLPath(HMODULE hModule, Path& rootPath)
{
	TCHAR path[MAX_PATH + 1];

	::GetModuleFileName(hModule, path, MAX_PATH);

	rootPath.copySubPath(path);
	rootPath.lower();
}

// === dll entries ===

/// sets up and initializes Direct3D
EXTERN_DLL_EXPORT int InitD3D(HWND hWnd)
{
	try
	{
		RECT rect;
		GetWindowRect(hWnd, &rect);

		d12Platform = new D12Platform(rootPath.c_str(), rect.right - rect.left, rect.bottom - rect.top);

		d12Platform->Init(hWnd, 1);

		return -1;
	}
	catch (...)
	{
		return 0;
	}
}

EXTERN_DLL_EXPORT void Render3D(HWND hWnd)
{
	d12Platform->OnRender();
}

/// closes Direct3D and releases memory
EXTERN_DLL_EXPORT void CleanD3D(HWND hWnd)
{
	d12Platform->OnDestroy();

	delete d12Platform;

	d12Platform = nullptr;
}

// --- dllmain ---

extern "C"

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
               )
{
   switch (ul_reason_for_call)
   {
	   case DLL_PROCESS_ATTACH:
		  loadDLLPath(hModule, rootPath);
		  return TRUE;
	   case DLL_PROCESS_DETACH:
		  freeobj(d12Platform);
		  break;
   }
   return TRUE;
}