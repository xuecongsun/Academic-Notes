

## Lecture 1&2 Introduction

### Basic Command with Switches and Options

```bash
#manual of a function. Press q to exit
man man

#echo write something to standard output. What's the difference between cat and printf and echo? printf can format, cat can read file, echo can only take argument
echo hello world
#not printing the trailing newline
echo -n hello world

#rev reverse lines of a file. Rev copies the specified file to standard output, reversing the order of the characters of each line.
rev filename
#if no file input, it will reverse the input argument
rev hello

#printf prints formatted output. %s for string, %d for digit, %8.2f for 8 bytes field width and 2 decimal places. 8 bytes is 4 spaces
printf 'hello %s again' world
printf '%d inch is %8.2f centimeters' 1 2.54

#uniq reports or filters out repeated lines in a file. Uniq identifies repeated lines, not within each line. Also, it only removes repeated lines if they are adjacent, so always SORT first.
#sort sorts binary or text files by lines, not within each line
#below command is to sort the argument and select uniq values. The sequence of commands has to be like this, can't change.It is because need to separate argument into lines first for sort and uniq to happen. Sort has to go before uniq.
echo '3 2 1 2 3 1 4 5 5 6'|tr '' '\n'|sort|uniq

#head displays first lines of a file
head -n numberoflines filename
head -c numberofbytes filename

#tail displays last lines of a file
tail -n numberoflines filename
tail -c numberofbytes filename
tail -r numberoflines filename #display lines in a reverse order

#concatenate and print files. reads file from standard input and prints them to standard output.
cat filename
#EOF will read input and pass it to cat, and cat will read the standard in and pass standard output to new.txt. Nothing will be printed to display
cat > new.txt << EOF

#less previews file. Does not have to read the entire file before starting, so with large input files (like ‘omics) this is useful for previewing data.
less filename

#cut out selected portions of each line in a file and writes to standard output
#cut using delimiter as :, and return field 1 and 7 from file /etc/passwd
#list is separated by comma, specifying the region to cut. or just one number specifying the fields that we want like 3
#-b is by bytes, -c is by characters, -f by fields(specified delimiterby -d)
cut -b list [filename]
cut -c list [filename]
cut -d : -f 1,7 /etc/passwd
cut -d "=" -f 2 #cut by delimiter being equal sign and print out the second field

#cut focuses on file, but if the file parameter is a dash, it will take standard input like this
echo hello|cut -c 1,3 - returns hl

#cut a region
cut -f 1-2
echo hello|cut -c 1-3 - returns hel


#translate characters in standard in (pipe standard in to tr)
tr " " "\n"
#translate single quote to double
tr "'" '"'
tr \' \"
tr "[:upper:]" "[:lower:]" #can interpret posix class

#heredoc
cat>new.txt<<EOF 
tr "h" "o" <<EOF

#print working directory
pwd
#list all files
#list all info, not only file name, not only unhidden files
ls -al #print all including hidden files in long format
ls -l  #print in long format
#long format contains - permissions, number of files, user of files,group, size of files in bytes, modification date, name of the file

#make directory
mkdir directoryname
#modify attributes of file or create new file
touch filename
#change directory
cd
#copy
cp file target_path
#rename
mv filename newfilename
#remove
rm filename

#byte size of a file
stat -f%z filename

#count number of lines in a file
wc -l filename gives you the count of lines in a file
wc -c filename gives you the character count of a file

#awkward print, printint field
awk '{print $1}'


```

### File Descriptor

1. 0 is standard input, processes in terminal connect standard input with keyboard.
2. 1 is standard output, processes in terminal connect standard output with display
3. 2 is standard error, processes in terminal connect standard error with display

### Argument

1. Space: 
   - things separated by space - 2 arguments
2. ""/''
   - things encapsulated within "" or '' - 1 argument
3. Escape \
   - things separated by \ - 1 argument

### Redirection

1. Pipe |

   - connects standard output of one command to be the standard input of the other command

   - ```bash
     echo redrum|rev
     
     #❓reverse print redrum for 3 times using 1 argument (2 ways)
     #reverse print redrum for 3 times using 3 argumnet (2 ways)
     ```

2. Redirection and File Descriptor

   1. ```bash
      #convert into standard output
      echo hello world >&1 | rev
      #convert into standard error. So will display hello world as rev has no standard output to reverse
      echo hello world >&2 | rev
      
      # > standard output redirection
      # >> standard output redirection, append
      # 2> standard error redirection
      # 2>> standard error redirection, append
      # note the difference between >&2, 2>. 2> is to redirect into a file but >&2 just to store in standard error
      ```

      ### Permission

      1. drwxrwxrwx

         - file type: is it a file or a directory
         - user, group, other: read, write, execute
         - r - 4, w - 2, x - 1

      2. Read permission:

         - For file, view contents of file. For directory, view names of files

      3. Write permission:

         - For file, allows user to modify. For directory, allows user to delete, modify, create and rename contents

      4. Execute permission:

         - For file, allows user to execute script. For directory, allows user to access or traverse into metadata

      5. Modify permission

      6. ```bash
         chmod 777 new.txt
         ```

### Miscellaneous

1. Everything is a file in Bash - follows file system hierarchy
2. Directories: when you create a new directory in bash, it automatically contains 2 directory, current and parent directory.



## Vim

1. Mode
   - Normal: esc and then : to give other command
   - Insert: i
2. Move cursor (you have to be in normal mode:
   - h (move backward), j (go one line down) ,k (go one line up),l(move forward)
3. Word movement(not restricted to one line, can move across document):
   - w(start of the next word), b(beginning of the word), e(move to the end of the word)
4. Number-powered movement:
   - can use all above movement together with numbers. number first then movement 2j for example is to move down 2 lines
5. Insert text repeatedly
   - (number)[i]word + esc. 3igo +esc
6. Search(just 1 occurence)
   - forward search (number)[f]searchword, 3fo, forward search the 3rd occurence of o
   - backward search (number)[F]searchword, 3Fo, backward search the 3rd occurence of o
7. Go to matching parenthesis
   - %
8. Go to start or end of line
   - 0 go to start of line, $ go to end of line
9. Find word with cursor
   - Find the next occurence of the word *, find the previous occurence of the word #
10. Go to beginning or end of the file, go to specific line
    - gg takes to beginning of file, G to the end
    - (number)G takes you to the numbered line
11. Search through whole doc and show all occurence
    - /textyouwanna find. n is to the next find, N is to the previous find
12. Insert a new line
    - o insert below the cursored line, O insert above the cursored line
13. Remove character
    - X deletes whatever on the left of cursor, x deletes whatever on the right of cursor
14. Replace
    - r(replacedword)
15. Deleting combining with movement
    - dw deletes the first word on the right of the cursor (as w brings you to the beginning of the next word)
    - de deletes word on the right of the cursor (e brings you to the end of the next word) (somehow i feel de and dw are the same)
    - d2e, delete 2 words on the right of the cursor.
    - delete also like cut, you can paste it by using 'p' somewhere
16. Repeat previous command
    - using '.'
17. Visual mode
    - enter visual mode by using v, and using movement to select
18. Miscellaneous
    - :w: to save, :q to quit, :q! is quit without saving, :wq is save and quite. 
    - u is undo, ctrl+R is redo
    - :help is to help



## RegEx

```bash
#Any digit
\d
#Any non-digit
\D
#Any character(letter,digit,whitespace, everything)
.
#period
\.
#match only abc
[abc]
#match not abc
[^abc]
#match a range, match anything but the range
[0-6] [a-d] [^a-d]
#alphanumeric
\w = [A-Za-z0-9_]
\W any non-alphanumeric character
#repetition
[abc]{1,5} any character in a,b,c to show up between once to 5 times
.{2,6} any character between 2 to 6 times showing up
or escape curly braces \{5\}
# 1 or more repetitions, 0 or more repetitions
* is 0 or more repetitions, + is 1 or more repetitions
.* refers to anything and everything possible coming in between
#optional
ab?c will match abc or ac as b is optional
#question mark
\?
#whitespace
\s
#any non-whitespace
\S
#start and end
^start. end$
#capture group
()
#capture or
i love (cats|dogs)
#word boundary for exact match
\<the\>
\bbest\b
#word border \b doesn't need to appear in pairs
fu\b will match fu at the end
#\1 
refers to same as the first group defined in ()
#?!
negative lookahead, doesn't contain the expression after ?!

#posix class
[:upper:][:lower:][:alpha:][:digit:][:punct:][:blank][:space:]

```



## Lecture 3 MD5 & RegEx

### Understanding MD5

1. **Why:**

- Helps verify the content of the file

- MD5 will change based on the content of the file. So if hacker changes the content of the file, MD5 will change and it won't match the legal MD5 of the file posted online

2. **What is MD5:**

- A series number

3. **Collision:**

- different files may have the same MD5

4. **Current in use:** Sha2-56

5. Find MD5

   1. ```
      md5 filename
      ```




### Tar & Gunzip

1. **Tar:** 

   - Create and manipulate archive files - multiple files in one file. The archive won't be compressed

   - tarball:

   - untar a file

     ```bash
     #create a tarball .tar
     tar -cf tarballname filename1 filename2
     
     #create a tarball and zip it .tar.gz or .tgz
     tar -czf tarballname filename1 filename2 filename3 
     tar -czf tarballname diredtoryname
     
     #untar a tarball
     tar -xf filename
     
     #list files in a tarball
     tar -tf filename
     
     -c create an archive
     -f the name of the archive file
     -z put the archive through gzip
     -x extract from the file
     -v verbose, tell me what's going on
     -t table of contents
     
     ```

2. **Zip:**

   - Compress files, but have patent issues

3. **Gzip:**

   - Compress files, open source
   - gzip can't zip a directory/folder. It can only compress a file. Therefore, if you want to compress a directory, you have to make the folder a tarball first and then zip it. so usually done together with tar

4. **Gunzip:**

   - Uncompress files
   - gunzip filename.tar.gz

5. **Get file from online**

   ```bash
   wget weblink
   ```

### Pathname Expansion (Globbing)

1. *

   - ###### Map any kind of text (any length), even no text at all(a bit diff from regEx repetition)(in regex * means 0 or more repetition of character before that)

     - has question as it can't find .vscode

   - ```bash
     #list all files end with .h. ls -l means listing in long format
     ls -l *.h
     ```

2. ? (in regex,?means optional)

   - Match with single character

   - ```bash
     #list all files that have 'coun' alphabet and last alphabet unknown
     ls -l coun?
     ```

3. []

   - Match a single character, only if it is in the given set

   - ```bash
     #list all files that have a single digit in the file name
     ls -l *[0-9]*
     ```

4. [[:classname:]]

   - Match a single character, but you don't need to enumerate the digit, can just specify the classname

   - ```bash
     #list all files that have a single digit in the file name
     ls -l *[[:digit:]]*
     ```

   - Other class names refer to notes

### Tilda Expansion

1. **Tilda Prefix**

   - If a word begins with ~, all of the characters up to the first unquoted slash (or all characters, if there's no unquoted slash), are considered as tilda prefix
   - ❓~abcd/, ~'abcd'?

2. **Login Name**
   - If none of the characters in the tilda-prefix are quoted, the charactersi n the tilda prefix following the tilda are treated as possible login name

3. **Home**
   - If the login name is a null string, the ~ is replaced with the value of home shell variable

4. ❓If home is unset, the home directory of the user executing the shell is substituted instead

5. Otherwise, the tilda-prefix is replaced with the home directory associated with the specified login name


### Command Substitution

1. Write a command within a command and execute the command within the bracket first

2. The output of the inner command is used as argument to the outer command

3. ❗️Attention: has to use double quote instead of single quote?

   ```bash
   #top one works as the code will interpret $() but below doesn't work
   echo "this file contains $(cat hello.txt)"
   echo 'this file contains $(cat hello.txt)'
   
   #you can also use `` for command substitution
   echo "this file contains `cat hello.txt`"
   ```



### Shell Variables

1. Definition: A bash parameter that has a name

2. Attention: don't type space in assign value to parameter.❗️We also don't have to type "" or '' for string when assigning values? if you have name='luna is great'

   ```bash
   name=luna
   animal=dog
   echo my ${animal}s name is $name
   ```


### Environment Variable

1. Environment variables exist at the process level (not a feature of bash, but any program)

2. Rule: one should put your variables in the shell space unless you specifically require the behavior of environment variables

3. ❗️I don't understand the diagram - environment variables still reside in bash isn't it? Also do not understand the new processes + environment variable part

   - so bash variable can only be exported to the next level but not the other way around. environmental variable can be exported for the bash shell to use, but the next level bash shell can't export a variable for the environment to use.

4. Two types of spaces that variables are kept: shell or environment

   ### Export Shell Variables

```bash
name=luna
export name
bash
echo $name   
#will print out luna. Without export, calling $name in bash will not generate output
```

### Finding Stuff

1. Regular Expression

   - a string of characters
   - contains at least a character set, an anchor (position in line to match), a modifier (something expands or narrows the range of text to match)

2. Typical command

   ```bash
   #match word at the end of the line
   word$ 
   #match any one of a,b,c
   [abc]
   #match best, but not besto?
   \<best>\
   \bbest\b
   #match H four times
   H{4}
   #match any lower case letter or digit
   [a-z0-9]
   #posix class
   [:upper:]
   [:alpha:][:digit:]
   [:punct:]
   [:blank:][:space:]
   
   ```

3. SUGGESTED STUDY: http://tldp.org/LDP/abs/html/x17129.html 

4. https://alf.nu/RegexGolf



   ## Lecture 4 GREP & SED Search and Replace

### GREP & EGREP

1. Grep command is for simple search, so the first one won't give exact match?yes

2. ```bash
   #gives you the line that contains the thing you want to search
   #grep is not perfect match unless you set boundary in the expression
   grep '867-5309' anna_karinina.txt
   
   #gives you the line number that contains the thing you want to search
   #gives line number as well as content
   grep -n '867-5309' anna_karinina.txt
   
   #allows you to find exactly the word because of expression boundary
   grep -n '\<867-5309\>'
   ```


2. Egrep command is for extended regular expression. Extended regular expression can't be run by Grep

3. ```bash
   #search for a series number that has 3 digits before dash and 4 after
   egrep -n '[0-9]{3}-[0-9]{4}' anna_karinina.txt
   ```


### SED

1. SED command is to change searched items

2. ```bash
   # s means substitute. Attention: there has to be '/' to close up at the end
   # whether or not to have "" doesn't matter here
   echo hello|sed s/hello/goodbye/
   
   #delimiter can also be _
   echo hello|sed s_hello_goodbye_
   
   # not doing anything as it is only pointed to a directory pointer
   sed s/hello/goodbye/ .
   
   # search in all files and replace hello with goodbye
   sed s/hello/goodbye/ ./*
   
   ```



   ​    ❗️**Be careful about sed command, as it is expecting only the first variable as a RegEx, the second one must be a replacement string!!! That's why the below command, the code is taking the posix class literally. And if you use regEx, you need to enclose the part after sed with single quote.**

	   Moreover, all commands below just print results to standard output, the input in the file is not modified. Refer to the next section for how to modify in-file content.

   ```bash
   # sed will find the lower case it found to [:upper:]. as sed is not expecting a regular expression as the second string. to change all lower to upper, use tr
   sed s/[:lower:]/[:upper:]/ < snark.txt
   
   # same as above, it doesn't work
   sed s/[a-z]/[A-Z]/ < snark.txt
   
   # this command only change one 'his' to 'HIS', won't change all small to cap
   sed 's/his/HIS/' snark.txt
   sed 's/his/HIS/g' snark.txt  #this changes all his
   
   # Using translate, it will translate each alphabet separately, such as change all small h to H, change all small i to I, not bounded by the words 'his' to 'HIS'. Watch out that you also need <filename to pass input into tr, it works differently from sed
   tr 'his' 'HIS' < snark.txt
   
   # finally this works
   tr '[[:lower:]]' '[[:upper:]]' < snark.txt
   
   # repeat sign &. This will print the first lowercase the command found 3 times(including the first time). wth space in between. Again, need single quote
   sed 's/[[:lower:]]/& & &/' < snark.txt
   
   
   
   ```

3. Switches: sed -n/sed -i. 

   - sed -n:
   - sed -i:

   ```bash
   # change all punctuations to period. Why need the \ in front. I believe we can do without it. Put a \ in front of it is to prevent treating the dot as a metacharacter
   sed 's/[\,,:]$/\./' snark.txt 
   
   # what does -n mean - suppresses the behaviour of echoing the output. But will it change snark.txt? no it won't.
   sed -n 's/[\,,:]$/\./' snark.txt 
   
   #why the above doesn't need <snark.txt.the above returns a blank file because n suppress the echo of the output
   sed -n 's/[\,,:]$/\./' snark.txt > snark.txt 
   
   # what does -i mean - saving backup of original files with .tmp postfix. The original snark.txt will be changed with all punctuations at the end become period. 
   sed -i.tmp 's/[\,,:]$/\./' snark.txt 
   # if you don't want the backup
   sed -i '' 's/[\,,:]$/\./' snark.txt 
   ```

4. Sed(/g) pattern flags: find all occurences in line

5. ```bash
   #will only replace one o to O
   sed 's/o/O/' snark.txt
   #will replace all o to O
   sed 's/o/O/g' snark.txt
   sed -i 's/o/O/g' snark.txt #doesn't work
   sed 's/o/e/' snark.txt
   BE CAREFUL with Documentation
   ```

   ### Understanding Quotation

   1. Single quote: takes content literally
   2. Double quote: bash will interpret what's inside
   3. Escape: having escape in double quote will not let bash interpret the command. Instead bash will take it literally such as the single quote
   4. Caution: certain syntax doesn't follow this. For example, sed demands single quote, although double quote means interpretation. 

   ### Conditional

   1. If command block

   2. ```bash
      # what does read -p do. prompt
      read -p "would you like breakfast? [y/n]"
      
      # need to have space. put ;. Double bracket
      if [[ $REPLY = y]]; then echo "here you go an egg sandwich";else echo "okay";fi
      if [ "$REPLY" = 'y' ]
      if [ "$REPLY" -eq 'y' ]
      #in this example, with or without "" with [] or [[]] all work
      ```

   2. Quote string variable: why do we need to put the double quote here? command substitution

6. ```bash
   if [ "$stringvar" == "tux" ]; then
   ```

         Put double quote for globbing:

   ```bash
   if [[ "$stringvar" == *string* ]];then
   ```



   - Why is there a string variable? If we want to get the response to be variable, should we always use $reply? and do we need to quote that? Ans: use reply dollar sign only when you have read function before it

   3. So in bash, = is the same as == is the same as -eq

   4. More logic operators

   5. ```bash
      #the length of string is greater than 0
      [ -n string ] 
      #the length of string is 0
      [ -z string ]
      #string 1 equal to string 2
      [ string1 = string2 ]
      [ string 1 == string2 ]
      [ string 1 -eq string2 ]
      #string 1 not equal to string 2
      [ string1 != string2 ]
      #integer1 equal to integer 2
      [ int1 -eq int2 ]
      #interger1 greater to integer 2
      [ int1 -gt int2 ]
      #integer1 less than integer 2
      [ int1 -lt int2 ]
      #file exists in a directory
      [ -d file ]
      #file exists
      [ -e file ]
      #file exists and can read, or write, or execute
      [ -r file ][ -w file ][ -x file ]
      #file exists and size greater than 0
      [ -s file ]
      
      ```

   6. If Alternative - And-If, Or-if

   7. ```bash
      #if statement
      if [ -x test.txt ];then echo file is executable;else echo file is not executable;fi
      
      #if alternative
      [ -x test.txt ] && echo file is executable || echo file is not executable
      
      
      [ -e newfile.txt ] && echo newfile.txt exists || touch newfile.txt; echo newfile.txt created
      ```


### Test & Exit Status

1. Test

   - returns 1 or 0 in exit status. 1 is false, 0 is true 

   - ```bash
     test 001 = 1
     echo $?
     # will return 1 as 001 is not equal to 1
     
     test 1 = 1
     echo $?
     # will return 0 as 1 is equal to 1
     ```

   - can also just use [[]]

   - ```bash
     [[001 = 1]]
     echo $?
     # same function as the above chunk. will return 1
     
     ```


2. Exit Status
   - Falls between 0 and 255. Non-zero value means false or failure
   - ❓what's the caution slide about?



## Lecture 5 Loop & Bash Script

### For Loop

```bash
for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto;do echo $planet;done # Each planet on a separate line.


#with command comprehension
for file in $(ls -al)
do
	[ -x $file ] && echo Found executable file: || echo Found non-executable file:
	echo $file
done

#one more example
for number in 1 2 3;do touch "file${number}.txt";done
#watch out you need to use ${}to get variable value, also need "" for comprehension

#for loop traverse through a series of number
for number in {start..end};
```



### While Loop

1. Basic Code 

```bash
var0=0

#the condition with "" and without are the same
while [ $var0 -lt 10 ]
do
  echo "$var0"  #with or without quotation is the same  
  #back quote `` also for command substitution, same as $()
  #expr is for computation purpose. watch out the expression must have space in between. $var0+1 doesn't work
  #watch out, you can't have space during assignment!!! or it will run error
  var0=`expr $var0 + 1` 
done 

#in bash
while [ $var0 -lt 10 ];do echo $var0; var0=`expr $var0 + 1`;done
```

### Function

```bash
# this function captures the first positional argument to the function
function e {
    echo $1
}

e hello word
# will return hello

#!in bash. watch out the space, as well as the ;
function e { echo hello world; }

#print $1 first position argument
function e { echo $1; }
e the dude #will return the but not dude

#loop through all argument. $@ lists all argument
function loop_it { for var in $@;do echo $var;done }
#or using while. no need to put "" or [[]] as this doesn't involve comprehension in string and regular expression. $# counts number of argument. shift means reducing 1 or a number from $#
function loop_it { while [ $# -gt 0 ];do echo $1;shift;done }
```



### Bash Script

```bash
#creating script
#!/bin/bash
echo hello

#execute script by changing permission first
chmod 744 script.sh
./script.sh argument
bash script.sh argument

#call a function inside bash script
source script.sh functionname

#execute script with an argument
source script.sh functioname argument

#or you just don't define function inside the script. Write execute line straight

#shell and environment variables
#script: echo $sex
#in bash environment sex=girl will not be accessed by my script. If I want to pass the value:
sex=girl bash script.sh #this is how value is in front then name argument and redirection followed up shown in the first lecture
#or
export sex
bash script.sh #will work

```



## Lecture 6 Git

###  Introduction

1. Version Control: a category of software tools that help a software team manage changes to code over time

2. 2 types of Version Control & their pros n cons
   1. Centralized: 
      - Only developer can write back the changes at a time. 
      - Need internet connection to work.
   2. Distributed: 
      - Everything but pushing and pulling can be done without an internet connection. 
      - Share changes with a subset of development team at first, then the whole group.
      -  Iterate fast locally.  
      - Create a provenance chain as you work locally(can be useful even if not developing with others)



### Git Workflow

1. **Git init:** 

   - Create an empty git repo or initialize an exisiting repo

   - Git init will create a .git hidden directory in the directory that you git init

2. **Git status:** 

   - To show the working tree (directory) status

3. Staging(index): we could work on multiple updates or features, stage one feature, commit that one feature for commit, while the other files which may be imcomplete remain in the working directory

4. **Git add filename/git add --all:**

   - To move files from working tree to index

5. **Git commit -m"":**

   - Save files to HEAD of the commit log

6. 🔸**Git log:**

   - To examine all the commits in a repository
   - commit number is tracked using sha-1 hash, developers are moving towards sha-256 hash
   - hash? for identification purpose
   - sha-1 hash for 2 bash scripts of exactly same keystrokes will be the same, does it mean the commit of the 2 files of the same sha-1 will have same sha-1 for commits? My answer is no but need validation (read the anatomy of a git commit)
   - **git log -- filename:** git log for specific file
   - **git log --max-count=2**: only show 2 recent commits log

7. 🔸**Git blame filename:**

   - For each line of the code, can check who made the change at when
   - ❓what's the ^238035c doing?

8. ❓🔸**Git reset** 

   - **Git reset HEAD~:** like undo, one step before
   - if you just staged a file git reset HEAD will unstage it
   - if you already commited, you need to git reset HEAD~ to uncommit
   - git reset --soft HEAD or head sha-1 will keep changes in your file but undo the commit
   - git reset --hard HEAD or head she-1 will discard changes in your file and undo the commit

9. Miscellaneous

   - **git ls-files:** show all files git is tracking
   - **git show firstfewlettersofsha1:**filename : show you snapshot of that file (as long as you have enough digits of the sha-1)
   - **git reflog show**: all past reset commit blahblah. fuller version than git log which doesn't contain reset

### Branches, Merging and Conflicts

1. **git branch -a** : show all branches
2. **git checkout -b branchname**: create a new branch
3. **git checkout branchname:** switch branch
4. **git merge branchname or path**: only merging when you are on master branch and merge branches, but not the other way round (when you are in a branch, you can't merge with master)

### Question

1. the part when he is explaining gitignore
2. reset or git show using the first few letters of sha1





## Lecture 7 Further Git

### SSH Identification

1. ❓What is ssh and it is used to identify user



### Interact with Server

1. Git remote

   - **git remote -v:** to show all remote url
   - **git remote add <name> <url> :** add a new remote repo

2. Git pull

   - **git pull <remotename><branchname> :** fetch and merge from where
   - ❓pull is a shorthand for git fetch followed by git merge fetch_head

3. Git push

   - **git push <remotename><branchname>:** 

     - when it is your first time push to a remote, do **git push <remotename><master>.** after that other time you can just do git push




### Git Workflow

1. 🔸Read up:
   - <https://www.atlassian.com/git/tutorials/comparing-workflows>
2. Centralized workflow
3. Feature branch workflow
4. Fork and pull workflow



### Complete Git Workflow

1. Terminology: remote upstream(where you fork the repo), remote origin(your fork), local repo
2. You fork a repo from somewhere:
   - git clone ssh
   - git add, git commit
   - git push (sometimes it will ask you to set up upstream to your fork. depends)
   - pull request
   - git remote add upstream <ssh of remote upstream>
   - git fetch <remotename><branchname>    #fetch from where
   - git merge <remotename><branchname>   #merge with whom
   - OR git pull <remotename><branchname>  #pull from where
3. You create a local repo and want to push it to remote origin
   - git remote add <remotename><ssh>
   - git add, git commit as per normal
   - git push --set-upstream upstream master (set up the master branch in the remote repo. if you forget and git push, git will prompt you to set up too)
   - git push <remotename><branchname> for the first time and subsequently just git push (branchname may be master)

## Lecture 8 Python Introduction

### Python in Bash

```bash
#execute python command
python -c "print('hello world')

#execute python script
```



### Types

1. Check type: 

   - type(). isinstance(object,type)

   - ```python
     isinstance(1.0, float)
     ```

   - 6 principal built-in types: sequences, numerics, mappings, classes, instances and exceptions

2. Text sequences: 

   - Strings are immutable sequences of Unicode code points and can be represented 3 different ways

3. ```python
   a = 'Hello'
   b = "World"
   d = """
   This is
   a really
   long sentence. And
   really useful for documentation of functions
   or other python related code.
   """
   ```

   - Has order:

   - ```python
     #index
     print(a[0])
     print(a[-5])
     
     #slice, last position not included
     print(a[0:2])
     print(a[0:])
     print(a[-2:])  #add total string length to convert the negative
     print(a[:-3])  #hello will print 'he' cos -3+5=2, so only print first 2 digits
     ```

   - Immutable

4. Numeric Types:

   - integers
   - floating point numbers
   - complex numbers
   - Comparison: logic operands and 'is'/'is not'

5. Boolean Types:

   - Boolean operators: and, or, is, not

6. Tuple

   1. ```python
      zs = (1,2,3,4)
      za = 1,2,34
      ```

      Without bracket also can create a tuple. Tuple index and slice are the same as above. Tuple is ordered but immutable.

7. List

   - ordered and mutable
   - zs = [1,2,3,4]

8. Set (not a sequence type)

   - unordered, but mutable
   - zs = {1,2,3,4}

9. Dictionary

   - not ordered, identified and indexed by key

   - ```python
     a = {
         'a': 1,
         type: 2,
         'c': 3,
         'hello world': 4,
         (1,2,3): 5
     }
     
     print(a.keys())
     print(a.values())
     ```


### Built-in functions and Methods

```python
help(len)
ord()
chr()

#string methods
s="hello world"
s.split() #split the string by space and returns a list
s.count() #count the number of characters in the string
s.lower() #change string to lower case
s.upper() #change string to upper case

#string format
print(
        "Hello {1:>20}, \nBuy a new {0:^16} in the neighborhood of ${2:<20,.1f}.".format(
        'Ben', 
        'Nissan Leaf', 
        20000.756
    )
)

#in bracket you can specify position of input, > means right align, < means left align, comma means add comma, .1f means 1 decimal place. ^ means center the input

```

### Question

1. how to create tuple, list, set and dictionary and add elements into them?

2. ```python
   #create tuple
   a = () or a = 1,2,3 or a = tuple()
   #create set
   a = set() a = {} #will make it a dictionary and you can't do a.append()cos dictionary doesn't have this function
   #create list
   a = [] or a = list()
   
   #create dictionary
   a = {} a = {1:2}
   #using dict is trickier, as dict only converts a tuple of list, with comma set in between to become dictionary
   a = dict(([1,2],[3,4])), and you can't only have one element inside. so use {} if you can
   #or you can do 2 list and zip them together
   dict(zip(lista,listb))
   
   #add element to tuple
   tuple is not mutable, so it doens't have a public function on append. but you can change tuple into a list first and append and change it back to tuple
   #add element to list. Can append to an empty list
   list.append() 
   #add element to set
   set.add()
   #add element to dictionary
   dictionary.udpate(), but what you append must already be a dictionary which can be defined as {}
   
   
   #indexing and slicing
   #the rest is as per normal, going through dictionary
   for key, value in dict.items()
   ```




## Lecture 9 Environment & Control Flow

### Environment

1. See all environments you have

   1. ```bash
      conda env list
      
      #see where the python executable is located beside the environment
      which python
      ```

2. Create a conda environment

   - ```bash
     conda create --name temporarypy35 python=3.5
     ```

3. Move to other environment

   1. ```bash
      source deactivate bios821
      source activate temporarypy35
      #list down all environments
      conda env list
      #list down all packages in the environment
      conda list
      ```

4. 🔸Get installed packages

   1. ```bash
      conda install -q <packagename>
      pip install
      ```

5. Export environment and create environment

   1. ```bash
      conda env export -n nameof environment > environment.yml
      conda env create -f environment.yml
      ```

6. Jupyter magic

   1. ```bash
      %lsmagic
      %% for cell magic
      % for line magic
      ```

      ### Control Flow

1. Range object

   1. ```python
      range(10) 
      #range(10) will return a range object(0,10), you need to define the object to be a list, or 4 variables or what
      a,b,c,d=range(4)
      a,*b,c=range(4) #b will be a list containing 2 elements
      ```

2. Variadic operator *:

   - it captures undetermined amount

3. For loop, while loop, if statement

   - ```python
     for i in range(10):
         print(i)
     ```

     ```bash
     for number in 1 2 3 4;do echo number;done
     ```

     ❗️For loop use iterables or iterators after in: if the thing is an iterable, it will be converted to iterators by iter function privately to become an iterator. these are explained in the next few lectures. All in all, iterables and iterators can both be used in loops.

4. With

   - ```python
     #watch out for f.write. there's no print function in wrapper
     with open('test.txt', 'w') as f:
         total=0
         number=1
         while total<30:
             total += 1
             number+=1
             if ((number % 13) == 0):
                 continue
             elif (number==17):
                 f.write('{:5}{:8}{:11}\n'.format(number, number**2, number**3))
                 break
             else:
                 f.write('{:5}{:8}{:11}\n'.format(number, number**2, number**3))
     ```

5. break,continue,pass:

   - break will stop the program
   - continue returns the control to the beginning of the while loop. The **continue **statement rejects all the remaining statements in the current iteration of the loop and moves the control back to the top of the loop.ext
   - pass does nothing

## Lecture 10 Iteration

### Introduction

```python
#enumerate function. enumerate function returns an enumerate object with iterator as index and iterable as value. So below returns 1,0|2,1|3,2
for i,x in enumerate(range(0,3,1)):
    print i,x
    
#pprint
import pprint
pprint.pprint(honey_do_list)
    
```

### Iterator

1. Definition:

   - The object that is allowing us to go through the list of items **once**.
   - An iterator is an object with the __next__ (Python 3) attribute.

2. Test use 'has attribute'

3. ```python
   z = range(3, 6, 1)
   print(hasattr(z,'__next__') #watch out the name of the function has to be in ''
   #returns false so range is not an iterator
   ```

4. Infinite iterator

5. ```python
   #iter(iterable) ->iterator
   #iter(callable, sentinel) ->iterator will iterate until sentinel is flagged to terminate. So if sentinel is not defined, it's infinite
   infinite = iter(set,0)
   hasattr(infinite,'__next__')
   print(next(infinite))
   print(next(infinite))
   print(next(infinite))
   print(next(infinite))
   ```

6. Dictionary iterator: only iterate keys

   ```python
   dictionary.items()
   #this is an iterable that iter through both keys and values
   ```


### Iterable

1. Definition: an object that has an __iter__ method which returns an **iterator**.

2. Code

3. ```python
   #range is an iterable but not an iterator
   a=range(3,6,1)
   print(hasattr(z,'__next__')) #return false
   #change a into an iterator
   aiter=iter(a)
   print(next(aiter)) #return 3
   print(next(aiter)) #return 4
   print(next(aiter)) #return 5
   print(next(aiter)) #stopiteration
   
   ```



   **when loop through next(iterator), remember to use the same iterator. If you initiate a new iterator, next(iterator) will start from the beginning.**

   ### List Comprehension

   ```python
   #apply some function to each element
   [x.upper() for x in honey_do_list]
   
   #pick the element that meets a certain criterion
   [x for x in honey_do_list if x not in ['Done!', 'place holder for more work']]
   
   #set comprehension
   {x.upper() for x in honey_do_list}
   
   #dictionary comprehension
   d = {x:i for i,x in enumerate(honey_do_list)}
   {key.upper():value for key,value in d.items()}
   [(x, y) for x in honey_do_list for y in status] #will give cartesian product
   
   #tuple comprehension will return a generator object
   ```


## Lecture 11 Functions & Generators

### Function

1. Always write a docstring inside the function """ """

2. Function argument

   - default argument (keyword argument): with keyword before equal sign. if new arguments are passed into function with default argument, default arguments will be overwritten
   - non-default argument (positional argument)
   - arbitrary argument(*argument): can take a varible range of arguments

   ```python
   #doesn't work non default arguments have to be in front. 
   foobar(c=3, b=2, 1)
   #work
   foobar(1, c=2, b=3)
   ```

3. ❓Mutable default argument

   ```python
   #recommended to do like below.
   def function(a, b=none):
   	if b is none:
   		b=[]
   ```

4. a function is an object: 

   1. ```python
      def greeting(name,msg):
      	print(name+msg)
         
      print(type(greeting)) #return you class <function>
      ```

5. you can store a function in a variable

   1. ```python
      greetme = greeting
      print(greetme('emma','good morning'))
      ```

6. you can pass function as a parameter to another function

   1. ```python
      def say_again(func):
          func('emma')
          
      say_again(greeting)
      	
      ```

7. you can return the function from a function and define a function within a function

   1. ```python
      def introvert(text):
          def quiet(input):
              return input.lower().replace('!','.')
          return quiet(text) 
      
      introvert("Hi Pam! I haven't seen you in forever!")
      
      #quiet function only lives inside introvert, if you type(quiet), it doesn't exist
      ```

8. you can store function in a dictionary

1. ```python
   speak = {
       'yell': a_little_bit_louder_now,
       'whisper': a_little_bit_softer_now
   }
   speak['yell']('hello.')
   ```



### Scoping Discussion



1. Veriadic argument

   - used to pass variable-length arguments to a function
   - non-keyworded(*): there's only argument like 1,2,3,4 passed in
   - keyworded(**): there's argument passed in like a=4. star and double stars are just naming conventions
   - why do we need this keyworded and nonkeyworded.
     - specifying what kind of arguments we are passing in
   - 

   ```python
   #example 1
   def foobar(*args, **kwargs):
       print(args)
       print(kwargs)
   
   foobar([1,2,3],[4,5,6],a=4,b=2)
   #return value ([1, 2, 3], [4, 5, 6])
   {'a': 4, 'b': 2} tuple and dictionary
   
   #example 2
   def type_dict(*args, **kwargs):
       arg_dict={x:type(x) for x in args}
       #use key,value in kwargs.items()cos kwargs receive as a dictionary
       kwarg_dict={value:type(value) for key,value in kwargs.items()}
       return arg_dict, kwarg_dict
       
   type_dict(1, 2.0, 3j, 'hello', a=1, b=2.0, c=3j, d='hello') 
       
   ```

2. Try:, except:

### Anonymous Functions

1. Anonymous functions: functions without a name

   - why would you use these? `lambda` (or anonymous) functions are usually given **as an argument** to a **function which expects a function object**

   - ```python
     #returns 3,9,27
     funcs = [lambda x: x, lambda x: x**2, lambda x:x**3]
     for func in funcs:
         print(func(3))
     ```

2. Map

   - ```python
     #map takes the value from the iterator and pass to the function, returns an iterator
     #map(func, *iterables) --> map object
     
     z=map(lambda x: x**2, range(5))
     next(z) #returns 0,1,4,9....
     #can use this in a for loop
     for i in map(lambda x: x**2, range(5)):
         print(i)
     
     #moreover, you can pass multiple iterables
     zz = map(lambda x, y, z: x*y, range(3), (7,8,9), [1])
     next(zz)
     #iteration stops when the shortest iterable exhausts
     ```

3. Filter

   1. ```python
      #filter: filter(function or None, iterable) --> filter object
      
      #Return an iterator yielding those items of iterable for which function(item) is true. If function is none, returns the items that are true
      filter(lambda x: x % 2 == 0, range(14))
      
      z = filter(None,[True,False,False,True])
      list(z) returns true true
      
      #in for loop
      for i in filter(lambda x: x % 2 == 0, range(14)):
      	print(i)
      ```

4. Reduce

   1. ```python
      #reduce is no longer an in-built function in latest version of python
      from functools import reduce
      print(reduce.__doc__)
      
      #reduce(function, sequence[, initial]) -> value. add sequence together
      #Apply a function of two arguments cumulatively to the items of a sequence,
      #from left to right, so as to reduce the sequence to a single value.
      
      a = reduce(lambda x, y: x+y, [1, 2, 3, 4, 5])
      a prints out to be 15
      
      ```

      ### Decorator

      ```python
      def my_decorator(func):
          def wrapper():
              print("Something is happening before the function is called.")
              func()
              print("Something is happening after the function is called.")
          return wrapper
      
      say_whee = my_decorator(say_whee)
      
      or 
      @my_decorator
      def say_whee():
          print(say_whee)
      say_whee
      #automatically wrapped
      ```

      ### Generators

5. A Python *generator* is **a function** which **returns a *generator iterator*** (just an object we can iterate over) by calling `yield`

   - so generator is a function, the result it returns straightaway is an iteractor that has next attribute. Need to call yield

   - ```python
     def all_even():
         n = 0
         while True:
             yield n
             n += 2
             
     def generator(x, y):
         for i in range(x):
             for j in range(y):
                 yield(i, j)
     ```

6. Generator Expression

   - tuple comprehension

   - why is this good? it won't store everything inside the variable like list comprehension does, it only stores partially, and go with the flow

   - ```python
     #ge is a generator expression that is an iterator and can use next
     ge = (x for x in range(1000000))
     print(next(ge))
     
     #example 2
     def generator_expr(x, y):
         return ((i, j) for i in range(x) for j in range(y))
     
     #get size of a generator or anything else
     from sys import getsizeof
     print(getsizeof(ge))
     print(getsizeof(alist))
     
     #difference between generator(Tuple comprehension) and list comprehension. generator is straightaway an iterator, but list is an iterable.
     next(ge)
     aiter=iter(alist)
     next(aiter)
     ```



## Miscellaneous

### Documentation

1. In bash

   - man <function name>
   - <function name> --help

2. In python

   - ```python
     #print docstring
     print(<function name>.__doc__)
     print()
     help(len)
     
     #list down all attributes of an object in a class
     a=list()
     dir(a)
     
     # test type, attribute, instance
     type(a)
     hasattr(dict,'__doc__')
     isinstance(1.1, float)
     ```



## Lecture 12 Functional Programming and Iterational Algebra

### Functional Programming

1. Paradiagm:

   - **Procedural** - lists of instructions that tell computer what to do (egs. C, Pascal, **Unix Shells**).
   - **Declarative** - write a specification that describes the problem to be solved (e.g. SQL).
   - **Object-Oriented** - manipuate collections of objects (e.g. Java - python supports this paradigm, but doesn't force).
   - **Functional** - decomposes a problem into a set of functions (e.g. OCaml, Haskell various implementations based on purity).

2. Why would someone argue python is not a pure functional programming language

   - Functional style discourages functions with side effects that modify internal state or make changes not visable in the function's return value. If there are no side effects, it is said to be a **purely functional** language. 
   - There are functions in python such as print which doesn't return a valuable value. and we can also write functions that way, therefore python is not pure functional
   - Some languages serious about purity don't even allow assignment statements

3. Why would people work under such constraints?

   - Formal Provability. *Finding mathematical proofs that programs are correct*
   - Modularity. *Forces you to break apart your problem into small managable pieces (See Curly's Law Above)*
   - Composability. *Inevitably you will end up reusing functions for other purposes*
   - Ease of debugging and testing. *Self Explanatory*

4. What does it mean to program functional programming in python

   - Won't go to the extreme of avoiding all I/O
   - Don't avoid all assignments. Provide functional appearing interface, but use non-functional features internally (use assignment inside a function).

5. Example: overall functional programming won't assign variable outside functions and functions return values(ben's email)

   - ```python
     #why this is not functional? cos it assigns values outside of function
     test = 'hello world' #this is a global variable
     def example(a):
         a += 1
         print("a is now " + str(a))
         return a
         
     #why this is?because there's no assignment of value outside the functions and function returns values
     def example(a):
         a += 1
         print("a is now " + str(a))
         return a
     ```

6. Motivation for functional programming

   - ```python
     color_percentage = {
         'green': 0.5,
         'red': 0.35,
         'blue': 0.1,
         'black': 0.05
     }
     #generate a list of color points that follow this percentage
     def color_creator(meta_dict, n):
         """
         color_creator(meta_dict, n) -> list 
         
         Returns a list of keys from input dictionary. The number of occurances of each key is specified 
         and proportional to the percentages conveyed in the values attribute of the dictionary.
         
         :type metadict: dict
         :type n: int
         :rtype: list
         """
         results = []
         for key, value in meta_dict.items():
             results.extend([key]*int(n*value))
         return results
     
     print(results.extend.__doc__)
     #L.extend(iterable) -> None -- extend list by appending elements from the iterable
     
     #string*value will print out the value number of strings
     #extend will iterate through the iterable and append the whole list of iterable, if we don't put[]around key, it will print out each alphabet of the key and attach
     3*[1]=[1,1,1]
     3*['green']=['green','green','green']
     3*'green'='greengreengreen'
     ```

7. ❓But the above function iterates through things, so it is not doing one thing at a time. so you mean functional programming can't have for loops?! isn't the below list comprehension an implicit for loop

   1. ```python
      def one_color_creator(color, percentage, total):
          """
          one_color_creator(color, percentage, total) --> list 
          
          Returns a list of color specified. The number of occurances returned equal int(percentage*total).
          
          :type color: str
          :type percentage: float
          :type total: int
          :rtype: list
          """
          return [color]*int(percentage*total)
      
      #this is doing one thing at a time, but why will it return a list but not a tuple? is it because [color] is a list? yes
      
      #in function call, we use list comprehension which is an implicict iteration
      [one_color_creator(key, value, 140) for key, value in color_percentage.items()]
      
      #above code is giving us a list of list, how to not? this is itertools
      ```



### Itertools

1. itertools.chain: Chain up list of list to become one list

   - ```python
     from itertools import chain
     import itertools
     
     print(chain.__doc__)
     #output chain(*iterables) --> chain object
     
     #Return a chain object whose .__next__() method returns elements from the
     #first iterable until it is exhausted, then elements from the next
     #iterable, until all of the iterables are exhausted.
     
     #will return a chain object,so specify list
     list(chain.from_iterable([one_color_creator(key, value, 140) for key, value in color_percentage.items()]))
     
     #or list(itertools.chain(same))
     ```

2. Exploring API

   - ```python
     import pprint
     import itertools
     pprint.pprint(dir(itertools))
     ```

3. collections.Counter - Count iterable - elements from a string(count number of alphabets for each alphabets) or from a list (count the number for each element)

   - ```python
     fake_data = color_creator(color_percentage, 140)
     from collections import Counter
     counts = Counter(fake_data)
     print(counts)
     #this will count the number of times each color appears in fake_data
     #fake_data is ['green','red','blue'....]
     ```

4. itertools.repeat - Use itertools to generate the random list of colors. how does the backslash allow different colors generated in different lists to be in one list now?

   - ```python
     #what does the backslash mean
     #repeat returns an iterator which returns the object for a specified number of times
     list(itertools.repeat('green',70))+ \
     list(itertools.repeat('red',70))+ \
     list(itertools.repeat('blue',70))+ \
     list(itertools.repeat('black',70))
     
     #map needs to apply function to 2 iterables as pow needs 2 argument. having itertools repeat enable us to have a list of 2, instead of using [2]*9 to produce a list
     list(map(pow, range(9), itertools.repeat(2)))
     #itertool.repeat will create an iterator which returns the object for the specified number of time. If not, returns the object endlessly
     ```

5. itertools. combination

   - ```python
     #permutation and combination
     print(itertools.combinations.__doc__)
     #combinations(iterable, r) --> combinations object
     
     #Return successive r-length combinations of elements in the iterable.
     
     #combinations(range(4), 3) --> (0,1,2), (0,1,3), (0,2,3), (1,2,3)
     
     #print all combination of 5 things in a
     zz = list(itertools.combinations(a,5))
     
     #below code gives you the number of combinations when you take 5 out of 69
     from scipy.misc import comb
     print(comb.__doc__)
     comb(69,5)
     
     #same as yy=list(itertools.combinations(range(1,70,1),5))
     
     ```

6. itertools.cycle - indefinitely loop through a range of numbers or things - gives a generator

   - ```python
     print(itertools.cycle.__doc__)
     #cycle(iterable) --> cycle object
     
     #Return elements from the iterable until it is exhausted.
     #Then repeat the sequence indefinitely.
     
     #cycle returns a generator in fact
     tng = itertools.cycle(range(1, 3, 1))
     print(hasattr(tng, '__next__'))
     print(next(tng))
     print(next(tng))
     print(next(tng))
     ```

     ```python
     #write out the cycle function explicitly
     def cycle(iterable):
         while True:
             yield from iterable
     
     #different method serving same purpose
     def cycle(iterable):
         # cycle('ABCD') --> A B C D A B C D A B C D ...
         saved = []
         for element in iterable:
             yield element
             saved.append(element)
         while saved:
             for element in saved:
                   yield element
         
     ```

7. itertools.islice: slice an iterator - generate first 175 numbers from 0-150 (looping back)

   - ```python
     print(itertools.islice.__doc__)
     #islice(iterable, stop) --> islice object
     #islice(iterable, start, stop[, step]) --> islice object
     
     #Return an iterator whose next() method returns selected values from an
     #iterable.  If start is specified, will skip all preceding elements;
     #otherwise, start defaults to zero.  Step defaults to one.  If
     #specified as another value, step determines how many values are 
     #skipped between successive calls.  Works like a slice() on a list
     #but returns an iterator.
     
     list(itertools.islice(itertools.cycle(range(1, 151)), 175))
     #islice needs an iterable, iterator works too as cycle is producing a generator (an iterator not having everything in memory)
     
     ```

8. Itertools combined usage - print numbers then alphabet

   1. ```python
      #first method using chain. chain will give an object that exhausts first iterable then the next. so it stops when both are exhausted, giving a list of 176 numbers
      import string
      list(itertools.islice(itertools.chain(range(1,151,1), string.ascii_lowercase), 185))
      
      #second methods adding in cycle, which gives a generator that loops through things indefinitely, giving a list of 185
      list(itertools.islice(
          itertools.cycle(
              itertools.chain(range(1,151,1), string.ascii_lowercase)
          ), 
          185)
          )
      
      ```






## Lecture 13 Object-Oriented Programming

### Scope and Namespaces

1. Namespace: 

   - Definition: a collection of names
   - Hierachy: 
     - Built-in namespace
     - Module: global namespace
     - Function: local namespace
   - Hierachy from top to bottom, inner namespace can't access to name definied in outer namespace unless you declare the variable to be nonlocal or global.
   - Module means a file containing python code. Once you create a python script, a global namespace is created
   - Similarly, when a function or a class is created, a local namespace is created

2. Scope:

   - Definition: Textual region of a Python program where a namespace is directly accessible

3. Attribute:

   - Definition: any name following a dot. For example, in z.real, real is an attribute of the object z.

4. Understanding:

   - ```python
     def scope_test():
         def do_local():
             spam = "local spam"
     
         def do_nonlocal():
             nonlocal spam
             spam = "nonlocal spam"
     
         def do_global():
             global spam
             spam = "global spam"
     
         spam = "test spam"
         do_local()
         print("After local assignment:", spam)
         do_nonlocal()
         print("After nonlocal assignment:", spam)
         do_global()
         print("After global assignment:", spam)
     
     scope_test()
     print("In global scope:", spam)
     ```

     ```python
     #output
     After local assignment: test spam
     After nonlocal assignment: nonlocal spam
     After global assignment: nonlocal spam
     In global scope: global spam
     ```

   - The **nonlocal** statement causes the listed identifiers to refer to previously bound variables in the nearest enclosing scope excluding globals.  

   - The **global** statement is a declaration which holds for the entire current code block. 

   - ❗️My understanding: declare the variable as nonlocal allows the variable to access to variable in one level up. declare the variable as gloabl allows the variable to access to variable 2 levels up in the global namespace. However, as the do_global() is called still inside the function, which is a local space, it can't access to global namespace change ("global spam"), that's why it's still "nonlocal spam" (draw a diagram should be clearer)



   ### Class

   1. Definition:

      - *Classes provide a means of bundling data and functionality together. Creating a new class creates a new \type* of object, allowing new **instances** of that **type** to be made.* - Python 3 documentation

   2. Syntax

      - ```python
        class MyClass:  
            """A simple example class"""  
            i = 12345
        
            def f(self):
                return 'hello world'
        ```

      - *data attributes* correspond to “instance variables”

      - ```python
        MyClass.i
        MyClass.f
        #output - <function __main__.MyClass.f(self)>. it says that the variable myclass.f(self) exists in the function main namespace
        ```

      - The other kind of instance attribute reference is a **method**. A method is a function that “belongs to” an object.

      - ```python
        #method
        Myclass.f()
        #output - TypeError: f() missing 1 required positional argument: 'self'. this is because we haven't created a Myclass object yet. Self refers to one Myclass object
        
        #instantiated an object x of the class Myclass
        x=Myclass()
        x.f() #prints hello world
        ```



   ### Class Methods

   1. \__init__ function

   - Many classes like to create objects with instances customized to a specific initial state. Therefore a class may define a special method named \__init__().

   - the \__init\__() method may have arguments for greater flexibility. In that case, arguments given to the class instantiation operator are passed on to \__init\__().

   - ```python
     class MyClass:
         """A simple example class"""
         def __init__(self, temp):
             print('MyClass instantiated.')
             self.temp = temp
     
         def f(self):
             return 'hello world'
     ```

   2. \__user-defined-method__

      - \__repr__

        - Return a string containing a printable representation of an object. For many types, this function makes an attempt to return a string that would yield an object with the same value when passed to eval(), otherwise the representation is a string enclosed in angle brackets that contains the name of the type of the object together with additional information often including the name and address of the object. A class can control what this function returns for its instances by defining a __repr__() method.

        - ```python
          class MyClass:
              """A simple example class"""
              def __init__(self, temp):
                  self.temp = temp
              i = 12345
              
              def __repr__(self):
                  return '<my stuff at 0x{},{}>'.format(id(self),self.temp)
          
          
              def f(self):
                  return 'hello world'
              
           MyClass(temp=43)
           or
           x=MyClass(temp=43)
           x
           #output as below
           <my stuff at 0x4361618544,43>
           #will auto print out __repr__format
          ```

      - \__str__

        - Return a string version of object.

        - ```python
          def __str__(self):
                  return str(self.i)
              
          #seems when __repr__ exists, __str__will not work
          ```


   ### Inheritance

   ```python
   class Vehicle:
       def __init__(self, numwheels, color):
           self.numwheels = numwheels
           self.color = color
           
       def __repr__(self):
           return '<vehicle at 0x{}, numwheels={}, color={}>'.format(id(self), self.numwheels, self.color)
           # or use return '<{} at 0x{}>'.format(self.__class__.__name__, id(self))
           # so that if it's bus string prints out class name as bus instead of vehicle
    
   class Bus(Vehicle):
       """Class Bus inherits from Vehicle."""
       def __init__(self, mpg,numwheels,color):
           self.mpg = mpg
           super().__init__(numwheels, color)
           
   bus = Bus(mpg=32, numwheels=4, color='red')
   ```



   ### Private Attribute

   1. _attribute is a private one: This indicates an attribute which should not be used accept by the class itself. The api to that attribute is `not open for business`.

### Property

1. ❓\__dict__ allows you to print out a dictionary of attributes in a class. Pay attention to the flexible string representation below. also is this dict only works if there are values passed into init? in homework battery has no passed in argument, so dict didn't work

2. ```python
   class Vehicle:
       def __init__(self, numwheels, color, speed):
           self.numwheels = numwheels
           self.color = color
           self.speed = speed
           
       def __repr__(self):
           """Flexible string representation for any number of initialized variables."""
           return '{} at 0x{}({})'.format(
               self.__class__.__name__,
               id(self),
               ', '.join('{}={}'.format(k, v)
                         for k, v in sorted(self.__dict__.items())))
       
       
       #__dict__only works if we define __repr__ this way or it also works for classes defined in other way
   ```

   3. On the join method above: a = [‘hello’, ‘world’, ‘galaxy’], now try ‘’.join(a) or ‘, ‘.join(a) or  ‘@@@’.join(a). Notice how it combines elements of a sequence into a string with the appropriate delimiter

      1. ```python
         a = ['hello', 'world', 'galaxy']
         b=' '.join(a)
         c=', '.join(a)
         d='@@@'.join(a)
         
         print(a)
         print(b)
         print(c)
         print(d)
         
         #['hello', 'world', 'galaxy']
         #hello world galaxy
         #hello, world, galaxy
         #hello@@@world@@@galaxy
         ```

   4. Drawback above is that speed is a public attribute of the class, everyone can do self.speed=1000 to change the value of the speed. Therefore, we should force speed to be changed by a method, not a number. That is called making speed to be 'private' that is only changed by method

   5. ```python
      class Vehicle:
          def __init__(self, numwheels, color, speed):
              self.numwheels = numwheels
              self.color = color
              self.set_speed(speed)   #assign using method not by pure value
              
          # new update
          def get_speed(self):
              return self._speed
      
          def set_speed(self, value):
              if value > 150:
                  raise ValueError("Speed Exeeds the maximum allowable value.")
              self._speed = value
              
          def __repr__(self):
              """Flexible string representation for any number of initialized variables."""
              return '{} at 0x{}({})'.format(
                  self.__class__.__name__,
                  id(self),
                  ', '.join('{}={}'.format(k, v)
                            for k, v in sorted(self.__dict__.items())))
      ```

   6. Use property

      - ```python
        print(property.__doc__)
        
        property(fget=None, fset=None, fdel=None, doc=None) -> property attribute
        
        fget is a function to be used for getting an attribute value, and likewise
        fset is a function for setting, and fdel a function for del'ing, an
        attribute.  Typical use is to define a managed attribute x:
        
        class C(object):
            def getx(self): return self._x
            def setx(self, value): self._x = value
            def delx(self): del self._x
            x = property(getx, setx, delx, "I'm the 'x' property.")
        
        Decorators make defining new properties or modifying existing ones easy:
        
        class C(object):
            @property
            def x(self):
                "I am the 'x' property."
                return self._x
            @x.setter
            def x(self, value):
                self._x = value
            @x.deleter
            def x(self):
                del self._x
        ```

   7. Refactor to property

      - ```python
        class Vehicle:
            def __init__(self, numwheels, color, speed):
                self.numwheels = numwheels
                self.color = color
                self.speed = speed  #still assign to value as per normal. standard
                
            # new update
            def get_speed(self):
                print('getting value ')
                return self._speed
        
            def set_speed(self, value):
                print('setting value ')
                if value > 150:
                    raise ValueError("Speed Exeeds the maximum allowable value.")
                self._speed = value
                
            speed = property(get_speed, set_speed) 
            #add this command so that when get value and set value the 2 methods will be called
                
        ```

        or use decorator easier

        ```python
        class Vehicle:
            def __init__(self, numwheels, color, speed):
                self.numwheels = numwheels
                self.color = color
                self.speed = speed
            
            @property
            def speed(self):
                print('getting value ')
                return self._speed
        
            @speed.setter
            def speed(self, value):
                print('setting value ')
                if value > 150:
                    raise ValueError("Speed Exeeds the maximum allowable value.")
                self._speed = value
                
        ```

      - Learning from Homework 7: declare speed as speed in init and attach properties to it. so that you can assign numbers to speed and call speed as per normal - self.speed=100, however every time you call self.speed or assign value, getter and setter will wake up and help you handle things, and they modify self.speed through the private self.speed which is written as self._speed. But watch out you shouldn't call self.\_speed straight as it will skip all property methods and amend the hidden value straight away which causes problems.



### Multiple Inheritance

```python
class A:
    def hereiam(self):
        print("In A")

class B(A):
    def hereiam(self):
        print("In B")

class C(A):
    def hereiam(self):
        print("In C")
        
class D(B, C):
    def hereiam(self):
        print("In D")
        
# if method in the child class is not specified it will inherit from its first parent, or else it will print its own method defined. That's why if you initialize 4 classes and call hereiam, it will print each of their own alphabet. But if you don't define class D's method, it will print out B as B is its first parent

d=D()
D.__mro__ #method resolution order
#output [__main__.D, __main__.C, __main__.B, __main__.A, object] namespace of D first then C then B and lastly A this is becauce class D(C,B) now
```



- Directed Acyclic Path

- ```python
  class X:pass
  class Y: pass
  class Z:pass
  class A(X,Y):pass
  class B(Y,Z):pass
  class M(B,A,Z):pass
  ```


## Lecture 14 Import

1. Definitions

   - The import statement combines two operations; it searches for the named module, then it binds the results of that search to a name in the local scope.
   - module`: a file with the `*.py` extension
   - `built-in module`: a module written in `C` that is compiled not in the Python interpreter. Does not have `*.py` extension.

2. Example

   - ```python
     import numpy
     print(numpy.__file__)
     #/Users/nn31/anaconda/envs/bios821/lib/python3.5/site-packages/numpy/__init__.py
     #it points to __init__.py code under the numpy directory
     ```

3. Type of packages:

   - Regular packages: a top level folder containing an \__init__.py file. and all files reside in one directory
   - Namespace packages: don't really need all files to be in the same directory

4. Create a package example - tree gta3 doesn't work

   - ```bash
     cd ~/bios821
     cat makegta3.sh
     #!/bin/bash
     
     function usage() {
         echo "usage: makegta3 [-h help] [\$1 full path to start] [\$2 name of package]"
         echo "A utility to build the api structure for the python package gta3"
         echo "  -h      help documentation for makegta"
         echo "  \$1     Absolute path to begin setup of python package"
         echo "  \$2     Name of package"
         exit 1
     }
     
     
     if [[ "$1" == "-h" ]]; then 
        usage
     else
        mkdir $1/$2
        touch $1/$2/__init__.py
        mkdir $1/$2/vehicles
        touch $1/$2/vehicles/__init__.py
        mkdir $1/$2/person
        touch $1/$2/person/__init__.py
        mkdir $1/$2/vehicles/bus
        touch $1/$2/vehicles/bus/__init__.py
        mkdir $1/$2/vehicles/bike
        touch $1/$2/vehicles/bike/__init__.py
     fi
     echo "setup of gta3 complete at $1/$2"
     exit 0
     
     cd ~/bios821
     [[ -d gta3 ]] && (echo 'deleting gta3'; rm -r gta3; bash makegt3.sh . gta3) || bash makegta3.sh . gta3 
     echo "--------------------------------------"
     echo "Exit Status from previous command: " $?
     
     #tree gta3 
     #brew install tree in order to use tree
     ```

   - ![image-20181107165330618](/var/folders/hz/jmpmlv_s7pn8g0zwjjcnn4l80000gn/T/abnerworks.Typora/image-20181107165330618.png)

   - ❗️So based on the above, gta3 is a package because its top level folder contains an \_init_.py.  but numpy is its top level folder contains a numpy folder again, and then init.py? do you call person and vehicle as package too? yes, so gta3 directory has a gta3 folder underneath, then it's init.py. you can call person adn vehicle packages too. Essentially the above tree graph can help you understand how to import things. For example, if you want to import the person class, it is from person.person import Person (in his actual gta3, under person there's another person.py)

5. Import flow

   - When a module (or package) named `spam` is imported, the interpreter first searches for a built-in module with that name. If not found, it then searches for a file named `spam.py` (or a folder named `spam`) in a list of directories given by the variable `sys.path`. `sys.path` is initialized from these locations:
     - The directory containing the input script (or the current directory when no file is specified).

     - PYTHONPATH (a list of directory names, with the same syntax as the shell variable PATH).

     - The installation-dependent default.  

     - ❗️How do i see the hierarchy of sys.path? what is this sys thing?

     - ```python
       import sys
       sys.path
       #output is your current folder, and then all other folders related to anaconda. Therefore, when you create a pseudo numpy in your current folder, python will return that package to you instead of going into anaconda to get ther real thing
       ```

   - After initialization, Python programs can modify sys.path. The directory containing the script being run is placed at the beginning of the search path, ahead of the standard library path. This means that scripts in that directory will be loaded instead of modules of the same name in the library directory

   - ❗️Let's play a bit: if a create a numpy directory with \__init__.py and numpy.py in it, when i import numpy, will the print(numpy file) address point to my bios821 directory instead of the library?yes it should. is the numpy.file function a sys function? why would we need import sys? No. numpy.file should be a numpy function.  import sys is to use sys.path

     - ```python
       import numpy
       print(numpy.__file__)
       #currently it is here
       /anaconda3/lib/python3.6/site-packages/numpy/__init__.py
       
       ```

       ```bash
       #why this is printint numpy's __init__ instead of file address as it should be for numpy.__file__?
       numpyinit=$(python -c "import numpy; import sys; print(numpy.__file__)")
       cat $numpyinit
       ```

6. Revise heredoc: read in python command instead of always do python -c ""

   1. ```bash
      cd ~/bios821
      python <<EOF
      import gta3
      import pprint
      pprint.pprint(dir(gta3))
      EOF
      ```

7. ❗️Why is our "api" not being exposed? Let's take a look at numpy on github and see if we get any clues? We can't see our apis because we haven't written more python modules under the package and imported them using \__init__.py.  So you mean, if we write methods under the package, we need to import those methods in the final top level init.py?



## Leture 15 Get Data

### Stdin and Stdout

1. Python

   - ```python
     temp=input("What is temperature today?")
     #python will prompt user to key in value and that value will be stored in temp
     print(temp)
     ```

2. Command line

   - ```bash
     %%bash
     cat fu.txt | python egrep.py "fu\b"
     cat fu.txt | python egrep.py "fu\b" | python wc_l.py
     ```

     ❓how is egrep.py written? how is the python script reading in the parameter? what is wc_l.py? is it to standard out and print into something? (check out ben's code, you need to import sys and re (regular expression) to write the code.)

     ```python
     #python version of egrep
     import sys, re
     regex = sys.argv[1]
     for line in sys.stdin:
         if re.search(regex,line):
             sys.stdout.write(line)
     ```

     ```python
     #python version of count
     import sys
     count=0
     for line in sys.stdin:
     	count += 1
     	
     print(count)
     ```




   ### Text File

   1. Get csv file from online in bash

   ```bash
   #get a csv file from online and save it into a csv file
   wget https://data.michigan.gov/api/views/abnc-xaus/rows.csv?accessType=DOWNLOAD
   cat rows.csv?accessType=DOWNLOAD > bottle.csv
   ```

   2. Read everything in the file as a big string

   ```python
   #r means open for reading, w means open for writing, x means create a new file and open for writing, a means open for writing, appending to the end of the file if it exists
   d = open('bottle.csv', 'r')
   type(d) #d is of _io.TextIOWrapper
   print(dir(d)) #prints out the methods in this class TextIOWrapper
   data=d.read() #type of data is a big string, result of using read()
   d.close()
   
   ```

3. Read everything in as rows

   - ❗️So csv.DictReader is giving us on dictreader object, and this object is full of orderedDict? What's the link…between dictreader object and orderedDict? Can use other class to give me an example? Each row is an ordereddict - it doesn't look like the normal format of a dict at all. tuple of list of tuple, each tuple contains the key, and the value. pandas use mostly. dictionary sequence comes up the same all the time.
   - So dictionary is not ordered, so the sequence every time is different. To have fixed sequence, we need to use orderedlist, and this list of tuple thing is just how the developer decides to represent it. A list of tuples is still a list of tuples, it won't be automatically detected as dictionary

4. ```python
   import csv
   d = open('bottle.csv', 'r')
   reader = csv.DictReader(d)
   print(reader) #dictreader object has next attribute, it is an iterator
   type(reader) #dictreader object
   for line in reader:
       print(line)
   d.close()
   
   
   ```

   ```python
   #output
   OrderedDict([('Building', 'Fire Station #1'), ('Location', '310 East 5th St.\nFlint, MI 48502\n(43.01317, -83.683628)'), ('Point Size', '30')])
   OrderedDict([('Building', 'Fire Station #3'), ('Location', '1525 Martin Luther King Ave.\nFlint, MI 48503\n(43.030063, -83.702738)'), ('Point Size', '30')])
   OrderedDict([('Building', 'Fire Station #5'), ('Location', '3402 Western Rd.\nFlint, MI 48506\n(43.045306, -83.655453)'), ('Point Size', '30')])
   OrderedDict([('Building', 'Fire Station #6'), ('Location', '716 West Pierson Rd.\nFlint, MI 48505\n(43.060945, -83.714712)'), ('Point Size', '30')])
   OrderedDict([('Building', 'Fire Station #8'), ('Location', '202 East Atherton Rd.\nFlint, MI 48507\n(42.988979, -83.672222)'), ('Point Size', '30')])
   ```

### Text File with With

1. Typical usage - read, manipulate data and at the end of with, file will be auto closed instead of us specifying close

1. ```python
   data = []
   with open( 'bottle.csv', 'r' ) as theFile:
       reader = csv.DictReader(theFile)
       for line in reader:
           # line is { 'workers': 'w0', 'constant': 7.334, 'age': -1.406, ... }
           # e.g. print( line[ 'workers' ] ) yields 'w0'
          data.append(line)
   import pprint
   pprint.pprint(data)
   #print out a list of ordereddict, each ordereddict is an element
   ```

   ```python
   #pull out all unique zip codes from this data set,substitute the end of line characters for a space,create two new key value pairs?
   def subit(thing):
       #store the value that key 'Location' attaches to and remove it
       loc = thing.pop('Location')
       #print out the value that is removed
       print(loc)
       #substitute the end of line for location with a space
       thing['Location'] = loc.replace('\n', ' ')
       return thing
   #data is a dictreader object which is an iterator, so for each element in dictreader data, which is an ordereddict, we apply subit to the ordereddict, which substitutes the end of line with space
   new_data = list(map(lambda item: subit(item), data))
   ```

   2. Open with for writing a file

   3. ```python
      #first try, not working
      with open('bottle_cleaned.csv', 'w') as f:
          for item in new_data:
              f.write(item)
              
      #error message
      write() argument must be str, not collections.OrderedDict
      ```

      ```python
      #second try, use csv package
      #first find keys of the first ordereddict element in the list
      keys = new_data[0].keys()
      with open('bottle_cleaned.csv', 'w') as output_file:
          dict_writer = csv.DictWriter(output_file, keys)
          dict_writer.writeheader()
          dict_writer.writerows(new_data)
      ```

      ❗️For the methods in csv package, there's no (csv.DictWrter.\__doc__)...how do i know how to use each method in the csv package then? and also, for the dictwrite obejct dict_writer, there's also no documentation on writeheader and writerows, how do I delve deeper? use help(csv.Dictwriter). why help didn't work is because i still have the .doc inside. Also, use pycharm and 'go to declaration' to see the source code to truly understand the construct


### Tab-delimited Files

1. "flat files" come in many flavors, bar delimited, colon delmited, etc. The above is a generic way to create a data pipeline into python.

2. ```python
   data = []
   with open('stock.txt', 'r') as f:
       reader = csv.reader(f, delimiter='\t')
       #reader is an iterator, with each entry separated by \t an element
       for line in reader:
           date = line[0] #so each line is a list?  and we indexing each element
           symbol = line[1]
           price = line[2]
           data.append({'date': date, 'symbol': symbol, 'price': price})
           
   pprint.pprint(data)
   ```

   ❗️is each line a list? you can check by type(line), maybe a tuple as well



### Restful APIs

1. Definition: Representational State Transfer. It is sometimes spelled "ReST". It relies on a stateless, client-server, cacheable communications protocol -- and in virtually all cases, the HTTP protocol is used. (you mean like a website?)

2. Unauthenticated API:

   1. In bash: how we pull using restful API

3. ```bash
   curl https://api.github.com/users/benneely/followers
   ```

   	So this is pulling down a json file filled with Ben's followers' info?

   2. In python

   3. ```python
      import requests
      followers = requests.get('https://api.github.com/users/benneely/followers')
      followers #<Response [200]> followers is a response object
      dir(followers) #to see what attributes does a response class have
      
      followers.headers
      data=followers.json()
      type(data) #this may give you a list of dictionary if the data stored in json is actually in a list
      ```

      JSON - JavaScript Object Notation. Looks a lot like a python dictionary. A LOT of data travels the internet via JSON and RESTful APIs!

3.AUTHENTICATED API ENDPOINT for posting

```python
body = {
  "title": "Found a bug 2",
  "body": "I'm having a problem with this.",
}

import os
result = requests.post(
    'https://api.github.com/repos/benneely/betagit/issues',
    json=body,
    auth=('benneely', os.getenv('passwd'))
)
```

❓questions on, when we do requests.get how do we use auth? and how to we set password in an environment so that we can use os.getenv

❗️getenv is to get environmental variable from bash environment. So in bash, we define a environment variable and export it. In python, we import os and os.getenv, you will get the value of that environment variable



## Lecture 16 Numpy

### Data Dimensionality and Array Initialization

1. np.dtype

   1. ```python
      first=np.int8(0)  #0 is number 0, 8 is 8 bytes
      print(first.dtype) #data type - int8, not an array
      print(first.ndim)  #give 0 because it is not in an array, so no dimension
      print(first.shape) #give () because it is not in an array, so no shape
      type(first) #numpy.int8 - type gives data class object name, not data type 
      
      print(first.shape.__doc__) #doesn't work
      print(np.shape.__doc__) #works, for all other np attributes too
      ```

      different from type() which is a built-in function, dtype is an attribute of the class object, so use first.dtype instead of use type(first)

2. ndarray - how to initialize it

   1. ```python
      second=np.array(0)   #array takes in array like interface like [], or [[]] with existing values. If you only set up the structure, you can use np.zeros to fill up dimension with zeros as below
      secondtest=np.array([0]) #different from passing in 0
      secondtest2=np.array([0,1]) #takes in 1D array
      secondtest3=np.array([[0,1],[0,1]]) #takes in 2D array like stuff
      
      print(type(second))
      print(type(secondtest)) #both belong to numpy.ndarray
      
      print(second.dtype)
      print(secondtest.dtype) #both belong to int64
      
      print(second.ndim)  #gives 0
      print(secondtest.ndim) #gives number of dimension which is 1. in [] will be treated as 1D
      
      print(second.shape) #gives ()
      print(secondtest.shape) #gives (1,) means 1D and 1 element in this 1D
      print(secondtest2.shape) #gives (2,) means 1D and 2 elements in this 2D
      print(secondtest3.shape) #gives(2,2) means 2D and 2 element in x-axis, 2 element in y-axis
      
      
      ```

3. Convert list to ndarray

   1. ```python
      data=[2,5,9.6,0,6]
      dataarray=np.array(data)
      print(dataarray.dtype) #float64. Despite of integer, it recognize the whole array as float64
      print(dataarray) #array([2.0,5.0,9.6,0.,6.]) converting everything to float
      
      ```

      ❗️So does it mean that numpy array can only take in one data type? it will force the data type to standardize? unless we specify like in a structured array? It is more like, giving the most accomodating and complicated data type to the array. Numpy works the best for homogenous data whereas pandas is for heterogenous. But eventually we will convert pandas hetero to numpy's homo to easily compute things

4. Array 

   1. ```python
      #instantiate a 1D array with 0
      tenzeros=np.zeros(10) #produce an array of 10 zeros
      print(tenzeros.dtype) #float64
      print(tenzeros.ndim)  #1
      print(tenzeros.shape) #(10,) 
      
      #instantiate a 2D array with 0. Must specify dtype or there will be error
      tenzeros=np.zeros((2,5), dtype='float32') #produce an array of 2 rows and 5 elements for each row, data type to be float32
      
      #instantiate a 2D array with 1
      tenones=np.ones((5,2),dtype=np.uint8) #np.uint8 is equal to 'uint8'
      
      #instantiate a 2D array without initializing entries
      #then you can assign values the index and slices
      emptyarray=np.empty((5,2),dtype='int8')
      ```

5. Structured Array - ndarrays whose datatype is a composition of simpler datatypes organized as a sequence of named fields. This method is rarely used...

   - ```python
     x=np.array([('Rex',9,81.0),('Fido,3,27.0)], dtype=[('name','U10'),('age','uin8'),('weight','float16')])
     #array([('Rex', 9, 81.), ('Fido', 3, 27.)],
     #      dtype=[('name', '<U10'), ('age', 'u1'), ('weight', '<f2')])
                                 
      x['name'] = array(['Rex','Fido'],dtype='<10')
                                 
     # x's dimension is 1D and it's shape is (2,) as there are only 2 elements in the 1D, each element is a tuple
     ```

     what's the difference between data frame in r and structured array here in python. like the structured array also has titles...yea in R or pandas this kind of heterogenous data will work better

     how to continue using this for multiple dimension? like I want to name each dimension by width, breadth and channel, and by typing x['channel'] I can see all 3rd dimension info? No idea...

     ```python
     y=np.array([[1,'Emma'],[2,'Ben']],dtype=[['label', 'int8']])
     print(y)
     #why it doesn't work
     ```

6. Change array to list

   1. ```python
      a=np.random.randin(100,size=(N,M))
      a2 = a.tolist()
      ```

7. On dtype

   - Be careful with getsizeof, it is providing the size of the object which is different than the underlying size of the type? what does it mean. It means getsizeof will give you how big the python object is, not only how big the data contains by the python object. There's additional things attached to it. If you want to get actual bytes of data that object contains, use array.nbytes

   - For deep learning applications where images are usually stored as images, this can have a huge impact on storing and tranferring data from machine to machine. Think carefully about types

   - ```python
     from sys import getsizeof
     print(getsizeof.__doc__)
     
     myfirstarray=np.zeros((3,3))
     myfirstarray32=myfirstarray.astype('uint8')
     
     getsizeof(myfirstarray) #184. actual bytes should be 9*8=72 cos default is float64
     getsizeof(myfirstarray32) #121
     
     
     ```

   - Integers: signed and unsigned (negative and non-negative)

   - Unicode:

     - ```python
       #unicode data type along with length
       print(np.array(['hello','world']).dtype) #<U5
       print(np.array(['hello world']).dtype)  #<U11
       
       ```

   - stress test these types:

     - ```python
       np.array(128, dtype='uint8')
       #returns array(128, dtype=uint8)
       
       np.array(128, dtype='int8') 
       #returns array(-128,dtype=int8) why it returns -128?(-128, 127) check. so looping back to -128
       
       np.array(128**2, dtype='int8')
       #overflow
       
       np.array(2**104, dtype='float16')
       #returns array(inf, dtype=float16) why infinity? it is also overflowing but not to an extent it generates error, but enough to create infinity for computation purpose
       np.array(2**2040, dtype='float64')
       #overflow
       #anything in between is normal
       ```

   - Understanding bytes: 

     - 8 bits is 1 byte. So uint8, int16, int64, float 64, the number is all bits. using the number devided by 8 will give you the byte per element in that setting

     - representing a number in 8 bits - you will have 8 slots then each slot is 1,2,4,8,16,64,128,256 and you put 1 to the numbers that can give the eventual number you want in sum. The rest put 0. For example 5 will be 000000101 in 8 bits


   ### Mathematical Operations

   ```python
   myfirstarray*10
   myfirstarray+myfirstarray
   np.multiply(myfirstarray, myfirstarray) #multiply each element
   np.matmul(myfirstarray.T, myfirstarray) #matrix multiplication
   ```

   ### Basic Indexing and Slicing

   ```python
   result[0]
   #returns first row
   result[0,:]
   #returns first row
   result[0,1:]
   #returns first row, second element to end
   result[0,-2:]
   #returns first row, second last element to end
   ```

    

   ### Efficiency on Large Array Data

   1. Introduction

      - internally, array stores data in a contiguous block of memory
      - written in C language, numpy functio operate only on this block of memory
      - perform complex computations on arrays without python for loops(known to be slow)

   2. Universal functions: fast element-wise array functions

      - ufunc performs element-wise operations on data in ndarrays
      - universal functions are instances of the numpy.ufunc class

   3. Examples

      1. ```python
         np.exp(array)
         np.mean(array)
         ```

         -how to see documentation for all methods in ufunc? i tried np.ufunc.\__doc__ but doesn't work. same thing about how to see all methods in generate distribution in numpy. use help



         ### Statistical Methods

   1. Generate Random number

      1. ```python
         np.random.randn(dimension of the returned array)
         np.random.randn(2,3) gives a 2 by 3 2D array
         np.random.randn(28) give a 1D array of 28 elements
         
         np.random.randint
         ```

         learn more about random distribution generation method. where? print(np.random.\__doc__)

   2. Generate normal distribution

      - ```python
        b=np.sqrt(33.64)*np.random.randn(28)+80
        #a normal distribution with 80 as mean, variance as 33.64 for 28 random generation
        np.std(b)
        np.var(b)
        ```

   3. Arange: return evenly spaced values within a given interval. Range for numpy array

      1. ```python
         #arange([start,] stop[,step,],dtype=none)
         #by default start is 0
         #like the seq function in r, range function in python
         import numpy as np
         a=np.arange(1,10,1)
         ```


   ### Time

   1. ❓numpy need to set up C so that may make it slower than normal python with simple runs

   2. ```python
      from timeit import timeit
      timeit.eval(function) 
      #evaluate the time used by the function
      #timeit works the same as timeit.eval
      timeit(stmt=s1, number=10**3, setup='from_main_import a2,b2')
      
      #return true if 2 arrays are element wise equal within a tolerance
      assert np.allclose([[m*n for n in second] for m, second in zip(b2,a2)],(a.T*b).T)
      np.all(a==b)
      ```

      I don't understand the 2 timeit - what is stmt, what is number and setup (from main python namespace is crucial because timeit kind of running underneath, you need to tell it to run in the current python namespace)

      I don't understanad the assertion, why there's a for inside the list, there's a for outside? it is a nested list comprehension, also a nested for loop

      and also in Jupyter if we put %%timeit cell magic, it also works for python package? so that we don't need to specify the package name before we use the method? yes



### Simple Linear Regression

```python
import numpy as np

#what does the newaxis mean? converting 1D array to a 2D array with array elements as rows cos data_y is a 2D array with 100,1 dimension. Actually in this case, with and without np.newaxis is the same
data_x=np.linspace(1.0,10.0,100)[:,np.newaxis]
data_y = np.sin(data_x) + 0.1*np.power(data_x,2) + 0.5*np.random.randn(100,1)

import matplotlib.pyplot as plt
#%matplotlib inline what does this mean? to render figure in notebook. if you are in python IDE then don't need it

plt.scatter(data_x,data_y)
```



## Lecture 17 Numpy 2

### Np.Random & Seed

```python
import numpy as np
import matplotlib.pyplot as plt

#rand is uniform distribution. value between [0,1)
np.random.rand(3,2)
#randn is standard normal distribution
np.random.randn(256,256)
#randint can set lower and upper bound
img = np.random.randint(0,255,(256,258,3), dtype='uint8')
print(img)
plt.imshow(img)

#set seed
np.random.seed(123)
np.random.randn(3,4)
#return a tuple representing the internal state of the generator
np.random.get_state()
```

### RNG Class

```python
#create a randomstate object which contains many random methods to generate random number. Need to initialize it with a seed first
#print(dir(rng1)) to see all methods
rng1 = np.random.RandomState(123)
#pass in mean and standard deviation to it. Comparing with np.random.randn this is better as randn can only generate standard normal distribution. rng1.normal takes in mean and standard deviation as the first 2 arguments
rng1.normal(0,1,(3,4))
rng1.normal(size=(3,4))
#print(dir(rng1)) for complete methods

#similar to use np.random.randn and set seed using np.random.seed but simpler
```



### Sort

```python
#sort 3D array by axis 0 which is the first number in the (256,258,3). Seems to be dimension
zero_axis=np.sort(img,axis=0)
first_axis=np.sort(img,axis=1)
second_axis=np.sort(img,axis=2) #show blue cos RGB 3 graphs are layered on top of each other and the last layer in blue
```

❓Biggest question on this is that, when plt.imshow(img), the y-axis shows the zero axis and x-axis shows the first axis which in my intuition should be the other way round. And why the y-axis doesn't start from 0? This causes my confusion in indexing and reading the image.

(256,258,3) corresponds to axis0, axis1 and axis 2. Let's not understand it as breadth, width and dimension to confuse ourselves cos plt.imshow requires user to input in such a format with dimension as last.



### Mean

```python
#print first row of np.mean axis 0. this gives you (258,3)
print(np.mean(img,axis=0)[0,:])

#print first row of np.mean axis 1. this gives you (256,3)
print(np.mean(img,axis=1)[0,:])

#print first row of np.mean axis 2. this gives you (256,258)
print(np.mean(img,axis=2)[0,:])
```

Rules:

- mean by which dimension, that dimension will disappear
- axis 0 : take the first row in each 2D array and take average. 
- axis 1: calculate column average in each 2D array
- axis 2: calculate row average in each 2D array

### Ravel

```python
#change ndarray into a 1D array
plt.hist(img.ravel())
plt.hist(img.flatten())
```

### Index Slicing

```python
img[:,0:25]
```

### Rounding and Type

```python
x_round=np.around(x)
x_round_uint8=x_round.astype('uint8')
```

### Combining Images

```python
#vstack dimension(512,258,3)
np.vstack((img,x_round_uint8))
#hstack dimension(256,516,3)
np.hstack((img,x_round_uint8))
#stack shape(2,256,258,3), can't use imshow cos it's invalid dimension
np.stack([img,x_round],axis=0)
```

### Reshape

```python
img.reshape(256*258,3)
#put all elements of 198144 into 1D array. must use -1 can't use 1
img.reshape(-1)
#put all elements of 198144 into 2D array of (99072,2)
img.reshape(-1,2)
img.reshape(256,258,3,1)
```

what does -1 exactly mean here. it means unspecified and will take the length from the remaining dimensions.



### Expand/Squeeze Dimension

```python
#append last dimension of element 1 to the end. shape of results i (256,258,3,1)
np.expand_dims(img,axis=-1)
#shape of image is (256,258,1,3)
np.expand_dims(img,axis=2)
#shape of image is (1,256,258,3)
np.expand_dims(img,axis=0)

#squeeze out the dimension which only contains 1 element. results in (256,258,3)
np.squeeze(img_expanded)
```



### Saving and Loading

```python
#save the file under current directory called two_images.npy
np.save('two_images', np.stack([img,x_round],axis=0))
np.load('two_images')
```



### Reproducibility

```python
#hash and return the md5 hash. Hexdigest is to show the string of hexadecimal digits
import hashlib
hashlib.md5(np.stack([img,x_round],axis=0)).hexdigest()
```





## Lecture 18 Numpy 3

### Strides

```python
ex2 = np.array([[0, 1, 2, 4],[3, 4, 5, 6],[3, 4, 5, 6]], dtype='uint8')
print(ex2.strides)
#returns 4,1
#8bits is 1 byte, int8 means each number is 1 byte. Finishing crossing whole row takes 4 bytes and crossing to next row takes 1 byte

test=np.array([1,2])
test.strides
#returns (8,)
#default is 64 bits which is 8 byte per number. Finishing crossing whole row takes 8 bytes and crossing to next row doesn't count as it is a 1D array
```

```python
x = np.array([1, 2, 3, 4], dtype=np.int16)
print(x.shape)
print(x.strides)
#why this' strides is (2,) not (8,) 
```

For 1D array, strides represent how much byte to move to the next number. Therefore, no matter how many elements there are in the array, the stride will only be one kind.

### ❓As.Strided

```python
import numpy as np
from timeit import timeit
from numpy.lib.stride_tricks import as_strided
np.random.seed(42)
# see reference at beginning
# Generate array of (fake) closing prices
prices = np.random.randint(100, 200, 100)

# We want closing prices from the ten days prior
window = 10
# Create array of closing prices to predict
y = prices[window:]

# We want closing prices from the ten days prior
window = 10
# Create array of closing prices to predict
y = prices[window:]
y.shape

X1 = np.zeros([len(prices) - window, window])
print(X1.shape)

def make_X1():
    # Create array of zeros the same size as our final desired array
    X1 = np.zeros([len(prices) - window, window], dtype='int64')
    # For each day in the appropriate range
    for day in range(len(X1)):
        # take prices for ten days from that day onwards
        X1[day,:] = prices[day:day+window]
    return X1
 
def make_X2():
    # Save stride (num bytes) between each item
    stride, = prices.strides
    desired_shape = [len(prices) - window, window]
    # Get a view of the prices with shape desired_shape, strides as defined, don't write to original array 
    X2 = as_strided(prices, desired_shape, strides=[stride, stride], writeable=False)
    return X2 
 
print('make_x1: ' + str(timeit(make_X1)) )
print('make x2: ' + str(timeit(make_X2)) )
```

also I don't understand the class exercise in the notes

### Comparison

```python
#use assert
np.all(look==look1)
np.allclose(look,look1)

import hashlib
print(hashlib.md5(look.tobytes()).hexdigest())
print(hashlib.md5(look1.tobytes()).hexdigest())
```



### Linear Algebra

1. Definition: *Broadcasting: The term broadcasting describes how numpy treats arrays with different shapes during arithmetic operations. Subject to certain constraints, the smaller array is “broadcast” across the larger array so that they have compatible shapes. Broadcasting provides a means of vectorizing array operations so that looping occurs in C instead of Python.* -Numpy Documentation

2. Rules: When operating on two arrays, NumPy compares their shapes element-wise. It starts with the trailing dimensions, and works its way forward. Two dimensions are compatible when

   - they are equal
   - one of them is 1. does it have to be both matrix have dimension 1?
   - what does trailing dimensions mean and how to work its way forward

3. Example

   1. ```python
      #why xx*z doesn't work but xx.reshape(1,4)*z works
      #because this is element wise multiplication, not matrix. should be working for matrix multiplication
      ```

4. Matrix Multiplication

   1. ```python
      x @ y
      np.dot(x, y)
      np.matmul(x,y)
      x.dot(y)
      ```

5. Linear Algebra Library

   1. ```python
      from numpy.linalg import inv, qr, det
      
      X = np.random.randn(5, 5)
      mat = X.T.dot(X)
      inv(mat)
      mat.dot(inv(mat))
      q, r = qr(mat)
      det(mat)
      ```



### Parabolic

```python
plt.scatter(X,y)
new_x = X[np.where(X>=0)]
new_y = y[np.where(X>=0)]
```

question❓

```python
#add a column of 1 into matrix x as the first column. Can we add a column of a certain constant, not only restricted to one?
import statsmodels.api as sm
X = sm.add_constant(new_x)

#ordinary least square method to fit regression
model = sm.OLS(new_y,X)
res = model.fit()
res.summary()
res.params  #to get parameter of linear regression

#get coefficient matrix. Is there a formula way? yes checkout res.params. It returns the same coefficient value as below
inv(X.T.dot(X)).dot(X.T).dot(new_y)

#plot
line_x=np.arange(0,6,dtype='float16')
#parabolic
plt.scatter(scatter(new_x,new_y))
#fitted regression line, sub in coefficients straightaway
plt.plot(line_x,-6.7233+4.141*line_x, linestypde='solid')


```





## Lecture 19 Pandas

```python
import pandas as pd
```



### Series and DataFrames

1. Series

   - All elements must have the same type or all nulls. Like a vector

   - Basic Series

   - ```python
     #list+list will become a big list
     s=pd.Series([1,2,3]+[None])
     
     #output has index
     0    1.0
     1    2.0
     2    3.0
     3    NaN
     dtype: float64
     ```

   - String Series

   - ```python
     #chop up the string into one word each
     words='the quick brown fox jumps over the lazy dog'.split()
     #zip two lists together as one will be a zip object
     #join will join the 2 elements in the zip object together separated by space
     #list comprehension will do that for each element in the zip and eventually produce a list of 2 elements together separated by space
     s1=pd.Series([' '.join(item) for item in zip(words[:-1],words[1:])])
     
     #output
     0      the quick
     1    quick brown
     2      brown fox
     3      fox jumps
     4     jumps over
     5       over the
     6       the lazy
     7       lazy dog
     dtype: object
         
     #string objects functions apply. but neet to convert pd to str first
     #change to upper case
     s1.str.upper()
     #split up the string and put all elements into a list
     s1.str.split()
     s1.str.split().str[1]
     ```

   - Category Series

   - ```python
     s2=pd.Series(['Asian','Asian','White','Black','White','Hispanic'])
     #change s2's dtype to category.s2 still remains as a series
     s2=s2.astype('category')
     #access to the type of categories in s2
     s2.cat.categories
     #access to category code of s2
     s2.cat.codes
     
     #if we need precpecified order. so hispanic will be number 0, white will be 1..
     s2 = s2.cat.reorder_categories(['Hispanic', 'White', 'Black', 'Asian'])
     
     
     ```

   - Timestamps

   - ```python
     #make date into a series starting from now, for 3 periods, frequency is by calendar day
     s3=pd.date_range('now',periods=3,freq='d')
     
     #output
     DatetimeIndex(['2018-11-24 16:14:14.635980', '2018-11-25 16:14:14.635980',
                    '2018-11-26 16:14:14.635980'],
                   dtype='datetime64[ns]', freq='D')
     
     #extract element and change format
     s3.year
     s3.month
     s3.day
     s3.strftime('%d-%b-%Y')
     (s3+1).strftime('%d-%b-%Y')
     
     #help(date_range)
     date_range(start=None, end=None, periods=None, freq=None, tz=None, normalize=False, name=None, closed=None, **kwargs)
         Return a fixed frequency DatetimeIndex.
         
         Parameters
         ----------
         start : str or datetime-like, optional
             Left bound for generating dates.
         end : str or datetime-like, optional
             Right bound for generating dates.
         periods : integer, optional
             Number of periods to generate.
         freq : str or DateOffset, default 'D' (calendar daily)
             Frequency strings can have multiples, e.g. '5H'. See
             :ref:`here <timeseries.offset_aliases>` for a list of
             frequency aliases.
         tz : str or tzinfo, optional
             Time zone name for returning localized DatetimeIndex, for example
             'Asia/Hong_Kong'. By default, the resulting DatetimeIndex is
             timezone-naive.
         normalize : bool, default False
             Normalize start/end dates to midnight before generating date range.
         name : str, default None
             Name of the resulting DatetimeIndex.
         
         Returns
         -------
         rng : DatetimeIndex
         
     ```

2. Dataframe

   - Columns in dataframes are series

   - Each column represents a variable, each row represents an observation, each cell represents a value

   - ```python
     #recap dictionary. a is a dictionary with title as num and list as value
     a=dict(num=[1,2,3]+[None])
     
     #pass a dictionary into a dataframe. key as variable name, values as variable values
     df=pd.DataFrame(dict(num=[1,2,3]+[None]))
     ```

   - Dataframe Indexing- to get variable, observation and value

   - ```python
     #index each column. 
     #Use property method or []
     df.num df['num']
     
     #index rows. df.index will give a rangeindex object
     df.index 
     
     #setting a coulmn as row index. setting df num column as df1's index, so it doesn't start from 0 but 1
     df1=df.set_index('num')
     
     #reset index to starting from 0
     df1.reset_index()
     
     #index columns. df.columns will give an index object too showing all columsn names(slightly different but similar)
     df.columns
     
     #getting raw values
     df.values
     ```



### Creating Data Frames

1. Manual - pass in an ordered dictionary. Read in csv as ordered dictionary and then convert to pandas. Or straight away read_csv

2. ```python
   from collections import OrderedDict
   n=5
   dates=pd.date_range(start='now',periods=n,freq='d')
   df=pd.DataFrame(OrderedDict(pid=np.random.randint(100，999，n),
                              weight=np.random.normal(70,20,n),
                              height=np.random.normal(170,15,n).
                              date=dates,
                              ))
   df
   ```

3. From File: can read in data from many different file types - plain text, json. spreadsheets, databases. Functions to read in data look like read_X where X is the data type

4. ```python
   df=pd.read_table('measures.txt')
   df1=pd.read_csv('measures.csv')
   ```

5. From ndarray: what's the usage of ''' big string

6. ```python
   vals = np.array([line.split('\t') for line in '''
   649	42.942970	173.576789	2018-11-11 13:33:24.006649
   533	58.421067	185.424830	2018-11-12 13:33:24.006649
   918	60.209659	176.470378	2018-11-13 13:33:24.006649
   590	66.595320	139.766303	2018-11-14 13:33:24.006649
   112	77.112459	169.990751	2018-11-15 13:33:24.006649
   '''.strip().splitlines()])
   vals
   
   df=pd.DataFrame(vals, columns=['pid','weight','height','date'])
   
   ```



### Indexing Data Frames

1. Implicit defaults

2. ```python
   #first top 2 rows, there's no comma after it, unlike numpy[1:3,] though numpy can also handle [1:3]. But pandas indexing can't handle the comma, unless you index by location, then same as numpy
   df=[1:3]
   
   #get 2 columns, pass in a list
   df[['pid','weight']]
   ```

3. Indexing by location, same as bumpy

4. ```python
   #second and third rows, all columns
   df.iloc[1:3,:]
   df.iloc[1:3,[True,True,False]]
   ```

5. Indexing by Name

6. ```python
   #second, third and forth rows, weight and height columns, as 1:3 are names not indices
   df.loc[1:3,'weight':'height']
   ```

7. Change index

8. ```python
   df1.index=df.index+1. #all indices plus one
   ```



### Structure of a Data Frame

1. Data Types

   - ```python
     df.dtypes
     ```

2. Converting data types

   - ```python
     df.pid=df.pid.astype('category')
     df=df.astype(dict(weight=float,height=float))
     df.date=pd.to_datetime(df.date)
     ```

3. Basic Properties

   - ```python
     df.size
     df.shape
     df.describe() #like R's summary
     ```

4. Inspection

   - ```python
     df.head(n=3)
     df.tail(n=3)
     df.sample(n=3) #random sample
     df.sample(frac=0.5) #take 5% random sample
     ```


### Selecting, Ranaming and Removing Columns

1. Selecting columns

   - ```python
     df.filter(items=['pid','date'])
     df.filter(regex='.*ght')
     df.loc[:,df.columns.str.contains('d')]
     ```

2. Renaming columns

   1. ```python
      #one method of renaming
      df.rename(dict(weight='w',height='h'),axis=1)
      
      #directly change df.columns to a list
      orig_cols=df.columns
      df.columns=list['abcd']
      ```

3. Removing columns

   - ```python
     df.drop(['pid','date'],axis=1)
     df.drop(columns=['pid','date'])
     df.drop(columns=df.columns[df.columns.str.contains('d')])
     ```



### Selecting, Renaming and Removing rows

1. Selecting rows

   1. ```python
      df[df.weight.between(60,70)]
      df[(69<=df.weight) & (df.weight<70)]
      
      df[df.date.between(pd.to_datetime('2018-11-13'),pd.to_datetime('2018-11-15 23:59:59'))]
      ```

2. Renaming rows

   1. ```python
      df.rename({i:letter for i,letter in enumberate('abcde')})
      df.index=['the','quick','brown','for']
      
      df=df.reset_index(drop=True)
      ```

3. Dropping rows

   1. ```python
      df.drop([1,3],axis=0)
      ```



### Transforming and Creating Columns

1. Creating columns

   1. ```python
      #method 1
      df.assign(bmi=df['weight']/(df['height']/100)**2)
      
      #method 2
      df['bmi']=df['weight']/(df['height']/100)**2
      
      df['something']=[2,2,None,None,3]
      
      ```

2. Uniqueness

   1. ```python
      #find the unique values
      df.something.unique()
      #find the duplicated rows
      df.loc[df.something.duplicated()]
      #drop duplicated by certain column
      df.drop_duplicates(subset='something')
      ```

3. Missing data

   1. ```python
      #all these are not changing on the original dataframe unless you do df=df.something.fillna(0)
      df.something.fillna(0)
      
      #forward fill, NA follows number previously
      df.something.ffill()
      #backward fill, NA follows number after them
      df.something.bfill()
      #linear interpolation
      df.something.interpolate()
      #drop NAs
      df.dropna()
      
      ```



### Sorting Data Frames

1. Sort on indexes

   1. ```python
      #axis 0 is row, axis=1 is columns
      df.sort_index(axis=1)
      df.sort_index(axis=0,ascending=False)
      ```

2. Sort on values

   1. ```python
      #sort values by the 2 columns, something uses ascending order, and then bmi uses descending after ordered by something
      df.sort_values(by=['something','bmi'],ascending=[True,False])
      ```



### Aggregate Functions

```python
df.weight.mean()
df.weight.agg([np.median,'min','max'])
df.weight.agg(lambda x: np.sqrt(((x-x.mean())**2).sum()))
```



### Split-Apply-Combine

```python
df['treatment']=['ababa']
grouped=df.groupby('treatment')
grouped.get_group('a')
grouped.mean()
grouped.agg(['min','max','median'])
```

### Window Functions

```python
x=pd.DataFrame({'n':range(6)})
#sum up window of 3 numbers
x.rolling(window=3).sum()

x.expanding().sum()
```

​    what does expanding do? like fibonacci, continously adding the previous one value



### Combine Data Frames

1. when does the command work directly on the dataframe when does it not?

```python
#seems this df.append is directly impacting on data frame
#add rows
df.append(df1,sort=False)
#OR
pd.concat([df,df1],sort=False)


#add columns
df.pid
pd.merge(df,df2,on='pid',how='inner')
pd.merge(df,df2,on='pid',how='left')
pd.merge(df,df2,on='pid',how='right')
pd.merge(df,df2,on='pid',how='outer')

#merge on index. provided they have the same index
df1.join([df2,df3])
```





### Fixing Common DataFrame Issues

1. Multiple variables in a column

   1. ```python
      df = pd.DataFrame(dict(pid_treat = ['A-1', 'B-2', 'C-1', 'D-2']))
      df.pid_treat.str.split('-')
                                          
      df_ = pd.DataFrame(df.pid_treat.str.split('-').apply(pd.Series))
      df_.columns=['pid','treat']
                                          
      ```

2. Multiple values in a cell

3. ```python
   df = pd.DataFrame(dict(pid=['a', 'b', 'c'], vals = [(1,2,3), (4,5,6), (7,8,9)]))
   #creating 3 columns like above
   df[['t1', 't2', 't3']]  = df.vals.apply(pd.Series)
   #drop original val column
   df.drop('vals', axis=1, inplace=True)
   #melt 3 value columns into 1
   pd.melt(df, id_vars='pid', value_name='vals').drop('variable', axis=1)
   ```

   ### Reshaping Dataframes

   1. Converting multiple columns into 1 column

   ```python
   #species become identification column, variable column is all the other variables combined, value is value
   df_iris=pd.melt(iris,id_vars='species')
   ```

   2. Hierarchical indexes

   3. ```python
      #group first by specieis then by variable, thus the index is this 2 levels
      df_iris1 = df_iris.groupby(['species', 'variable']).mean()
      #can reset back to normal index
      df_iris1.reset_index()
      ```

   4. Stack and unstack - refer to notes

      - stack takes a level of the column multi-index and moves it to the rows, unstack does the reverse

      - ```python
        #make species column into 3 columns as there are 3 species
        df_iris1.unstack(0)
        #make species columns into rows
        df_iris1.unstack(1)
        ```

   5. ❓Pivot tables - what does split() use here? what does index and columns referring to?

   6. ```python
      pd.pivot_table(iris, index='species', aggfunc=['mean', 'median'])
      pd.pivot_table(iris, columns='species'.split(), 
                     aggfunc=['mean', 'median'])
      ```

   7. Chaining commands like dyplyr

   8. ```python
      (
          iris.
          sample(frac=0.2).
          filter(regex='s.*').
          assign(both=iris.sepal_length + iris.sepal_length).
          groupby('species').agg(['mean', 'sum']).
          pipe(lambda x: np.around(x, 1))
      )
      ```







   ## Lecture 20 SQL Basics

   1. Column Constraints

      - NOT NULL
      - DEFAULT: provides a default value for a column when none is specified
      - UNIQUE
      - PRIMARY KEY
      - FOREIGN KEY
      - Typenames: int, integer, character, varchar,ncahr, text, blob(default if no datatype is specified),real, double ,float, numeric, decimal, boolean, date

   2. Column aliasing(use as or use space): select x as y or select x y, z b

   3. SQL query shorthand: so few workers go home ontime

   4. Comments:

      - line comments: start with double dash
      - block comments: start with forward slash asterisk /*

   5. Create Table

      1. ```sql
         CREATE TABLE tb11(
         	itemid INTEGER PRIMARY KEY,
         	orderid TEXT NOT NULL,
         	item NOT NULL,
         	amount TEXT NOT NULL UNIQUE
         );
         ```

   6. Insert values

      1. ```sqlite
         INSERT INTO tb11 (
         itemid,
         orderid,
         item,
         amount)
         VALUES
         (5,
         1,
         'chair',
         200
         );
         
         --multiple values
         Values
         (5,6),
         (Ben,Emma),
         (ben@gmail, emma@gmail)
         
         
         
         ```

   7. Joins (refer to diagram on graph)

      - ```sqlite
        #left join
        select orderid, item, date
        from tbl1 a left join tbl2 b on (a.orderid=b.orderid);
        ```



   ## Lecture 20 Relational Database Management System

   1. sqlite - pragma?

   2. SQLAlchemy

      - ❓think - what is create_engine here? a module or a folder? I would say a module

      - ❓I used help(create_engine), but didn't manage to find the path notation part

      - ```python
        from sqlalchemy import create_engine
        
        engine=create_engine('sqlite:///mydate.db')
        result=engine.execute('select * from tbl1;')
        #result now is an object
        print(dir(result)) #to show all methods of this object
        result2=result.fetchall()
        #result 2 is a list of tuples, each tuple is a row of data
        
        ```

   3. ❓In Pandas - don't understand the trick

      1. ```python
         import pandas as pd
         df=pd.read_sql('select * from tbl1;', engine)
         #as such, sql result is straightaway a pandas dataframe
         
         #apply tricks
         #apply function applies a function to an axis, in this time is columns
         #does row refer to each row? or just df as a whole? refer to as each row? shouldn't the axis be 0? cos is by each row?
         df.apply(lambda row:row['email'].split('@')[0],axis=1)
         
         
         ```

   4. Metadata

      1. ```python
         from sqlalchemy.schema import MetaData
         m=MetaData()
         m.reflect(engine)
         print(m.tables) #print out all table info about the engine
         
         for table in m.tables.values():
         	print('************')
         	print('TABLE: ' + table.name)
         	print('COLUMNS:')
         	for column in table.c:
         		print('\t'+column.name)
         ```





## Lecture 21 Visualization

```bash
%matplotlib inline
#notebook = can be updated, inline = cannot
```

### Typical Namespacing

```python
import matplotlib.pyplot as plt
import numpy as np
#np array of 1-10
data= np.arange(10)
#normal range object
data1=range(10)

#both plots are the same
plt.plot(data)
plt.plot(data1)
```

### Figures and Subplots

- Plots like above reside within a Figure object. We can use the following function to create a new matplotlib.figure.Figure object

- ```python
  #create a figure object
  fig=plt.figure()
  #Either a 3-digit integer or three separate integers describing the position of the subplot. If the three integers are R, C, and P in order, the subplot will take the Pth position on a grid with R rows and C columns.
  
  #so below is on a grid of 2 by 2 it takes the second position
  ax1=fig.add_subplot(2,2,2)
  
  #call fig to show picture
  fig
  
  #add more subplot
  ax2=fig.add_subplot(2,2,3)
  fig
  #now fig has 2 subplots at position 2 and 3 respectively
  ```

- By default, if you don't specify which subplot to plot on, plt will plot on the last one

- ```python
  fig = plt.figure()
  ax1 = fig.add_subplot(2,2,1)
  ax2 = fig.add_subplot(2,2,2)
  #k-- is black slash line
  plt.plot(np.random.randn(50).cumsum(), 'k--')
  ```

- You can specify which plot to plot on by calling the variable, ax1,ax2 for example

- ```python
   _= ax1.hist(np.random.randn(100), 20, color='k', alpha=0.3)
  #20 = number of bins
  #k = black
  #alpha = transparency
  
  
  #call fig to see hist
  fig
  ```

- Create a grid of 2 by 3 subplots. Allow the x axis to vary with each plot, but ensure the y axes are all the same. On the last row, middle column subplot, recreate one of the figures from above.

- ```python
  fig, axes = plt.subplots(2,3, sharex=False, sharey= True)
  #add scatter to bottom left
  axes[1,0].scatter(np.arange(30), np.arange(30) + 3 * np.random.randn(30))
  
  #adjust the spacing around objects in the subplots
  fig2, axes = plt.subplots(2,2,sharex=True, sharey=True, figsize = (8,6))
  axes[1,0].plot(np.random.randn(100).cumsum(), 'c--') #blue
  axes[0,0].plot(np.random.randn(100).cumsum(), 'm--') #purple
  axes[0,1].plot(np.random.randn(100).cumsum(), 'r--') #red
  axes[1,1].plot(np.random.randn(100).cumsum(), 'k--') #black
  fig2
  
  #try with for loop
  for i in range(2):
      for j in range(2):
          axes[i,j].plot(np.random.randn(100).cumsum())
        
  ```

- Styles

- ```python
  plt.plot(np.random.randn(50), linestyle='-.', color='#dd1923') #fiestared
  plt.plot(np.random.randn(50), 'r--') #red
  
  #change grid stype
  with plt.xkcd():
      plt.plot(np.random.randn(50), linestyle='-.', color='#dd1923')
      
  #markers
  lt.plot(np.random.randn(50), linestyle='-.', color='#dd1923', marker="*")
  ```

- Ticks and legends

- ```python
  fig = plt.figure()
  ax = fig.add_subplot(1,1,1)
  ax.plot(np.random.randn(1000).cumsum())
  fig
  ticks = ax.set_xticks([0,250,500,750,1000])
  #above code reset x axis labels
  
  #code below rename the ticks
  labels = ax.set_xticklabels(
  ['a', 'b', 'c', 'd', 'e'], 
      rotation=30,
      fontsize=15
  )
  
  ```

- Batch setting axes properties

- ```python
  props = {
      'xticks': [0, 250, 500, 750, 1000],
      'xticklabels': ['start', 'Christmas 2009', 'Easter 2010', 'Market Crash', 'Market Rebound'],
      'title': 'Glorius Graph',
      'xlabel': 'Important Dates',
      'ylabel': 'Revenue'
  }
  
  fig = plt.figure()
  ax = fig.add_subplot(1, 1, 1)
  ax.plot(np.random.randn(1000).cumsum(), label='Ben Corp.')
  ax.set(**props)
  ```

- Subplot annotations

- ```python
  ax.annotate(
      'Trough',
      xy = (274, -14),
      xytext = (274, -20),
      arrowprops = {
          'facecolor': 'black',
          'headwidth': 4,
          'width': 2,
          'headlength': 4
      }
  )
  fig
  ```

- Save Figure

- ```python
  fig.savefig('test.png', dpi=400, bbox_inches='tight')
  ```
