using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace GPPGCalculator2
{
    internal partial class CalculatorParser
    {
        // Parseした結果が格納される。
        // 格納する処理は、Calculator.Language.grammer.yの中に記述している。
        private double m_result;

        // 変数を格納するためのディクショナリ
        // Keyが変数名、Valueが格納している値
        private Dictionary<string, double> m_variables = new Dictionary<string, double>();

        public CalculatorParser() : base(null) { }

        public bool Parse(string s, out double result)
        {
            result = 0;

            byte[] inputBuffer = System.Text.Encoding.Default.GetBytes(s);
            using (var stream = new MemoryStream(inputBuffer))
            {
                this.Scanner = new CalculatorScanner(stream);
                bool rc = this.Parse();
                if (rc)
                {
                    result = m_result;
                }
                return rc;
            }
        }
    }
}
