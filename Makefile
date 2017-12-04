# ptsviewer - simple pointcloudviewer

include config.mk

it: $(OBJDIR)/ptsviewer.o $(OBJDIR)/rply.o
	$(COMPILER) $(OBJDIR)/*.o -o ptsviewer  $(FLAGS)

$(OBJDIR)/ptsviewer.o: $(SRCDIR)/ptsviewer.cpp $(SRCDIR)/ptsviewer.h
	@mkdir -p $(OBJDIR)
	$(COMPILER) $(FLAGS) -c $(SRCDIR)/ptsviewer.cpp -o $(OBJDIR)/ptsviewer.o

$(OBJDIR)/rply.o: $(SRCDIR)/rply/rply.c $(SRCDIR)/rply/rply.h
	@mkdir -p $(OBJDIR)
	$(COMPILER_C) $(FLAGS) -c $(SRCDIR)/rply/rply.c -o $(OBJDIR)/rply.o


# DEBUG
debug: $(OBJDIR)/ptsviewer.dbg.o $(OBJDIR)/rply.dbg.o
	$(COMPILER) $(OBJDIR)/*.dbg.o -o ptsviewer  $(DFLAGS)

$(OBJDIR)/ptsviewer.dbg.o: $(SRCDIR)/ptsviewer.cpp $(SRCDIR)/ptsviewer.h
	@mkdir -p $(OBJDIR)
	$(COMPILER) $(DFLAGS) -c $(SRCDIR)/ptsviewer.cpp -o $(OBJDIR)/ptsviewer.dbg.o

$(OBJDIR)/rply.dbg.o: $(SRCDIR)/rply/rply.c $(SRCDIR)/rply/rply.h
	@mkdir -p $(OBJDIR)
	$(COMPILER) $(DFLAGS) -c $(SRCDIR)/rply/rply.c -o $(OBJDIR)/rply.dbg.o


# RELEASE
release: $(OBJDIR)/ptsviewer.rel.o $(OBJDIR)/rply.rel.o
	$(COMPILER) $(OBJDIR)/*.rel.o -o ptsviewer  $(RFLAGS)

$(OBJDIR)/ptsviewer.rel.o: $(SRCDIR)/ptsviewer.cpp $(SRCDIR)/ptsviewer.h
	@mkdir -p $(OBJDIR)
	$(COMPILER) $(RFLAGS) -c $(SRCDIR)/ptsviewer.cpp -o $(OBJDIR)/ptsviewer.rel.o

$(OBJDIR)/rply.rel.o: $(SRCDIR)/rply/rply.c $(SRCDIR)/rply/rply.h
	@mkdir -p $(OBJDIR)
	$(COMPILER) $(RFLAGS) -c $(SRCDIR)/rply/rply.c -o $(OBJDIR)/rply.rel.o


test: it
	./ptsviewer

install: release
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ptsviewer ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/ptsviewer
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < ptsviewer.1 > ${DESTDIR}${MANPREFIX}/man1/ptsviewer.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/ptsviewer.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/ptsviewer
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/ptsviewer.1

clean:
	rm -rf *~ $(OBJDIR) ptsviewer

all: clean it
