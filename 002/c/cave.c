#include <stdio.h>
#include <stdlib.h>

#define MAX_WIDTH 512
#define MAX_HEIGHT 256

char const EARTH = '#';
char const WATER = '~';
char const AIR = ' ';

typedef struct {
  int units, width, height;
  char **atlas;
} Cave;

void flow(Cave *cave, int x, int y) {
  if(cave->units > 0) {
    cave->atlas[x][y] = WATER;
    cave->units--;
    if(cave->atlas[x][y+1] == AIR)
      flow(cave, x, y+1);
    if(cave->atlas[x+1][y] == AIR)
      flow(cave, x+1, y);
  }
}

void parse(Cave *cave, FILE *file) {
  char currentChar;
  char *line = NULL;
  size_t length = 0;
  int x = 0, y = 0;

  // Read the first line and get the number of units we're goinrg to pump in.
  getline(&line, &length, file);
  sscanf(line, "%d", &cave->units);

  // Skip the blank line
  fseek(file, 1, SEEK_CUR);

  // Load the rest of the data into our atlas
  while ((currentChar = getc(file)) != EOF) {
    if (currentChar == '\n') {
      cave->height = ++y;
      x = 0;
    } else {
      cave->atlas[x][y] = currentChar;
      cave->width = ++x;
    }
  };

  free(line);
}

void measure(Cave *cave) {
  int x, y, depth;
  for (x = 0; x < cave->width; x++) {
    depth = 0;
    for (y = 0; y < cave->height; y++) {
      if (cave->atlas[x][y] == WATER)
        depth++;
      if (depth > 0 && cave->atlas[x][y+1] == AIR)
        depth = WATER;
    }
    if (depth == WATER) {
      printf("%c", depth);
    } else {
      printf("%d", depth);
    }
    if (x + 1 < cave->width)
      printf(" ");
  }
  printf("\n");
}

int main (int argc, char const *argv[])
{
  Cave cave;
  FILE *file;
  char const *inputPath = NULL;
  int i;

  cave.atlas = (char**) malloc((sizeof(char*) * MAX_WIDTH));
  for (i = 0; i < MAX_WIDTH; i++) {
    cave.atlas[i] = (char*) malloc(MAX_HEIGHT * sizeof(char));
  }

  if (argc > 1) {
    inputPath = argv[1];
  } else {
    fprintf(stderr, "No input given. Usage: `%s filename`.\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  file = fopen(inputPath, "r");
  if (file == NULL) {
    fprintf(stderr, "Could not open %s\n", inputPath);
    exit(EXIT_FAILURE);
  }

  parse(&cave, file);
  fclose(file);

  flow(&cave, 0, 1);
  measure(&cave);

  for (i = 0; i < cave.width; i++){
     free(cave.atlas[i]);
  }
  free(cave.atlas);

  return EXIT_SUCCESS;
}
