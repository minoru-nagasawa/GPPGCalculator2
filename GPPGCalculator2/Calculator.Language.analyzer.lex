// ---------------------------
// ��`��
// ---------------------------

// �o�͂���N���X��namespace
%namespace GPPGCalculator2

// �o�͂���N���X��
%scannertype CalculatorScanner

// �o�͂���N���X�̃A�N�Z�V�r���e�B
%visibility internal

// �g�[�N���Ɏg�p����enum�̌^��
%tokentype Token

// �I�v�V����
// stack          : �����t����ƁA��Ԃ��X�^�b�N�ɕۑ��ł���悤�ɂȂ�B
//                  C����̃R�����g(/*  */)�̉��߂̂悤�ɁA��Ԃ��Ǘ��������ꍇ�Ɏg�p����B
//                  �d��ł͕s�v�����t���Ă����B
// minimize       : �����t����ƁA�����\����DFSA(���萫�L���I�[�g�}�g��)���ŏ������Ă����
// verbose        : �����t����ƁA�r���h�̓r���o�߂��o�͂����
// persistbuffer  : �����t����ƁA���͂�S�ăo�b�t�@�Ɋi�[���Ă����͂���悤�ɂȂ�B
//                  ����ɂ��AScanBuff.GetString()�ŔC�ӂ̈ʒu����ǂ߂�悤�ɂȂ�B
//                  �������A���̓t�@�C���̃T�C�Y���傫���ƁA�������g�p�ʂ�������̂Œ��ӂ��K�v�ƂȂ�B
// noembedbuffers : �����t����ƁA�o�b�t�@�Ƃ���GplexBuffers�N���X���g���悤�ɂȂ�B
//                  ����ɂ��A�A�v�����Ńo�b�t�@�𗘗p�������ꍇ�ɕ֗��ɂȂ�B
//                  �t���Ȃ��ƁA�o�b�t�@�ɃA�N�Z�X�ł��Ȃ��B
%option stack, minimize, parser, verbose, persistbuffer, noembedbuffers

D           [0-9]
L           [a-zA-Z_]
H           [a-fA-F0-9]
E           [Ee][+\-]?{D}+

%{

%}


%%
// ---------------------------
// ���[����
// ---------------------------

// �ϐ���
{L}({L}|{D})*               { yylval.text = yytext; return (int)Token.VARIABLE; }

// 16�i��
0[xX]{H}+                   { yylval.real = (double)Convert.ToInt32(yytext, 16); return (int)Token.CONSTANT; }

// 8�i��
0{D}+                       { yylval.real = (double)Convert.ToInt32(yytext, 8);  return (int)Token.CONSTANT; }

// 10�i���̐���
{D}+                        { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// �w���\����10�i���̐���
{D}+{E}                     { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// ����
{D}*"."{D}+({E})?           { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }
{D}+"."{D}*({E})?           { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// ���Z�q
"="                         { return '='; }
"("                         { return '('; }
")"                         { return ')'; }
"-"                         { return '-'; }
"+"                         { return '+'; }
"*"                         { return '*'; }
"/"                         { return '/'; }

// �Y�����Ȃ������͖�������
.                           /* Skip */


%%
// ---------------------------
// �R�[�h��
// ---------------------------
