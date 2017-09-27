# Makefile For Yacc and Lex Parser
# PL200 Assignment
# Last Modified: 27/09/17
# Connor Beardsmore - 15504319

# MAKE VARIABLES
CC = gcc
EXE = QUENYARGOLINT
LEX = flex
YACC = yacc
LFILE = lexxy.l
YFILE = yaccy.y
CFILES = y.tab.c lex.yy.c
EXTRA_FILES = y.tab.h y.output
LEX_FLAG = -ll

# EXECUTABLE
$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES)

# LEX
lex.yy.c: $(LFILE)
	$(LEX) $(LFILE)

# YACC
y.tab.c: $(YFILE)
	$(YACC) -d $(YFILE)

clean:
	rm $(EXE) $(CFILES) $(EXTRA_FILES)
