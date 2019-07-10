//
//  code.h
//  nativelibrary
//
//  Created by Matthew Leibowitz on 2019/07/10.
//  Copyright © 2019 Matthew Leibowitz. All rights reserved.
//

#ifndef code_h
#define code_h

#if defined(_WIN32)
#  define EXPORT_API __declspec(dllexport)
#else
#  define EXPORT_API __attribute__((visibility("default")))
#endif

typedef int (*adder_proc)(int a, int b);

EXPORT_API int add(int a, int b, adder_proc adder);

#endif /* code_h */
