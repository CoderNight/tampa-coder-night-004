//created for puzzlenode 11  http://puzzlenode.com/puzles/11-hitting-rock-bottom
//created by ktt
//last modified 02/06/2013
//inspired by http://wekeroad.com/2012/04/05/cleaning-up-deep-callback-nesting-with-nodes-eventemitter
//with help from http://javascript.crockford.com/private.html
//and error help from by http://www.devthought.com/2011/12/22/a-string-is-not-an-error/

//TODO: change log file name based upon script file name.log
//TODO: AppSec: Input Validation, Output Encoding
var domain = require('domain'); // highly experimntal node.js API ...Warning, Will Robinson...
var puzD = domain.create(); // highly experimntal node.js API ...Warning, Will Robinson...
var fs = require('fs');
var readline = require('readline');  //unstable node.js api
var util = require('util');
var events = require('events');

//puzzle prototype
function Puzzle(inFile, outFile, logFile, isDebug) { 
	this.inputFile = inFile;		//file path		arg
	this.answerFile = outFile;		//file path		arg
	this.logFile = logFile;			//file path		arg
	this.isDebug = isDebug;  		//boolean	 	arg
	this.xMax = 0;
	this.yMax = 0;
	this.columnH2OCount = [];  //how much water in each column
	this.lastX = 0;  //last x coordinate of drop filled
	this.lastY = 0;  //last y coordinate of drop filled
	this.lastYofX = []; //the last column from left to right of a water drop for each line (x)
	this.dropsRemaining = 0;
	this.log;
	this.lineCount = 0;
	this.resevoir = [];
}

Puzzle.prototype.toString = function() {
	var str = 'Puzzle.toString():' + '\n' +
		'inputFile =' + this.inputFile +'\n' +
		'answerFile =' + this.answerFile +'\n' +
		'logFile ='  + this.logFile +'\n' +
		'isDebug ='  + this.isDebug +'\n' +
		'xMax ='  + this.xMax +'\n' +
		'yMax ='  + this.yMax +'\n' +
		'columnH2OCount ='  + this.columnH2OCount.toString().replace(/,/g, '') +'\n' + 
		'lastX ='  + this.lastX +'\n' +
		'lastY ='  + this.lastY +'\n' +
		'lastYofX ='  + this.lastYofX.toString().replace(/,/g, '') +'\n' +
		'dropsRemaining ='  + this.dropsRemaining +'\n' +
		'log' + this.log +'\n' +
		'lineCount ='  + this.lineCount +'\n' +
		'resevoir ='  + this.resevoir.toString().replace(/,/g, '') +'\n' + 
		'endPuzzle\n';

	return str;
};

//create a custom object to solve puzzle 11
function PuzzleSolver11() {
	//inherit node.js emmitter 
	events.EventEmitter.call(this);

	//////////////////////////
	//public api
	this.solve = function (inFile, outFile, logFile, isDebug) {
		var newPuzzle = new Puzzle(inFile, outFile, logFile, isDebug);
		//puzD.add(newPuzzle);
		
		//emit when done
		this.emit('newPuzzleRegistered', newPuzzle);
	};

	//////////////////////////
	//private api
	var _setup = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _setup\n' + p + '\n')};

		//TODO: add in some nice to have info such as date/time, etc
		p.log = fs.createWriteStream(p.logFile);
		p.log.write('loggerReady: logging to ' + p.logFile);
		p.log.write('\n_setup\n ' + p +'\n');

		//emit when done
		this.emit('setupComplete', p);
	};

	//this was very tricky with readlin() operating by event emitters...don't emit data complete until rl closes
	var _readInput = function(puzzle) {
		var p = puzzle;
		var self = this;
		if (p.isDebug) {console.log('in _readInput\n' + p + '\n')};

		var writeStream = fs.createWriteStream('/dev/null'); //outstream is req by readline but we dont need it
		var readStream = fs.createReadStream(puzzle.inputFile);
		
		//ascii encoding will strip high bits and convert null to space
		readStream.setEncoding('ascii');
		//readStream.setEncoding('utf-8');

		//TODO: find a better solution to this EOF without a \n bug
		//TODO: fix nodejs.org readline.js to flush last line on EOF
		//workaround for the readline functionality that doesn't flush buffer (last line) in a file that doesn't end with \n
		readStream.on('end', function () {
			//let's fake the last line which should be solid hashes
			var crap = p.yMax;
			var crapline='';
			while (crap-- >= 0) {
				crapline = crapline + '#';
			};
			rl.emit ('line', crapline + '\n');  //yes, we lose the real last line but let's hope there was no hole in the cave.
			readStream.emit('close');
		});

		//unstable readline API in Node.js ...beware
		var rl = readline.createInterface({
			input: readStream,
			output: writeStream
		});

		puzD.add(rl);

		//copy each line of input file to the resevoir array
		rl.on('line', function (cmd) {
			p.resevoir[p.lineCount] = cmd.split('');
			p.lastYofX[p.lineCount] = 0;

			//first line is the amount of water
			if (p.lineCount == 0) {
				p.dropsRemaining = cmd * 1;
			} else if (p.lineCount == 3) { //assume 4th line has water hole in column 0
				p.yMax = cmd.lastIndexOf('#');
				p.lastX = [3];
				p.lastY = cmd.lastIndexOf('~');
				p.dropsRemaining = 1*p.dropsRemaining - 1
			}

			p.lineCount += 1;

			if(p.isDebug) {
				console.log(cmd);
				console.log('line count is ' + p.lineCount);
				console.log('line length is ' + cmd.length);
				console.log('last # in column ' + cmd.lastIndexOf('#'));
			} 
		});

		rl.on('close', function () {
			//rule: the deepness of the resevoir is linecount of input file minus the first 2 lines
			p.xMax = 1*p.lineCount - 2;
			var i = p.yMax;
			while (i >= 0) {
				p.columnH2OCount[i--] = 0;
			};
			p.columnH2OCount[0] = 1;  //the first drop loaded by the input file

			//emit when done
			p.log.write('inputComplete \n' + p + '\n');
			self.emit('inputComplete', p);  //need to emit from the PuzzleSolver11, not the readline emitter
		});
	};

	var _fillResevoir = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _fillResevoir' + p + '\n')};
		var ret = 0;
		p.tryX = 0;
		p.tryY = 0;

		while (p.dropsRemaining > 0) {
			_printCrap(p);
			p.dropsRemaining = 1*p.dropsRemaining - 1;
			
			//try down
			if (p.lastX < p.xMax) {
				p.tryX = 1*p.lastX + 1;
				if (_didFill(p,p.tryX, p.lastY)) {
					p.lastX = 1*p.tryX;
					p.lastYofX[p.lastX] = p.lastY;
					continue;
				};
			};

			//try right
			if (p.lastY < p.yMax) {
				p.tryY = 1*p.lastY + 1;
				if (_didFill(p,p.lastX, p.tryY)) {
					p.lastY = 1*p.tryY;
					p.lastYofX[p.lastX] = p.tryY;
					continue;
				};
			};

			//try up from left...remember first 2 lines are not in the resevoir
			if (p.lastX > 2) {
				p.tryX = 1*p.lastX - 1
				p.tryY = 1*p.lastYofX[p.tryX] + 1
				if (_didFill(p,p.tryX, p.tryY)) {
					p.lastX = 1*p.tryX;
					p.lastY = p.tryY;
					p.lastYofX[p.tryX] = p.tryY;
					continue;
				};
			};

			//resevoir is full edge case: don't forget to add back the current drop
			ret = 1;
			if (p.isDebug) {console.log('resevoir is full: drops remaining ' + (1*p.dropsRemaining + 1))};
			break;
		}

		//emit when done
		if (ret === 1) {
			p.log.write('\nresevoirFull\n ' + p +'\n');
			this.emit('resevoirFull', p);
		} else {
			p.log.write('\nnoMoreWater\n ' + p +'\n');
			this.emit('noMoreWater', p);
		};
	};

	var _didFill = function(p, x, y) {
		if ((p.resevoir[x][y] != undefined) && (p.resevoir[x][y] !== '~') && (p.resevoir[x][y] !== '#') ) {
			p.resevoir[x][y] = '~';
			p.columnH2OCount[y] = 1*p.columnH2OCount[y] + 1
			if (p.isDebug) {
				console.log('coordinate X,Y: '  + x + ',' + y);
			}
			return true;
		} else return false;
	};

	var _writeAnswer = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _writeAnswer\n' + p + '\n')};
		//_printCrap(p);
		var answer = fs.createWriteStream(p.answerFile);
		answer.write(p.columnH2OCount.toString().replace(/,/g, ' ') + '\n');
		answer.end();

		console.log(p.columnH2OCount.toString().replace(/,/g, ' '));

		p.log.write('\answerFileComplete\n ' + p +'\n');
		p.log.write(p.columnH2OCount.toString().replace(/,/g, ' ') + '\n');

		//emit when done
		this.emit('answerFileComplete', p);
	};

	var _cleanup = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _cleanup\n' + p + '\n')};
		//close log streams
		p.log.end();

		//emit when done
		this.emit('cleanupComplete', p);
	};

	var _puzzleSolved = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _puzzleSolved\n' + p + '\n')};

		//emit when done
		this.emit('puzzleSolved', p);
	};

	var _errorHandler = function(puzzle) {
		var p = puzzle;
		if (p.isDebug) {console.log('in _errorHandler\n' + p + '\n')};

		//emit when done
		this.emit('applicationError', p);
	};

	var _printCrap = function(puzzle) {
		var p = puzzle;

		if (p.isDebug) {
			console.log('in _printCrap\n' + p + '\n');
			console.log(p.resevoir.toString().replace(/,/g, ''));
			//console.log('first water drip is ' + p.resevoir[3][0] + ' at ' + '3,0');
			console.log('last water drip is ~' + ' at ' + p.lastX + ',' + p.lastY);
			console.log('drops remaining = ' + p.dropsRemaining);
			console.log('lastX ' + p.lastX);
			console.log('lastY ' + p.lastY);
			console.log(p.columnH2OCount.toString().replace(/,/g, ' '));
		}

		p.log.write('\n' + p.resevoir.toString().replace(/,/g, ''));
		//p.log.write('\n' + 'first water drip is ' + p.resevoir[3][0] + ' at ' + '3,0');
		p.log.write('\n' + 'last water drip is ~' + ' at ' + p.lastX + ',' + p.lastY);
		p.log.write('\n' + 'drops remaining = ' + p.dropsRemaining);
		p.log.write('\n' + 'lastX ' + p.lastX);
		p.log.write('\n' + 'lastY ' + p.lastY);
		p.log.write('\n' + p.columnH2OCount.toString().replace(/,/g, ' '));

	};

	//////////////////////////
	//   puzzleSolver workflow
	this.on('newPuzzleRegistered', _setup);
	this.on('setupComplete', _readInput);
	this.on('inputComplete', _fillResevoir);
	this.on('resevoirFull', _writeAnswer);
	this.on('noMoreWater', _writeAnswer);
	this.on('answerFileComplete', _cleanup);
	this.on('cleanupComplete', _puzzleSolved);
	//this.on('error', _errorHandler);

};

//TODO: implement this error object to help with debugging
//info from http://www.devthought.com/2011/12/22/a-string-is-not-an-error/
function PuzzleError (puzzle) {
	Error.call(this);
	Error.captureStackTrace(this, arguments.callee);
	this.puzzle = puzzle;
	this.name = 'PuzzleError';

};

PuzzleError.prototype.__proto__= Error.prototype;

puzD.on('error', function(er) {
	console.log('domain error handler invoked: ' + er);
	console.log('domain error handler invoked:domain ' + er.domain);
	console.log('domain error handler invoked:domain emitter ' + er.domain_emitter);
	console.log('domain error handler invoked:domain bound ' + er.domain_bound);
	console.log('domain error handler invoked:domain thrown ' + er.domain_thrown);
	console.log(typeof er.stack);
	console.log(er.stack);

	//emit when done
	this.emit('applicationError');  //not quite working at this time... wrong emitter?

});

//read the blog for a description of this code about inherting event emitters
util.inherits(PuzzleSolver11, events.EventEmitter);
module.exports = new PuzzleSolver11();
//The following line adds PuzzlerSolver11 to the domain.
//This will allow errors to be processed by the domain error handler. 
//When commented out(not added to the domain):  the error is thrown, the app is halted and the stack is dumped to console.
puzD.add(module.exports);
