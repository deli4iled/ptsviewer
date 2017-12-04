# ptsviewer version
VERSION = 0.7.5

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

GLINC  =$(shell pkg-config --cflags gl)
GLLIB  =$(shell pkg-config --libs   gl)
GLUINC =$(shell pkg-config --cflags glu)
GLULIB =$(shell pkg-config --libs   glu)
GLUTINC=
GLUTLIB=-lglut
MLIB   =-lm
OPENCVINC  =$(shell pkg-config --cflags opencv)
OPENCV =$(shell pkg-config --libs   opencv)

# includes and libs
INCS=-I. -I/usr/X11/include/ ${GLINC} ${GLUINC} ${GLUTINC} ${OPENCVINC} 
LIBS=-L/usr/lib ${GLLIB} ${GLULIB} ${GLUTLIB} ${MLIB} ${OPENCV} 

# dirs for source and object files
OBJDIR   = obj
SRCDIR   = src

# compiler and additional flags
COMPILER = g++
COMPILER_C = gcc
FLAGS    = -Wall -DVERSION=\"${VERSION}\" ${INCS} ${LIBS} -fpermissive -Wsign-compare
RFLAGS   = ${FLAGS} -O3
DFLAGS   = ${FLAGS} -g
