CC = gcc
EXE = pl_ass
LEX = flex
YACC = bison
LFILE = assignment.l	
CFILES = lex.yy.c
LEX_FLAG = -ll

$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES) $(LEX_FLAG)

lex.yy.c: $(LFILE) 
	$(LEX) $(LFILE)

clean:
	rm $(EXE) $(CFILES)
