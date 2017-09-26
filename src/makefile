CC = gcc
EXE = QUENYARGOLINT
LEX = flex
YACC = bison
LFILE = assignment.l
YFILE = assignment.y
CFILES = assignment.tab.c lex.yy.c
LEX_FLAG = -ll

$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES) $(LEX_FLAG)

lex.yy.c: $(LFILE)
	$(LEX) $(LFILE)

assignment.tab.c: $(YFILE)
	$(YACC) -d $(YFILE)

clean:
	rm $(EXE) $(CFILES) assignment.tab.h
