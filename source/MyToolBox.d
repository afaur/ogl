module MyToolBox;

import std.stdio;             // writeln()
import std.process;           // executeShell()
import std.traits;            // isDynamicArray!()
import std.conv;

void myLog(alias symbol)()
{
    string equalSign = " = ";
    string preamble = __traits(identifier, symbol) ~ equalSign;
    writeln(preamble, symbol);
    // writeln(symbol.stringof ~ equalSign, symbol);  // .stringof is considered unsafe - used __traits
}


// "There is a special type of array which acts as a wildcard that can hold arrays of any kind,
// declared as void[].  The .length of a void array is the length of the data in bytes,
// rather than the number of elements in its original type.
//
// The .sizeof	Returns the size of the dynamic array reference, which is 8 in 32-bit builds
// and 16 on 64-bit builds.
//
// This template function does not all fixed arrays because staticArray.sizeof returns the array
// length multiplied by the number of bytes per array element.
//
// Used ubyte[] because the garbage collector generally will not scan ubyte[] arrays for pointers
//
// void[] arr = someArray;   // int[] implicitly converts to void[].

int arrayByteSize(T)(T someArray) if (isDynamicArray!(T))
{
    ubyte[] arr = cast(ubyte[]) someArray;
    return to!int(arr.length);
}

void writeAndPause(string s)
{
    writeln(s);
    writeln("--- Press any key to continue ---");
    executeShell("pause");
}

