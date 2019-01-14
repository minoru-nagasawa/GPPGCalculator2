using System;

namespace GPPGCalculator2
{
    class Program
    {
        static void Main(string[] args)
        {
            // 作った電卓のParserを生成
            // 字句解析器も、この中で生成されている
            var parser = new CalculatorParser();

            do
            {
                // 式を入力。空文字なら終了。
                Console.Write("> ");
                var input = Console.ReadLine();
                if (string.IsNullOrEmpty(input))
                {
                    return;
                }

                // 式を解析して結果を出力
                double result;
                bool rc = parser.Parse(input, out result);
                if (rc)
                {
                    Console.WriteLine(result.ToString());
                }
            } while (true);
        }
    }
}
