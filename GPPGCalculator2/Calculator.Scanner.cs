using System;
using System.Collections.Generic;
using System.Text;

namespace GPPGCalculator2
{
    internal partial class CalculatorScanner
    {
        public override void yyerror(string format, params object[] args)
        {
            base.yyerror(format, args);
            Console.WriteLine(format, args);
            Console.WriteLine();
        }
    }
}
