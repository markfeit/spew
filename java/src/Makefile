#
# Makefile for Java spew 
#
# xyzzy - This should really be done in Ant.
#
CLASSES=\
	SegmentArgSelector \
	SegmentCategoryInvocation \
	SegmentText \
	\
	Segment \
	Item \
	\
	UnknownCategoryException \
	UnknownModifierException \
	\
	BadModifierException \
	CategoryModifier \
	WeightedArray \
	Category \
	\
	DuplicateCategoryException \
	UnknownCategorySetException \
	CategorySet \
	\
	TemplateErrorException \
	TemplateParser \
	\
	Spewer \
	Spew


JAVAFILES=$(CLASSES:%=%.java)
CLASSFILES=$(CLASSES:%=%.class)

TESTDIR=/local/spare/mfeit/lucene
TESTFILES=$(TESTDIR)/files
TESTINDEX=$(TESTDIR)/index

%.class: %.java
	javac $<

default: build

docs: $(JAVAFILES)
	rm -rf docs
	mkdir docs
	javadoc -quiet -d docs $(JAVAFILES)

build: $(CLASSFILES)

test: build
	java Spew

clean:
	rm -rf $(CLASSFILES) docs *~
