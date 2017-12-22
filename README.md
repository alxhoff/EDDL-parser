# EDDL-parser
A Flex/Bison parser for EDDL files. This is being used for a proof of concept project and may not be developed into a complete parser as that is at the moment not required for my project. If anything this work will show anyone how to start developing a parser for text files/EDD files. Also a handy example to show how more C files can be pulled into a lex/yacc project.

## Lex scanner

There is a lex demo in the  **lex_test** folder.

This demo can be used to see how the file is tokenized to get a feel for what grammar needs to be applied through yacc.

## Building

```make
make
```

## Running

```bash
./scanner < example_eddl.edd
```
