// ---------------------------
// 定義部
// ---------------------------

// 出力するクラスのnamespace
%namespace GPPGCalculator2

// 出力するクラス名
%scannertype CalculatorScanner

// 出力するクラスのアクセシビリティ
%visibility internal

// トークンに使用するenumの型名
%tokentype Token

// オプション
// stack          : これを付けると、状態をスタックに保存できるようになる。
//                  C言語のコメント(/*  */)の解釈のように、状態を管理したい場合に使用する。
//                  電卓では不要だが付けておく。
// minimize       : これを付けると、内部構造のDFSA(決定性有限オートマトン)を最小化してくれる
// verbose        : これを付けると、ビルドの途中経過が出力される
// persistbuffer  : これを付けると、入力を全てバッファに格納してから解析するようになる。
//                  それにより、ScanBuff.GetString()で任意の位置から読めるようになる。
//                  しかし、入力ファイルのサイズが大きいと、メモリ使用量も増えるので注意が必要となる。
// noembedbuffers : これを付けると、バッファとしてGplexBuffersクラスを使うようになる。
//                  これにより、アプリ側でバッファを利用したい場合に便利になる。
//                  付けないと、バッファにアクセスできない。
%option stack, minimize, parser, verbose, persistbuffer, noembedbuffers

D           [0-9]
L           [a-zA-Z_]
H           [a-fA-F0-9]
E           [Ee][+\-]?{D}+

%{

%}


%%
// ---------------------------
// ルール部
// ---------------------------

// 変数名
{L}({L}|{D})*               { yylval.text = yytext; return (int)Token.VARIABLE; }

// 16進数
0[xX]{H}+                   { yylval.real = (double)Convert.ToInt32(yytext, 16); return (int)Token.CONSTANT; }

// 8進数
0{D}+                       { yylval.real = (double)Convert.ToInt32(yytext, 8);  return (int)Token.CONSTANT; }

// 10進数の整数
{D}+                        { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// 指数表示の10進数の整数
{D}+{E}                     { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// 実数
{D}*"."{D}+({E})?           { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }
{D}+"."{D}*({E})?           { yylval.real = double.Parse(yytext); return (int)Token.CONSTANT; }

// 演算子
"="                         { return '='; }
"("                         { return '('; }
")"                         { return ')'; }
"-"                         { return '-'; }
"+"                         { return '+'; }
"*"                         { return '*'; }
"/"                         { return '/'; }

// 該当しない文字は無視する
.                           /* Skip */


%%
// ---------------------------
// コード部
// ---------------------------
