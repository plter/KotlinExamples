#include <iostream>
#include "Hi.h"

extern "C" void sayHello(){
    Hi h;
    h.sayHi();

    std::cout<<"Hello from c++\n";
}