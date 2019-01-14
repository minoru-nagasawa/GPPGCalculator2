// ---------------------------
// �錾��
// ---------------------------

// �o�͂���N���X��namespace
%namespace GPPGCalculator2

// ��������N���X��partial�N���X�ɂȂ�
// �������邱�ƂŁA����������*.y�ł͂Ȃ��A*.cs�ɏ�����悤�ɂȂ�̂ŕ֗�
%partial

// �o�͂���N���X��
%parsertype CalculatorParser

// �o�͂���N���X�̃A�N�Z�V�r���e�B
%visibility internal

// �g�[�N���Ɏg�p����enum�̌^��
%tokentype Token

%union { 
    public double real;
    public string text;
}

%token <text> VARIABLE
%token <real> CONSTANT

%start main


%%
// ---------------------------
// ���[����
// ---------------------------

main            : assignment                    { m_result = $1.real; }
                ;

assignment      : additive                      { $$.real = $1.real; }
                | VARIABLE '=' assignment       {
                                                    m_variables[$1] = $3.real;
                                                    $$.real = $3.real;
                                                }
                ;

additive        : multiplicative                { $$.real = $1.real;           }
                | additive '+' multiplicative   { $$.real = $1.real + $3.real; }
                | additive '-' multiplicative   { $$.real = $1.real - $3.real; }
                ;

multiplicative  : primary                       { $$.real = $1.real;            }
                | multiplicative '*' primary    { $$.real = $1.real * $3.real;  }
                | multiplicative '/' primary    { $$.real = $1.real / $3.real;  }
                ; 

primary         : VARIABLE                      {
                                                    double v;
                                                    if (m_variables.TryGetValue($1, out v))
                                                    {
                                                        $$.real = v;
                                                    }
                                                    else
                                                    {
                                                        $$.real = 0;
                                                    }
                                                }
                | CONSTANT                      { $$.real = $1; }
                | '(' additive ')'              { $$.real = $2.real; }
                ;


%%
// ---------------------------
// �R�[�h��
// ---------------------------
