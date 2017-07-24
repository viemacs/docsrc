---
weight: 20
title: Tools
draft: false
---

## Makefile

### Make Basic
*make* is designed to manage the compiling process based on dependencies. The other functions of make is designed to make it easier to write Makefile.

- - -

When we deal with a complex project, there might be lots of source files, header files, lib files, target files.
The files have a certain dependency relationship.

```
$ gcc -c -o test.o test.c
$ gcc -o helloworld test.o
```
The dependency line is: `test.c` -> `test.o` -> `helloworld`. 

When dealing with many files, the compiler is called many times. We build the files on which is depended, then build target files on top of that.

And *make* is a tool to automatically record and process the dependency.
The dependency relationship is written in the Makefile file, and *make* will compile the files w.r.t. the dependency described in Makefile.

#### Dependency

Here is a basic Makeifle

```
# target binary file: helloworld
helloworld: test.o
	echo "good"
	gcc -o helloworld test.o

test.o: test.c
	gcc -c -o test.o test.c
```
* # starts a comment line
* a target depends on its prerequisite. Multiple files are separated by spaces.
* The lines indented by Tab are operations to implement a dependency relationship. These operations are normal Shell commands.

*make* is a recursive process.

> * If the current dependency has not prerequisite, then execute operations directly.
> * If the current dependency has prerequisite, and the required files exist and have not been changed since the last make (judged by write-timestamp), then execute operations directly.
> * If the required files of the current dependency do not exist, or have been changed, then use the required files as target files, and search their dependency, create target files.


#### Macro
Macro in *make* is text-type variable.
```
CC = gcc
helloworld: test.o
　　echo "good"
　　$(CC) -o helloworld test.o

test.o: test.c
　　$(CC) -c -o test.o test.c
```

#### Inner Macro
- `$@` is target filename of the current dependency.
- `$^` is required filenames of the current dependency.
- `$*` target filename without suffix of the current dependency
- `$*` the changed files in the current dependency
- `$$` character $
- `$(@D)` directory of file path
- `$(@F)` filename of file path

```
CC = gcc
helloworld: test.o
　　echo $@
　　$(CC) -o $@ $^

test.o: test.c
　　$(CC) -c -o $@ $^
```
 
#### Suffix Dependency
```
CC = gcc

.SUFFIXES: .c .o

.c.o:
	$(CC) -c -o $@ $^

#--------------------------
helloworld: test.o
	echo $@
	$(CC) -o $@ $^

test.o: test.c
```

`.c.o` means `.c` is prerequisite, and `.o` is target.
*make* will find test.o and test.c has dependency, and will execute operation for this dependency.

Suffix dependency is very handy is big projects.

#### Misc

Special dependency in makefile.

all: if *make* was followed by no filename, "all" will be chosen.

clean: it is used to clean legacy files.

```
CC = gcc

.SUFFIXES: .c .o

.c.o:
        $(CC) -c -o $@ $^

#--------------------------

all: helloworld
        @echo "ALL"

helloworld: test.o
        @echo $@
        $(CC) -o $@ $^

test.o: test.c

clean:
        -rm helloworld *.o
```
'@' will hide the following command itself.
'-' will ignore the stderr of the following command.
