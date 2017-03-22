Usage: Managing labels
======================

Every subcommand has its own help screen which is accessable via `-h`:
```shell
$ lbl add -h
$ lbl del -h
...
```


Manipulate labels on files
--------------------------

I use the word **file** and **directory** randomly. All actions can be done on
files as well as on directories. The only exception are recursive (`-r`)
operations which obviously only work on directories.

### 1. Add label to file (`add`)
```shell
# Add label 'private' to /path/to/file
$ lbl add private /path/to/file
```

### 2. Delete label from file (`del`)
```shell
# Delete all labels from `path/to/file`
$ lbl del path/to/file

# Delete the label 'todo' from `path/to/file`
$ lbl del todo path/to/file

# Delete all 'todo' labels recursively from path/to/dir (and all subdirectories)
$ lbl del -r todo path/to/dir
```


Finding labels
--------------

### 1. Find labels by name (`name`)
```shell
# Find/show all labels named 'important'
$ lbl name important

# Find/show all labels named 'important' starting from dir ~/Documents
$ lbl name important ~/Documents
```

### 2. Find labels by regex (`regex`)
```shell
# Find/show all labels matching 'important|overdue'
$ lbl regex 'important|overdue'

# Find/show all labels matching 'important|overdue' starting from dir ~/Documents
$ lbl regex 'important|overdue' ~/Documents
```

### 3. FInding labels by path (`path`)
```shell
# Find/show all labels for files/dir in current path
$ lbl path
```

```shell
# Find/show all labels for files/dir in path ~/Documents/coding
$ lbl path ~/Documents/coding
```

### 4. Find labels by creation date (`created`)
```shell
# Find/show all labels created on '2017'
$ lbl created '2017'

# Find/show all labels created on '2017-03'
$ lbl created '2017-03'

# Find/show all labels created on '2017-03-19'
$ lbl created '2017-03-19'

# Find/show all labels created on '2017-03-19' starting from dir ~/Documents
$ lbl created '2017-03-19' ~/Documents
```

### 5. Find labels by modification date (`modified`)
```shell
# Find/show all labels modified on '2017'
$ lbl modified '2017'

# Find/show all labels modified on '2017-03'
$ lbl modified '2017-03'

# Find/show all labels modified on '2017-03-19'
$ lbl modified '2017-03-19'

# Find/show all labels modified on '2017-03-19' starting from dir ~/Documents
$ lbl modified '2017-03-19' ~/Documents
```

Administrate labels
-------------------

### 1. List available label names (`admin -l`)
List all available labels that can be assigned to files or directories.
```shell
$ lbl admin -l
```
### 2. Add new label (`admin -a`)
If you want to assign a label to a file or directory, you will first need to
add it to the available label database here.
```shell
$ lbl admin -a 'important'
```
### 3. Delete label (`admin -d`)
Labels can only be deleted if they are not assigned to any file or directory.
```shell
# Delete interactively
$ lbl admin -d

# Delete by label name
$ lbl admin -d 'important'
```
### 4. Rename label (`admin -r`)
This will affect all currently assigned labels.
```shell
$ lbl admin -r 'important' 'critical'
```
### 5. Change label color (`admin -c`)
This will affect all currently assigned labels.
```shell
$ lbl admin -c 'important'
```
### 6. Validate label database (`admin -v`)
This will check the label database for labels assigned to files or directories
which paths do not exist anymore.
```shell
$ lbl admin -v
```
### 7. Fix label database (`admin -f`)
This will remove any entries from the label database for files or directories
which paths do not exist anymore.
```shell
$ lbl admin -f
```

