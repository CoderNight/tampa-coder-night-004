# [[#11] Hitting Rock Bottom](http://puzzlenode.com/puzzles/11-hitting-rock-bottom)

_This puzzle was contributed by Gregory Brown &amp; Andrea Singh and published on July 14, 2011_

The science of hydrography is about charting bodies of water by measuring their depths, tides and currents and describing the topography of river, lake or sea beds. 

In this challenge you will work on a simulation problem with a hydrographic theme. You will be asked to progressively fill an underground cave with water. The cave sports a particular topography of rock formations that will affect the way in which the water flows into it and fills it up. After a certain amount of water has flowed in, you will need to determine the water depth at various points.

## The Environment

Consider the following simple cave having only a single square shaped rock on its floor. The solid parts of the cave are represented by hash marks. Note that the cave is an entirely closed system, except for an inlet at the top left. It is through here that the water enters the chamber. Each "water unit" is indicated by a tilde (`~`). The diagram below, then, starts off with one unit of water entering the system.

```
  ###########################
  ~                         #
  #                         #
  #                         #
  #         ####            #
  #         ####            #
  #         ####            #
  ###########################
```

## Rules Governing Water Influx

What would be the gravitational behavior of the water as it starts flowing into the system? There are two fundamental rules that describe the flow of water in the system:

1. the stream must remain continuous 
2. the water flows all the way down before it starts spreading from left to right

So what happens as we start pumping water into the cave? As we can see in the diagram below, it first flows one to the right and then starts flowing downwards until it hits the bottom of the cave:

```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~       ####             #
  #~       ####             #
  #~       ####             #
  ###########################
```

At this point it cannot flow further downwards, so it starts moving to the right. That is, until it hits another physical obstacle in the shape of a rock:

```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~       ####             #
  #~       ####             #
  #~~~~~~~~####             #
  ###########################
```

Having come up against this obstacle on the bottom of the cave, the water starts spreading to the right again, but at the lowest possible point:

```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~       ####             #
  #~~~~~~~~####             #
  #~~~~~~~~####             #
  ###########################
```

The same behavior repeats for the next set of water units:


```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~~~~~~~~~~~~             #
  #~~~~~~~~####             #
  #~~~~~~~~####             #
  #~~~~~~~~####             #
  ###########################
```

After flowing over the top of the rock, the water then begins cascading down its right side. To clear the rock and start flowing downwards, the water needs to move one unit to the right in order to commence its downward passage:

```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~~~~~~~~~~~~~            #
  #~~~~~~~~####~            #
  #~~~~~~~~####~            #
  #~~~~~~~~####~            #
  ###########################
```

From here, the water will flow right again until it hits the right wall of the cave. Then, once again, it will search for the lowest possible point that is still connected to the stream and keep spreading right. Here's a snapshot of this process:

```
  ###########################
  ~~                        #
  #~                        #
  #~                        #
  #~~~~~~~~~~~~~            #
  #~~~~~~~~####~            #
  #~~~~~~~~####~~~~~~~~     #
  #~~~~~~~~####~~~~~~~~~~~~~#
  ###########################
```

## The Input Files

### Possible Rock Formations

The rocks in the input files can have irregular shapes, such as:

```
  ################################
  ~                              #
  #         ####                 #
  ###       ####                ##
  ###       ####              ####
  #######   #######         ######
  #######   ###########     ######
  ################################
```

Note that rock overhangs will **NOT** occur, so you don't need to take these kinds of scenarios into account. Here are some examples of what we mean by overhangs:

```
  ################################
  ~                              #
  #         #########            #
  #         ########             #
  #         ######               #
  #         ######               #
  #         ######               #
  ################################
```

```
  ################################
  ~                              #
  #         ######               #
  #         ######               #
  #         ####                 #
  #         ####                 #
  #         #########            #
  ################################
```

### Simulating Water Influx

On the first line of the input file there is a number which indicates the amount of water that will be pumped into the cave. This number stands for "units" of water, each of which is represented by one `~` symbol. The number is separated from the drawing of the cave by an empty line.

Your task is to predict the water depth at every column in the cave after the specified number of water units have entered the closed chamber.

## The Output File

### Measuring Water Depth

Given the following input file:

```
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

You will measure the depth at every column after 100 units of water have been added to the cave. Remember that the system starts off with an initial water unit, which should count towards your end total. This is what the resulting water levels should look like at that point:

```
  ################################
  ~~~~~~~~~~~~~~~                #
  #~~~~~~~~~####~~~~~~~~~~~~     #
  ###~~~~~~~####~~~~~~~~~~~~~~~~##
  ###~~~~~~~####~~~~~~~~~~~~~~####
  #######~~~#######~~~~~~~~~######
  #######~~~###########~~~~~######
  ################################
```

The water levels are measured column by column, starting at the left edge of the cave. The water level (or depth) is determined by counting vertically the number of `~` symbols encountered before hitting rock surface. In this particular case, then, the correct output file would contain these numbers:

```
  1 2 2 4 4 4 4 6 6 6 1 1 1 1 4 3 3 4 4 4 4 5 5 5 5 5 2 2 1 1 0 0
```

Note that the individual water depths are all printed on a single line and separated by a space.

### Edge Case: Water Flowing

In some cases, the flow of the water will be interrupted mid-stream. If that happens, there will be air (or empty space) between the water level and the rock surface. As such, the depth of the water cannot be measured, since the water is in a "flowing" state. To indicate this, a `~` symbol should be printed in lieu of the depth number in that particular column.

To illustrate how this would work, we'll just add 45 units of water to the cave:

```
  ################################
  ~~~~~~~~~~~~~~~                #
  #~~~~~~~~~####~                #
  ###~~~~~~~####                ##
  ###~~~~~~~####              ####
  #######~~~#######         ######
  #######~~~###########     ######
  ################################
```

```
  1 2 2 4 4 4 4 6 6 6 1 1 1 1 ~ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```


## Submitting Your Results

The sample files are for helping you check your code before you submit your solution to Puzzlenode. The sample input file is called `simple_cave.txt` and the sample output file is called `simple_output.txt`. 

The input file you need to solve is called `complex_cave.txt`.