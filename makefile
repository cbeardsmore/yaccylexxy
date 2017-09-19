CC = gcc
EXE = pl_ass
LEX = flex
YACC = bison
YFILE = assignment.y 
LFILE = assignment.l	
CFILES = assignment.tab.c lex.yy.c 

$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES) 

lex.yy.c: $(LFILE) 
	$(LEX) $(LFILE)

clean:
	rm $(EXE) $(CFILES)
