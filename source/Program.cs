using System;
using System.Runtime.InteropServices;

namespace managedapp
{
	class Program
	{
		private static bool shouldThrow;

		static void Main(string[] args)
		{
			int a = 2;
			int b = 4;

			shouldThrow = false;

			int result = add(a, b, AddImplementation);
			Console.WriteLine($"{a} + {b} = {result}");

			shouldThrow = true;

			try
			{
				result = add(a, b, AddImplementation);
				Console.WriteLine($"{a} + {b} = {result}");
			}
			catch (Exception ex)
			{
				Console.WriteLine($"{a} + {b} = {ex.Message}");
			}

			shouldThrow = false;

			result = add(a, b, AddImplementation);
			Console.WriteLine($"{a} + {b} = {result}");
		}

		public delegate int adder_proc(int a, int b);

		[DllImport("libnativelibrary")]
		public static extern int add(int a, int b, adder_proc adder);

		public static int AddImplementation(int a, int b)
		{
			if (shouldThrow)
				throw new Exception("You asked for an exception, here it is.");

			return a + b;
		}
	}
}
