//created for puzzlenode 11  http://puzzlenode.com/puzles/11-hitting-rock-bottom
//created by ktt
//last modified 02/06/2013

//TODO: provide useful args to program for input, output files
//TODO: change log file name based upon script file name.log
//TODO: AppSec: Input Validation, Output Encoding
//TODO: write test assertion to diff against known solution

var puzzle = require('./puzzle_solver_11');

puzzle.on('puzzleSolved', function(puzzle) {
	console.log('puzzle solved');
});

puzzle.on('applicationError', function(puzzle) {
	console.log('error trying to solve puzzle');
});

var isDebug = false;
var inputFile = '../resources/complex_cave.txt';
var answerFile = '../output/puzzle11_out.txt';
var logFile = '../output/puzzle11.log';

puzzle.solve(inputFile, answerFile, logFile, isDebug);

