# Makefile For Yacc and Lex Parser
# PL200 Assignment
# Last Modified: 27/09/17
# Connor Beardsmore - 15504319

# MAKE VARIABLES
CC = gcc
EXE = QUENYARGOLINT
LEX = flex
YACC = bison
LFILE = lexxy.l
YFILE = yaccy.y
CFILES = yaccy.tab.c lex.yy.c
EXTRA_FILES = yaccy.tab.h y.output
LEX_FLAG = -ll

# EXECUTABLE
$(EXE): $(CFILES)
	$(CC) -o $(EXE) $(CFILES) $(LEX_FLAG)

# LEX
lex.yy.c: $(LFILE)
	$(LEX) $(LFILE)

# YACC
yaccy.tab.c: $(YFILE)
	$(YACC) -d $(YFILE)

clean:
	rm $(EXE) $(CFILES) $(EXTRA_FILES)
