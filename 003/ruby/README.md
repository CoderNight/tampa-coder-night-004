#cave
```
Usage: cave [options] filename
    -n num                           Will use parameter as the n value rather than the file.
    -d, --display                    Display the final cave rather than calculating the depth.
```

##Purpose
This is my first attempt at making a gem.

I also used this project to practice my BDD skills with Cucumber and RSpec.  I used Guard for continuous integration testing.

##Description
The gem contains an executable as well as a Cave class.

This is the content of the example data file:

```
cave$ cat data/simple_cave.txt 
100

################################
~                              #
#         ####                 #
###       ####                ##
###       ####              ####
#######   #######         ######
#######   ###########     ######
################################
```

Here are some examples running the executable:
```
$ ./bin/cave 
Usage: cave [options] filename
    -n num                           Will use parameter as the n value rather than the file.
    -d, --display                    Display the final cave rather than calculating the depth.
```


```
$ ./bin/cave data/simple_cave.txt 
1 2 2 4 4 4 4 6 6 6 1 1 1 1 4 3 3 4 4 4 4 5 5 5 5 5 2 2 1 1 0 0
```

```
$ ./bin/cave data/simple_cave.txt -d
################################
~~~~~~~~~~~~~~~                #
#~~~~~~~~~####~~~~~~~~~~~~     #
###~~~~~~~####~~~~~~~~~~~~~~~~##
###~~~~~~~####~~~~~~~~~~~~~~####
#######~~~#######~~~~~~~~~######
#######~~~###########~~~~~######
################################
```

```
$ ./bin/cave data/simple_cave.txt -d -n 5
################################
~~                             #
#~~~      ####                 #
###       ####                ##
###       ####              ####
#######   #######         ######
#######   ###########     ######
################################
```