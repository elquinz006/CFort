#include <iostream>
#include <windows.h>
#include <processthreadsapi.h>
#include "comm.h"
#include "TASS1D.h"

#pragma comment(lib,"FortranDLL.lib")
//#pragma comment(lib, "TASS1D.lib")

extern "C" __declspec(dllimport) void TASS(double*, double*);
extern "C" __declspec(dllimport) void SIMULATION(long alpha, double *beta, long *gamma, double delta[], struct pass *arrays);
extern "C" __declspec(dllimport) int C_Library_Function(void* sendbuf, int sendcount, int *recvcounts);
//extern "C" __declspec(dllimport) void __cdecl TASS1D(T1DCTRL_t*, char* ic_file, char* bt_file);

uintptr_t GetModuleBaseAddress(DWORD procId, const wchar_t* modName);

int* ptr;
int tgt;

#define dZero = 0.0

long alpha;
double beta;
long gamma;
double delta[1];
pass arrays;

COMINT *ComC;
T1DCTRL_t *pT1DCTRL;
T1DCTRL_t T1DCTRL;

int main()
{
    DWORD ProdId = GetCurrentProcessId();
    //GetPid(L"FortranDll.dll", &ProdId);
    //char* ExeBaseAddress = GetModuleBase(L"FortranDll.dll", ProdId);
    uintptr_t ModBaseAddr = GetModuleBaseAddress(ProdId, L"FortranDll.dll");
    //uintptr_t TASS1DAdr = GetModuleBaseAddress(ProdId, L"TASS1D.dll");

    T1DCTRL.st_dt = 0.01;
    pT1DCTRL = &T1DCTRL;
    char ic_file = '\\';
    char bt_file = '\\';
    //TASS1D(&T1DCTRL, &ic_file, &bt_file);

    tgt = 101;
    ptr = &tgt;

    int i;

    int test = 0x12345678;

    char* ptr = (char*)&test; // 1 바이트만을 가리키는 포인터를 생성함.

    for (i = 0; i < sizeof(int); i++)

    {
        printf("%x", ptr[i]); // 1 바이트씩 순서대로 그 값을 출력함.
    }

    //double cx, cy;
    double cx{ 5 };
    double cy{ 6 };
    //double *ptx, *pty;

    double* ptx{ &cx };
    double* pty{ &cy };

    std::cout << *(int*)ptr << std::endl;
    TASS(*&ptx, *&pty);

    std::cout << *(double*)(ModBaseAddr + 0x000074a0) << std::endl;
    ComC = (COMINT*)(ModBaseAddr + 0x000074a0);
    ComC->ix = 1234.;
    //std::cout << *(double*)(ModBaseAddr + 0x000074a0) << std::endl;

    TASS(*&ptx, *&pty);

    SIMULATION(alpha, &beta, &gamma, delta, &arrays);

    for (int i = 0; i < 100; i++)
    {
        std::cout << *(arrays.f + i) << std::endl;
    }

    *(arrays.f) = 100.0;
    //TASS();
    SIMULATION(alpha, &beta, &gamma, delta, &arrays);

    //printf("End of main.\n");

    return 0;
}