/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    WHITESPACE = 258,
    BRACKETS = 259,
    END_BRACKETS = 260,
    MANUFACTURER = 261,
    DEVICE_TYPE = 262,
    DEVICE_REVISION = 263,
    DD_REVISION = 264,
    VARIABLE = 265,
    LABEL = 266,
    HELP = 267,
    CLASS = 268,
    TYPE = 269,
    HANDLING = 270,
    DEFAULT_VALUE = 271,
    STRING = 272,
    INTEGER = 273,
    HEX = 274,
    FLOAT = 275
  };
#endif
/* Tokens.  */
#define WHITESPACE 258
#define BRACKETS 259
#define END_BRACKETS 260
#define MANUFACTURER 261
#define DEVICE_TYPE 262
#define DEVICE_REVISION 263
#define DD_REVISION 264
#define VARIABLE 265
#define LABEL 266
#define HELP 267
#define CLASS 268
#define TYPE 269
#define HANDLING 270
#define DEFAULT_VALUE 271
#define STRING 272
#define INTEGER 273
#define HEX 274
#define FLOAT 275

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 9 "eddl.y" /* yacc.c:1909  */

        float dec; 
        char* ptr;
        int num; 
        char str[100];
        

#line 102 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
