//
//  code.c
//  nativelibrary
//
//  Created by Matthew Leibowitz on 2019/07/10.
//  Copyright © 2019 Matthew Leibowitz. All rights reserved.
//

#include "code.h"

int add(int a, int b, adder_proc adder)
{
    return adder(a, b);
}
