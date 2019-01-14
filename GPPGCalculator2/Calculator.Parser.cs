using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace GPPGCalculator2
{
    internal partial class CalculatorParser
    {
        // Parse�������ʂ��i�[�����B
        // �i�[���鏈���́ACalculator.Language.grammer.y�̒��ɋL�q���Ă���B
        private double m_result;

        // �ϐ����i�[���邽�߂̃f�B�N�V���i��
        // Key���ϐ����AValue���i�[���Ă���l
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
