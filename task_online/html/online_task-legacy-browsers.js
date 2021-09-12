/******************** 
 * Online_Task Test *
 ********************/

// init psychoJS:
const psychoJS = new PsychoJS({
  debug: true
});

// open window:
psychoJS.openWindow({
  fullscr: true,
  color: new util.Color([0, 0, 0]),
  units: 'height',
  waitBlanking: true
});

// store info about the experiment session:
let expName = 'online_task';  // from the Builder filename that created this script
let expInfo = {'participant': '123456.8790', 'session': '001', 'group': '2', 'order': '15'};

// schedule the experiment:
psychoJS.schedule(psychoJS.gui.DlgFromDict({
  dictionary: expInfo,
  title: expName
}));

const flowScheduler = new Scheduler(psychoJS);
const dialogCancelScheduler = new Scheduler(psychoJS);
psychoJS.scheduleCondition(function() { return (psychoJS.gui.dialogComponent.button === 'OK'); }, flowScheduler, dialogCancelScheduler);

// flowScheduler gets run if the participants presses OK
flowScheduler.add(updateInfo); // add timeStamp
flowScheduler.add(experimentInit);
flowScheduler.add(welcomeRoutineBegin());
flowScheduler.add(welcomeRoutineEachFrame());
flowScheduler.add(welcomeRoutineEnd());
flowScheduler.add(instr_prRoutineBegin());
flowScheduler.add(instr_prRoutineEachFrame());
flowScheduler.add(instr_prRoutineEnd());
const conditionsLoopScheduler = new Scheduler(psychoJS);
flowScheduler.add(conditionsLoopBegin, conditionsLoopScheduler);
flowScheduler.add(conditionsLoopScheduler);
flowScheduler.add(conditionsLoopEnd);
flowScheduler.add(the_endRoutineBegin());
flowScheduler.add(the_endRoutineEachFrame());
flowScheduler.add(the_endRoutineEnd());
flowScheduler.add(quitPsychoJS, '', true);

// quit if user presses Cancel in dialog box:
dialogCancelScheduler.add(quitPsychoJS, '', false);

psychoJS.start({
  expName: expName,
  expInfo: expInfo,
  });


var frameDur;
function updateInfo() {
  expInfo['date'] = util.MonotonicClock.getDateStr();  // add a simple timestamp
  expInfo['expName'] = expName;
  expInfo['psychopyVersion'] = '2020.1.2';
  expInfo['OS'] = window.navigator.platform;

  // store frame rate of monitor if we can measure it successfully
  expInfo['frameRate'] = psychoJS.window.getActualFrameRate();
  if (typeof expInfo['frameRate'] !== 'undefined')
    frameDur = 1.0 / Math.round(expInfo['frameRate']);
  else
    frameDur = 1.0 / 60.0; // couldn't get a reliable measure so guess

  // add info from the URL:
  util.addInfoFromUrl(expInfo);
  psychoJS.setRedirectUrls(((('https://edinburghinformatics.eu.qualtrics.com/jfe/form/SV_802qCn2VjZSMop7?participant=' + expInfo['participant']) + '&GROUP=') + expInfo['group']), 'https://www.prolific.co/');

  return Scheduler.Event.NEXT;
}


var welcomeClock;
var welcome_text;
var welcome_key;
var RNG;
var seed;
var instr_prClock;
var ls_text_ship;
var ls_ship_key;
var initialiseClock;
var task_warn;
var key;
var waitClock;
var wait_bg;
var faster_txt;
var key_resp;
var stage1Clock;
var s1_right;
var s1_left;
var bg_s1;
var stage_1;
var post_stage1Clock;
var s1_right_post;
var s1_left_post;
var bg_s1_post;
var stage2Clock;
var bg_s2;
var s2_right;
var s2_left;
var prev_s1;
var stage_2;
var post_stage2Clock;
var bg_post_s2;
var prev_s1_again;
var s2_post_right;
var s2_post_left;
var rewardClock;
var bg_reward;
var reward_img;
var prev_s2;
var rew_tex;
var restClock;
var key_break;
var text_break;
var the_endClock;
var end_text;
var end_txt_key;
var globalClock;
var routineTimer;
function experimentInit() {
  // Initialize components for Routine "welcome"
  welcomeClock = new util.Clock();
  welcome_text = new visual.TextStim({
    win: psychoJS.window,
    name: 'welcome_text',
    text: "Welcome to the treasure hunting game!\n\nPlease follow the instructions carefully to know how the game works in practice.\n\nBefore completing the actual game, you will do a couple of practice rounds.\n\nDo not press 'esc', as this will close the game, unless you wish to.\n\nLet’s begin! Press 'c' to continue.",
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.045,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: 0.0 
  });
  
  welcome_key = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  /**
   * Seedable random number generator functions.
   * @version 1.0.0
   * @license Public Domain
   *
   * @example
   * var rng = new RNG('Example');
   * rng.random(40, 50);  // =>  42
   * rng.uniform();       // =>  0.7972798995050903
   * rng.normal();        // => -0.6698504543216376
   * rng.exponential();   // =>  1.0547367609131555
   * rng.poisson(4);      // =>  2
   * rng.gamma(4);        // =>  2.781724687386858
   */
  
  /**
   * @param {String} seed A string to seed the generator.
   * @constructor
   */
  function RC4(seed) {
      this.s = new Array(256);
      this.i = 0;
      this.j = 0;
      for (var i = 0; i < 256; i++) {
          this.s[i] = i;
      }
      if (seed) {
          this.mix(seed);
      }
  }
  
  /**
   * Get the underlying bytes of a string.
   * @param {string} string
   * @returns {Array} An array of bytes
   */
  RC4.getStringBytes = function(string) {
      var output = [];
      for (var i = 0; i < string.length; i++) {
          var c = string.charCodeAt(i);
          var bytes = [];
          do {
              bytes.push(c & 0xFF);
              c = c >> 8;
          } while (c > 0);
          output = output.concat(bytes.reverse());
      }
      return output;
  };
  
  RC4.prototype._swap = function(i, j) {
      var tmp = this.s[i];
      this.s[i] = this.s[j];
      this.s[j] = tmp;
  };
  
  /**
   * Mix additional entropy into this generator.
   * @param {String} seed
   */
  RC4.prototype.mix = function(seed) {
      var input = RC4.getStringBytes(seed);
      var j = 0;
      for (var i = 0; i < this.s.length; i++) {
          j += this.s[i] + input[i % input.length];
          j %= 256;
          this._swap(i, j);
      }
  };
  
  /**
   * @returns {number} The next byte of output from the generator.
   */
  RC4.prototype.next = function() {
      this.i = (this.i + 1) % 256;
      this.j = (this.j + this.s[this.i]) % 256;
      this._swap(this.i, this.j);
      return this.s[(this.s[this.i] + this.s[this.j]) % 256];
  };
  
  /**
   * Create a new random number generator with optional seed. If the
   * provided seed is a function (i.e. Math.random) it will be used as
   * the uniform number generator.
   * @param seed An arbitrary object used to seed the generator.
   * @constructor
   */
  RNG = function(seed) {
      if (seed == null) {
          seed = '' + Math.random() + Date.now();
      } else if (typeof seed === "function") {
          // Use it as a uniform number generator
          this.uniform = seed;
          this.nextByte = function() {
              return ~~(this.uniform() * 256);
          };
          seed = null;
      } else if (Object.prototype.toString.call(seed) !== "[object String]") {
          seed = JSON.stringify(seed);
      }
      this._normal = null;
      if (seed) {
          this._state = new RC4(seed);
      } else {
          this._state = null;
      }
  }
  
  /**
   * @returns {number} Uniform random number between 0 and 255.
   */
  RNG.prototype.nextByte = function() {
      return this._state.next();
  };
  
  /**
   * @returns {number} Uniform random number between 0 and 1.
   */
  RNG.prototype.uniform = function() {
      var BYTES = 7; // 56 bits to make a 53-bit double
      var output = 0;
      for (var i = 0; i < BYTES; i++) {
          output *= 256;
          output += this.nextByte();
      }
      return output / (Math.pow(2, BYTES * 8) - 1);
  };
  
  /**
   * Produce a random integer within [n, m).
   * @param {number} [n=0]
   * @param {number} m
   *
   */
  RNG.prototype.random = function(n, m) {
      if (n == null) {
          return this.uniform();
      } else if (m == null) {
          m = n;
          n = 0;
      }
      return n + Math.floor(this.uniform() * (m - n));
  };
  
  /**
   * Generates numbers using this.uniform() with the Box-Muller transform.
   * @returns {number} Normally-distributed random number of mean 0, variance 1.
   */
  RNG.prototype.normal = function() {
      if (this._normal !== null) {
          var n = this._normal;
          this._normal = null;
          return n;
      } else {
          var x = this.uniform() || Math.pow(2, -53); // can't be exactly 0
          var y = this.uniform();
          this._normal = Math.sqrt(-2 * Math.log(x)) * Math.sin(2 * Math.PI * y);
          return Math.sqrt(-2 * Math.log(x)) * Math.cos(2 * Math.PI * y);
      }
  };
  
  /**
   * Generates numbers using this.uniform().
   * @returns {number} Number from the exponential distribution, lambda = 1.
   */
  RNG.prototype.exponential = function() {
      return -Math.log(this.uniform() || Math.pow(2, -53));
  };
  
  /**
   * Generates numbers using this.uniform() and Knuths method.
   * @param {number} [mean=1]
   * @returns {number} Number from the Poisson distribution.
   */
  RNG.prototype.poisson = function(mean) {
      var L = Math.exp(-(mean || 1));
      var k = 0, p = 1;
      do {
          k++;
          p *= this.uniform();
      } while (p > L);
      return k - 1;
  };
  
  /**
   * Generates numbers using this.uniform(), this.normal(),
   * this.exponential(), and the Marsaglia-Tsang method.
   * @param {number} a
   * @returns {number} Number from the gamma distribution.
   */
  RNG.prototype.gamma = function(a) {
      var d = (a < 1 ? 1 + a : a) - 1 / 3;
      var c = 1 / Math.sqrt(9 * d);
      do {
          do {
              var x = this.normal();
              var v = Math.pow(c * x + 1, 3);
          } while (v <= 0);
          var u = this.uniform();
          var x2 = Math.pow(x, 2);
      } while (u >= 1 - 0.0331 * x2 * x2 &&
               Math.log(u) >= 0.5 * x2 + d * (1 - v + Math.log(v)));
      if (a < 1) {
          return d * v * Math.exp(this.exponential() / -a);
      } else {
          return d * v;
      }
  };
  
  /**
   * Accepts a dice rolling notation string and returns a generator
   * function for that distribution. The parser is quite flexible.
   * @param {string} expr A dice-rolling, expression i.e. '2d6+10'.
   * @param {RNG} rng An optional RNG object.
   * @returns {Function}
   */
  RNG.roller = function(expr, rng) {
      var parts = expr.split(/(\d+)?d(\d+)([+-]\d+)?/).slice(1);
      var dice = parseFloat(parts[0]) || 1;
      var sides = parseFloat(parts[1]);
      var mod = parseFloat(parts[2]) || 0;
      rng = rng || new RNG();
      return function() {
          var total = dice + mod;
          for (var i = 0; i < dice; i++) {
              total += rng.random(sides);
          }
          return total;
      };
  };
  
  /* Provide a pre-made generator instance. */
  RNG.$ = new RNG();
  
  seed=Math.random();
  
  // Initialize components for Routine "instr_pr"
  instr_prClock = new util.Clock();
  ls_text_ship = new visual.TextStim({
    win: psychoJS.window,
    name: 'ls_text_ship',
    text: "When the practice starts, you will first select a ship to board (press ‘left’ or ‘right’). Remember, sometimes the ship will take you to an island you didn’t want.\n\nOnce you’ve reached the island, you will attempt to collect the treasure from one of the chests (press ‘left’ or ‘right’). Initially, try to explore each chest.\n\nCollect as many pirate coins as possible. Pay attention to which chest is more favourable.\n\nHere, there is no time-limit and the practice does not count, but in the experiment, you have 1.5 seconds for each choice. This will be enough once you have practiced.\n\nThink carefully about your strategy but also follow your gut. You will gain more coins when you concentrate.\n\nPress 'c' to continue.",
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.0365,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: 0.0 
  });
  
  ls_ship_key = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "initialise"
  initialiseClock = new util.Clock();
  task_warn = new visual.TextStim({
    win: psychoJS.window,
    name: 'task_warn',
    text: 'default text',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.06,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -2.0 
  });
  
  key = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "wait"
  waitClock = new util.Clock();
  wait_bg = new visual.ImageStim({
    win : psychoJS.window,
    name : 'wait_bg', units : 'norm', 
    image : 'jpg/empty.jpg', mask : undefined,
    ori : 0, pos : [0, 0], size : [3, 3],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : 0.0 
  });
  faster_txt = new visual.TextStim({
    win: psychoJS.window,
    name: 'faster_txt',
    text: 'default text',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.1,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -1.0 
  });
  
  key_resp = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "stage1"
  stage1Clock = new util.Clock();
  s1_right = new visual.ImageStim({
    win : psychoJS.window,
    name : 's1_right', units : undefined, 
    image : 'jpg/s1/fractal_stage1_s1_2.jpg', mask : undefined,
    ori : 0, pos : [0.35, (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : 0.0 
  });
  s1_left = new visual.ImageStim({
    win : psychoJS.window,
    name : 's1_left', units : undefined, 
    image : 'jpg/s1/fractal_stage1_s1_1.jpg', mask : undefined,
    ori : 0, pos : [(- 0.35), (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -1.0 
  });
  bg_s1 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'bg_s1', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : [1, 1],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -2.0 
  });
  stage_1 = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "post_stage1"
  post_stage1Clock = new util.Clock();
  s1_right_post = new visual.ImageStim({
    win : psychoJS.window,
    name : 's1_right_post', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0.35, (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : 0.0 
  });
  s1_left_post = new visual.ImageStim({
    win : psychoJS.window,
    name : 's1_left_post', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [(- 0.35), (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -1.0 
  });
  bg_s1_post = new visual.ImageStim({
    win : psychoJS.window,
    name : 'bg_s1_post', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : [1, 1],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -2.0 
  });
  // Initialize components for Routine "stage2"
  stage2Clock = new util.Clock();
  bg_s2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'bg_s2', units : 'norm', 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : [2, 2],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -1.0 
  });
  s2_right = new visual.ImageStim({
    win : psychoJS.window,
    name : 's2_right', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0.35, (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -2.0 
  });
  s2_left = new visual.ImageStim({
    win : psychoJS.window,
    name : 's2_left', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [(- 0.35), (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -3.0 
  });
  prev_s1 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'prev_s1', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0.35], size : [0.15, 0.15],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -4.0 
  });
  stage_2 = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Initialize components for Routine "post_stage2"
  post_stage2Clock = new util.Clock();
  bg_post_s2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'bg_post_s2', units : 'norm', 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : [2, 2],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : 0.0 
  });
  prev_s1_again = new visual.ImageStim({
    win : psychoJS.window,
    name : 'prev_s1_again', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0.35], size : [0.15, 0.15],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -1.0 
  });
  s2_post_right = new visual.ImageStim({
    win : psychoJS.window,
    name : 's2_post_right', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0.35, (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -2.0 
  });
  s2_post_left = new visual.ImageStim({
    win : psychoJS.window,
    name : 's2_post_left', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [(- 0.35), (- 0.075)], size : [0.5, 0.5],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -3.0 
  });
  // Initialize components for Routine "reward"
  rewardClock = new util.Clock();
  bg_reward = new visual.ImageStim({
    win : psychoJS.window,
    name : 'bg_reward', units : 'norm', 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0], size : [2, 2],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -1.0 
  });
  reward_img = new visual.ImageStim({
    win : psychoJS.window,
    name : 'reward_img', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, (- 0.12)], size : [0.65, 0.65],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -2.0 
  });
  prev_s2 = new visual.ImageStim({
    win : psychoJS.window,
    name : 'prev_s2', units : undefined, 
    image : undefined, mask : undefined,
    ori : 0, pos : [0, 0.35], size : [0.15, 0.15],
    color : new util.Color([1, 1, 1]), opacity : 1,
    flipHoriz : false, flipVert : false,
    texRes : 128, interpolate : true, depth : -5.0 
  });
  rew_tex = "";
  
  // Initialize components for Routine "rest"
  restClock = new util.Clock();
  key_break = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  text_break = new visual.TextStim({
    win: psychoJS.window,
    name: 'text_break',
    text: 'default text',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.06,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -2.0 
  });
  
  // Initialize components for Routine "the_end"
  the_endClock = new util.Clock();
  end_text = new visual.TextStim({
    win: psychoJS.window,
    name: 'end_text',
    text: 'default text',
    font: 'Arial',
    units: undefined, 
    pos: [0, 0], height: 0.05,  wrapWidth: undefined, ori: 0,
    color: new util.Color('white'),  opacity: 1,
    depth: -1.0 
  });
  
  end_txt_key = new core.Keyboard({psychoJS: psychoJS, clock: new util.Clock(), waitForStart: true});
  
  // Create some handy timers
  globalClock = new util.Clock();  // to track the time since experiment started
  routineTimer = new util.CountdownTimer();  // to track time remaining of each (non-slip) routine
  
  return Scheduler.Event.NEXT;
}


var t;
var frameN;
var _welcome_key_allKeys;
var welcomeComponents;
function welcomeRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'welcome'-------
    t = 0;
    welcomeClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    welcome_key.keys = undefined;
    welcome_key.rt = undefined;
    _welcome_key_allKeys = [];
    // keep track of which components have finished
    welcomeComponents = [];
    welcomeComponents.push(welcome_text);
    welcomeComponents.push(welcome_key);
    
    welcomeComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


var continueRoutine;
function welcomeRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'welcome'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = welcomeClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *welcome_text* updates
    if (t >= 0.0 && welcome_text.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      welcome_text.tStart = t;  // (not accounting for frame time here)
      welcome_text.frameNStart = frameN;  // exact frame index
      
      welcome_text.setAutoDraw(true);
    }

    
    // *welcome_key* updates
    if (t >= 0.0 && welcome_key.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      welcome_key.tStart = t;  // (not accounting for frame time here)
      welcome_key.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { welcome_key.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { welcome_key.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { welcome_key.clearEvents(); });
    }

    if (welcome_key.status === PsychoJS.Status.STARTED) {
      let theseKeys = welcome_key.getKeys({keyList: ['c'], waitRelease: false});
      _welcome_key_allKeys = _welcome_key_allKeys.concat(theseKeys);
      if (_welcome_key_allKeys.length > 0) {
        welcome_key.keys = _welcome_key_allKeys[_welcome_key_allKeys.length - 1].name;  // just the last key pressed
        welcome_key.rt = _welcome_key_allKeys[_welcome_key_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    welcomeComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function welcomeRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'welcome'-------
    welcomeComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "welcome" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var _ls_ship_key_allKeys;
var t_count;
var running_reward;
var reward_type;
var tr_rews;
var rew_check;
var instr_prComponents;
function instr_prRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'instr_pr'-------
    t = 0;
    instr_prClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    ls_ship_key.keys = undefined;
    ls_ship_key.rt = undefined;
    _ls_ship_key_allKeys = [];
    t_count = 0;
    running_reward = 0;
    
    if ((expInfo["group"] === "1")) {
        reward_type = ["practice", "neutral", "neutral", "trigger", "trigger"];
    } else {
        if ((expInfo["group"] === "2")) {
            reward_type = ["practice", "trigger", "trigger", "neutral", "neutral"];
        }
    }
    tr_rews = expInfo["order"];
    rew_check = [38, 75, 113];
    
    // keep track of which components have finished
    instr_prComponents = [];
    instr_prComponents.push(ls_text_ship);
    instr_prComponents.push(ls_ship_key);
    
    instr_prComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function instr_prRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'instr_pr'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = instr_prClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *ls_text_ship* updates
    if (t >= 0.0 && ls_text_ship.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      ls_text_ship.tStart = t;  // (not accounting for frame time here)
      ls_text_ship.frameNStart = frameN;  // exact frame index
      
      ls_text_ship.setAutoDraw(true);
    }

    
    // *ls_ship_key* updates
    if (t >= 0.0 && ls_ship_key.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      ls_ship_key.tStart = t;  // (not accounting for frame time here)
      ls_ship_key.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { ls_ship_key.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { ls_ship_key.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { ls_ship_key.clearEvents(); });
    }

    if (ls_ship_key.status === PsychoJS.Status.STARTED) {
      let theseKeys = ls_ship_key.getKeys({keyList: ['c'], waitRelease: false});
      _ls_ship_key_allKeys = _ls_ship_key_allKeys.concat(theseKeys);
      if (_ls_ship_key_allKeys.length > 0) {
        ls_ship_key.keys = _ls_ship_key_allKeys[_ls_ship_key_allKeys.length - 1].name;  // just the last key pressed
        ls_ship_key.rt = _ls_ship_key_allKeys[_ls_ship_key_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    instr_prComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function instr_prRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'instr_pr'-------
    instr_prComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "instr_pr" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var conditions;
var currentLoop;
function conditionsLoopBegin(thisScheduler) {
  // set up handler to look after randomisation of conditions etc
  conditions = new TrialHandler({
    psychoJS: psychoJS,
    nReps: 1, method: TrialHandler.Method.SEQUENTIAL,
    extraInfo: expInfo, originPath: undefined,
    trialList: 'html/resources/n_trials.xlsx',
    seed: undefined, name: 'conditions'
  });
  psychoJS.experiment.addLoop(conditions); // add the loop to the experiment
  currentLoop = conditions;  // we're now the current loop

  // Schedule all the trials in the trialList:
  conditions.forEach(function() {
    const snapshot = conditions.getSnapshot();

    thisScheduler.add(importConditions(snapshot));
    thisScheduler.add(initialiseRoutineBegin(snapshot));
    thisScheduler.add(initialiseRoutineEachFrame(snapshot));
    thisScheduler.add(initialiseRoutineEnd(snapshot));
    const ntLoopScheduler = new Scheduler(psychoJS);
    thisScheduler.add(ntLoopBegin, ntLoopScheduler);
    thisScheduler.add(ntLoopScheduler);
    thisScheduler.add(ntLoopEnd);
    thisScheduler.add(restRoutineBegin(snapshot));
    thisScheduler.add(restRoutineEachFrame(snapshot));
    thisScheduler.add(restRoutineEnd(snapshot));
    thisScheduler.add(endLoopIteration(thisScheduler, snapshot));
  });

  return Scheduler.Event.NEXT;
}


var nt;
function ntLoopBegin(thisScheduler) {
  // set up handler to look after randomisation of conditions etc
  nt = new TrialHandler({
    psychoJS: psychoJS,
    nReps: n_trials, method: TrialHandler.Method.SEQUENTIAL,
    extraInfo: expInfo, originPath: undefined,
    trialList: undefined,
    seed: undefined, name: 'nt'
  });
  psychoJS.experiment.addLoop(nt); // add the loop to the experiment
  currentLoop = nt;  // we're now the current loop

  // Schedule all the trials in the trialList:
  nt.forEach(function() {
    const snapshot = nt.getSnapshot();

    thisScheduler.add(importConditions(snapshot));
    thisScheduler.add(waitRoutineBegin(snapshot));
    thisScheduler.add(waitRoutineEachFrame(snapshot));
    thisScheduler.add(waitRoutineEnd(snapshot));
    thisScheduler.add(stage1RoutineBegin(snapshot));
    thisScheduler.add(stage1RoutineEachFrame(snapshot));
    thisScheduler.add(stage1RoutineEnd(snapshot));
    thisScheduler.add(post_stage1RoutineBegin(snapshot));
    thisScheduler.add(post_stage1RoutineEachFrame(snapshot));
    thisScheduler.add(post_stage1RoutineEnd(snapshot));
    thisScheduler.add(stage2RoutineBegin(snapshot));
    thisScheduler.add(stage2RoutineEachFrame(snapshot));
    thisScheduler.add(stage2RoutineEnd(snapshot));
    thisScheduler.add(post_stage2RoutineBegin(snapshot));
    thisScheduler.add(post_stage2RoutineEachFrame(snapshot));
    thisScheduler.add(post_stage2RoutineEnd(snapshot));
    thisScheduler.add(rewardRoutineBegin(snapshot));
    thisScheduler.add(rewardRoutineEachFrame(snapshot));
    thisScheduler.add(rewardRoutineEnd(snapshot));
    thisScheduler.add(endLoopIteration(thisScheduler, snapshot));
  });

  return Scheduler.Event.NEXT;
}


function ntLoopEnd() {
  psychoJS.experiment.removeLoop(nt);

  return Scheduler.Event.NEXT;
}


function conditionsLoopEnd() {
  psychoJS.experiment.removeLoop(conditions);

  return Scheduler.Event.NEXT;
}


var r11;
var r12;
var r21;
var r22;
var sigma;
var prob_rew;
var t1;
var t2;
var t3;
var t4;
var t5;
var t6;
var faster;
var _key_allKeys;
var initialiseComponents;
function initialiseRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'initialise'-------
    t = 0;
    initialiseClock.reset(); // clock
    frameN = -1;
    routineTimer.add(3.000000);
    // update component parameters for each repeat
    r11 = (((0.72 - 0.58) * Math.random()) + 0.58);
    r12 = (((0.45 - 0.31) * Math.random()) + 0.31);
    r21 = (((0.45 - 0.31) * Math.random()) + 0.31);
    r22 = (((0.72 - 0.58) * Math.random()) + 0.58);
    if ((t_count === 0)) {
        sigma = (0.025 * 1.1);
        prob_rew = {"11": r12, "12": r11, "21": r21, "22": r22};
    }
    if ((t_count === 1)) {
        sigma = (0.025 * 1.1);
        prob_rew = {"11": r11, "12": r12, "21": r21, "22": r22};
    }
    if ((t_count === 3)) {
        sigma = (0.025 * 1.1);
        prob_rew = {"11": r12, "12": r11, "21": r22, "22": r21};
    }
    
    if ((t_count > 0)) {
        t1 = 1.5;
        t2 = 0.375;
        t3 = 1.5;
        t4 = 0.375;
        t5 = 1;
        t6 = 0.25;
        faster = " ";
    } else {
        if ((t_count === 0)) {
            t1 = 120;
            t2 = 0.375;
            t3 = 120;
            t4 = 0.375;
            t5 = 2;
            t6 = 0.25;
            faster = " ";
        }
    }
    
    key.keys = undefined;
    key.rt = undefined;
    _key_allKeys = [];
    // keep track of which components have finished
    initialiseComponents = [];
    initialiseComponents.push(task_warn);
    initialiseComponents.push(key);
    
    initialiseComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


var countdown;
var timer_text;
var frameRemains;
function initialiseRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'initialise'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = initialiseClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    countdown = Math.round((3 - t));
    if ((countdown === 0)) {
        timer_text = "Go!";
    } else {
        if ((t_count > 0)) {
            timer_text = ("Get ready! The task begins in: " + countdown.toString());
        } else {
            if ((t_count === 0)) {
                timer_text = ("Get ready! The practice begins in: " + countdown.toString());
            }
        }
    }
    
    
    // *task_warn* updates
    if (t >= 0.0 && task_warn.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      task_warn.tStart = t;  // (not accounting for frame time here)
      task_warn.frameNStart = frameN;  // exact frame index
      
      task_warn.setAutoDraw(true);
    }

    frameRemains = 0.0 + 3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (task_warn.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      task_warn.setAutoDraw(false);
    }
    
    if (task_warn.status === PsychoJS.Status.STARTED){ // only update if being drawn
      task_warn.setText(timer_text);
    }
    
    // *key* updates
    if (t >= 0.0 && key.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key.tStart = t;  // (not accounting for frame time here)
      key.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key.clearEvents(); });
    }

    frameRemains = 0.0 + 3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (key.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      key.status = PsychoJS.Status.FINISHED;
  }

    if (key.status === PsychoJS.Status.STARTED) {
      let theseKeys = key.getKeys({keyList: ['h'], waitRelease: false});
      _key_allKeys = _key_allKeys.concat(theseKeys);
      if (_key_allKeys.length > 0) {
        key.keys = _key_allKeys[_key_allKeys.length - 1].name;  // just the last key pressed
        key.rt = _key_allKeys[_key_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    initialiseComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine && routineTimer.getTime() > 0) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function initialiseRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'initialise'-------
    initialiseComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    return Scheduler.Event.NEXT;
  };
}


var _key_resp_allKeys;
var waitComponents;
function waitRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'wait'-------
    t = 0;
    waitClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    faster_txt.setColor(new util.Color('red'));
    faster_txt.setText(faster);
    key_resp.keys = undefined;
    key_resp.rt = undefined;
    _key_resp_allKeys = [];
    // keep track of which components have finished
    waitComponents = [];
    waitComponents.push(wait_bg);
    waitComponents.push(faster_txt);
    waitComponents.push(key_resp);
    
    waitComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function waitRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'wait'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = waitClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *wait_bg* updates
    if (t >= 0.0 && wait_bg.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      wait_bg.tStart = t;  // (not accounting for frame time here)
      wait_bg.frameNStart = frameN;  // exact frame index
      
      wait_bg.setAutoDraw(true);
    }

    frameRemains = 0.0 + t6 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (wait_bg.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      wait_bg.setAutoDraw(false);
    }
    
    // *faster_txt* updates
    if (t >= 0.0 && faster_txt.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      faster_txt.tStart = t;  // (not accounting for frame time here)
      faster_txt.frameNStart = frameN;  // exact frame index
      
      faster_txt.setAutoDraw(true);
    }

    frameRemains = 0.0 + t6 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (faster_txt.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      faster_txt.setAutoDraw(false);
    }
    
    // *key_resp* updates
    if (t >= 0.0 && key_resp.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_resp.tStart = t;  // (not accounting for frame time here)
      key_resp.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_resp.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_resp.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_resp.clearEvents(); });
    }

    frameRemains = 0.0 + t6 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (key_resp.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      key_resp.status = PsychoJS.Status.FINISHED;
  }

    if (key_resp.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_resp.getKeys({keyList: ['c'], waitRelease: false});
      _key_resp_allKeys = _key_resp_allKeys.concat(theseKeys);
      if (_key_resp_allKeys.length > 0) {
        key_resp.keys = _key_resp_allKeys[_key_resp_allKeys.length - 1].name;  // just the last key pressed
        key_resp.rt = _key_resp_allKeys[_key_resp_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    waitComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function waitRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'wait'-------
    waitComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    faster = " ";
    t6 = 0.25;
    
    // the Routine "wait" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var _stage_1_allKeys;
var stage1Components;
function stage1RoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'stage1'-------
    t = 0;
    stage1Clock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    stage_1.keys = undefined;
    stage_1.rt = undefined;
    _stage_1_allKeys = [];
    // keep track of which components have finished
    stage1Components = [];
    stage1Components.push(s1_right);
    stage1Components.push(s1_left);
    stage1Components.push(bg_s1);
    stage1Components.push(stage_1);
    
    stage1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function stage1RoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'stage1'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = stage1Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *s1_right* updates
    if (t >= 0.0 && s1_right.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s1_right.tStart = t;  // (not accounting for frame time here)
      s1_right.frameNStart = frameN;  // exact frame index
      
      s1_right.setAutoDraw(true);
    }

    frameRemains = 0.0 + t1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s1_right.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s1_right.setAutoDraw(false);
    }
    
    // *s1_left* updates
    if (t >= 0.0 && s1_left.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s1_left.tStart = t;  // (not accounting for frame time here)
      s1_left.frameNStart = frameN;  // exact frame index
      
      s1_left.setAutoDraw(true);
    }

    frameRemains = 0.0 + t1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s1_left.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s1_left.setAutoDraw(false);
    }
    
    // *bg_s1* updates
    if (t >= 0.0 && bg_s1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      bg_s1.tStart = t;  // (not accounting for frame time here)
      bg_s1.frameNStart = frameN;  // exact frame index
      
      bg_s1.setAutoDraw(true);
    }

    frameRemains = 0.0 + t1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (bg_s1.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      bg_s1.setAutoDraw(false);
    }
    
    // *stage_1* updates
    if (t >= 0.0 && stage_1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      stage_1.tStart = t;  // (not accounting for frame time here)
      stage_1.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { stage_1.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { stage_1.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { stage_1.clearEvents(); });
    }

    frameRemains = 0.0 + t1 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (stage_1.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      stage_1.status = PsychoJS.Status.FINISHED;
  }

    if (stage_1.status === PsychoJS.Status.STARTED) {
      let theseKeys = stage_1.getKeys({keyList: ['left', 'right'], waitRelease: false});
      _stage_1_allKeys = _stage_1_allKeys.concat(theseKeys);
      if (_stage_1_allKeys.length > 0) {
        stage_1.keys = _stage_1_allKeys[0].name;  // just the first key pressed
        stage_1.rt = _stage_1_allKeys[0].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    stage1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var stage1_choice;
function stage1RoutineEnd(trials) {
  return function () {
    //------Ending Routine 'stage1'-------
    stage1Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('stage_1.keys', stage_1.keys);
    if (typeof stage_1.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('stage_1.rt', stage_1.rt);
        routineTimer.reset();
        }
    
    stage_1.stop();
    if ((! stage_1.keys)) {
        faster = "Try faster!\n\n\nPress \u2018c\u2019 to continue";
        t2 = 0;
        t3 = 0;
        t4 = 0;
        t5 = 0;
        t6 = 3600;
        continueRoutine = false;
    }
    stage1_choice = 0;
    if ((stage_1.keys === "left")) {
        stage1_choice = 1;
    }
    if ((stage_1.keys === "right")) {
        stage1_choice = 2;
    }
    psychoJS.experiment.addData("stage1_choice", stage1_choice);
    
    // the Routine "stage1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var post_stage1Components;
function post_stage1RoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'post_stage1'-------
    t = 0;
    post_stage1Clock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    if ((! stage_1.keys)) {
        s1_left_post.setImage("jpg/empty.jpg");
        s1_right_post.setImage("jpg/empty.jpg");
        continueRoutine = false;
        
    }
    if ((stage_1.keys === "left")) {
        s1_left_post.setImage("jpg/s1/fractal_stage1_s1_1_act.jpg");
        s1_right_post.setImage("jpg/s1/fractal_stage1_s1_2_deact.jpg");
    }
    if ((stage_1.keys === "right")) {
        s1_left_post.setImage("jpg/s1/fractal_stage1_s1_1_deact.jpg");
        s1_right_post.setImage("jpg/s1/fractal_stage1_s1_2_act.jpg");
    }
    
    
    
    // keep track of which components have finished
    post_stage1Components = [];
    post_stage1Components.push(s1_right_post);
    post_stage1Components.push(s1_left_post);
    post_stage1Components.push(bg_s1_post);
    
    post_stage1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function post_stage1RoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'post_stage1'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = post_stage1Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *s1_right_post* updates
    if (t >= 0.0 && s1_right_post.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s1_right_post.tStart = t;  // (not accounting for frame time here)
      s1_right_post.frameNStart = frameN;  // exact frame index
      
      s1_right_post.setAutoDraw(true);
    }

    frameRemains = 0.0 + t2 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s1_right_post.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s1_right_post.setAutoDraw(false);
    }
    
    // *s1_left_post* updates
    if (t >= 0.0 && s1_left_post.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s1_left_post.tStart = t;  // (not accounting for frame time here)
      s1_left_post.frameNStart = frameN;  // exact frame index
      
      s1_left_post.setAutoDraw(true);
    }

    frameRemains = 0.0 + t2 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s1_left_post.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s1_left_post.setAutoDraw(false);
    }
    
    // *bg_s1_post* updates
    if (t >= 0.0 && bg_s1_post.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      bg_s1_post.tStart = t;  // (not accounting for frame time here)
      bg_s1_post.frameNStart = frameN;  // exact frame index
      
      bg_s1_post.setAutoDraw(true);
    }

    frameRemains = 0.0 + t2 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (bg_s1_post.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      bg_s1_post.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    post_stage1Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function post_stage1RoutineEnd(trials) {
  return function () {
    //------Ending Routine 'post_stage1'-------
    post_stage1Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "post_stage1" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var prob_trans;
var random_decide;
var stage2_state;
var stage2_choice_name;
var reward_locator;
var _stage_2_allKeys;
var stage2Components;
function stage2RoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'stage2'-------
    t = 0;
    stage2Clock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    var rng = new RNG(Math.random())
    prob_trans = rng.uniform();
    random_decide = (prob_trans < 0.7);
    stage2_state = 0;
    if ((! stage_1.keys)) {
        s2_left.setImage("jpg/empty.jpg");
        s2_right.setImage("jpg/empty.jpg");
        bg_s2.setImage("jpg/empty.jpg");
        bg_post_s2.setImage("jpg/empty.jpg");
        bg_reward.setImage("jpg/empty.jpg");
        prev_s2.setImage("jpg/empty.jpg");
        stage2_choice_name = "";
        reward_locator = "";
        continueRoutine = false;
    } else {
        if (random_decide) {
            stage2_state = (1 + stage1_choice);
        } else {
            stage2_state = (4 - stage1_choice);
        }
        s2_left.setImage(((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_1") + ".jpg"));
        s2_right.setImage(((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_2") + ".jpg"));
        bg_s2.setImage((("jpg/s2/bg_" + stage2_state.toString()) + ".jpg"));
        bg_post_s2.setImage((("jpg/s2/bg_" + stage2_state.toString()) + ".jpg"));
        bg_reward.setImage((("jpg/s2/bg_" + stage2_state.toString()) + ".jpg"));
        psychoJS.experiment.addData("prob_trans", prob_trans);
    }
    
    if ((! stage_1.keys)) {
        prev_s1.setImage("jpg/empty.jpg");
        continueRoutine = false
    } else {
        prev_s1.setImage("jpg/s1/fractal_stage1_s1"+"_" + stage1_choice.toString() + ".jpg");
    }
    
    
    stage_2.keys = undefined;
    stage_2.rt = undefined;
    _stage_2_allKeys = [];
    // keep track of which components have finished
    stage2Components = [];
    stage2Components.push(bg_s2);
    stage2Components.push(s2_right);
    stage2Components.push(s2_left);
    stage2Components.push(prev_s1);
    stage2Components.push(stage_2);
    
    stage2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


var text_stage2;
function stage2RoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'stage2'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = stage2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *bg_s2* updates
    if (t >= 0.0 && bg_s2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      bg_s2.tStart = t;  // (not accounting for frame time here)
      bg_s2.frameNStart = frameN;  // exact frame index
      
      bg_s2.setAutoDraw(true);
    }

    frameRemains = 0.0 + t3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (bg_s2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      bg_s2.setAutoDraw(false);
    }
    
    // *s2_right* updates
    if (t >= 0.0 && s2_right.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s2_right.tStart = t;  // (not accounting for frame time here)
      s2_right.frameNStart = frameN;  // exact frame index
      
      s2_right.setAutoDraw(true);
    }

    frameRemains = 0.0 + t3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s2_right.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s2_right.setAutoDraw(false);
    }
    
    // *s2_left* updates
    if (t >= 0.0 && s2_left.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s2_left.tStart = t;  // (not accounting for frame time here)
      s2_left.frameNStart = frameN;  // exact frame index
      
      s2_left.setAutoDraw(true);
    }

    frameRemains = 0.0 + t3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s2_left.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s2_left.setAutoDraw(false);
    }
    
    // *prev_s1* updates
    if (t >= 0.0 && prev_s1.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      prev_s1.tStart = t;  // (not accounting for frame time here)
      prev_s1.frameNStart = frameN;  // exact frame index
      
      prev_s1.setAutoDraw(true);
    }

    frameRemains = 0.0 + t3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (prev_s1.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      prev_s1.setAutoDraw(false);
    }
    
    // *stage_2* updates
    if (t >= 0.0 && stage_2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      stage_2.tStart = t;  // (not accounting for frame time here)
      stage_2.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { stage_2.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { stage_2.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { stage_2.clearEvents(); });
    }

    frameRemains = 0.0 + t3 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (stage_2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      stage_2.status = PsychoJS.Status.FINISHED;
  }

    if (stage_2.status === PsychoJS.Status.STARTED) {
      let theseKeys = stage_2.getKeys({keyList: ['left', 'right'], waitRelease: false});
      _stage_2_allKeys = _stage_2_allKeys.concat(theseKeys);
      if (_stage_2_allKeys.length > 0) {
        stage_2.keys = _stage_2_allKeys[0].name;  // just the first key pressed
        stage_2.rt = _stage_2_allKeys[0].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    text_stage2 = prob_trans.toString();
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    stage2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var stage2_choice;
function stage2RoutineEnd(trials) {
  return function () {
    //------Ending Routine 'stage2'-------
    stage2Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    psychoJS.experiment.addData('stage_2.keys', stage_2.keys);
    if (typeof stage_2.keys !== 'undefined') {  // we had a response
        psychoJS.experiment.addData('stage_2.rt', stage_2.rt);
        routineTimer.reset();
        }
    
    stage_2.stop();
    stage2_choice = 0;
    if ((! stage_2.keys)) {
        faster = "Try faster!\n\n\nPress \u2018c\u2019 to continue";
        t4 = 0;
        t5 = 0;
        t6 = 3600;
        psychoJS.experiment.addData("stage2_state", stage2_state);
        psychoJS.experiment.addData("stage2_choice", stage2_choice);
        continueRoutine = false;
    }
    if ((stage_2.keys === "left")) {
        stage2_choice = 1;
        prev_s2.setImage((((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_") + stage2_choice.toString()) + ".jpg"));
    }
    if ((stage_2.keys === "right")) {
        stage2_choice = 2;
        prev_s2.setImage((((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_") + stage2_choice.toString()) + ".jpg"));
    }
    psychoJS.experiment.addData("stage2_choice", stage2_choice);
    psychoJS.experiment.addData("stage2_state", stage2_state);
    
    // the Routine "stage2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var post_stage2Components;
function post_stage2RoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'post_stage2'-------
    t = 0;
    post_stage2Clock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    reward_locator = [(stage2_state - 1), stage2_choice];
    if ((! stage_1.keys)) {
        continueRoutine = false;
        s2_post_left.setImage("jpg/empty.jpg");
        s2_post_right.setImage("jpg/empty.jpg");
        continueRoutine = false;
    } else {
        if ((! stage_2.keys)) {
            continueRoutine = false;
            s2_post_left.setImage("jpg/empty.jpg");
            s2_post_right.setImage("jpg/empty.jpg");
            continueRoutine = false;
        } else {
            if ((stage_2.keys === "left")) {
                s2_post_right.setImage((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_2.jpg"));
                s2_post_left.setImage((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_1_act.jpg"));
            } else {
                if ((stage_2.keys === "right")) {
                    s2_post_right.setImage((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_2_act.jpg"));
                    s2_post_left.setImage((("jpg/s2/fractal_stage2_state" + stage2_state.toString()) + "_1.jpg"));
                }
            }
        }
    }
    
    if ((! stage_1.keys)) {
        prev_s1_again.setImage("jpg/empty.jpg");
        continueRoutine = false
    } else {
        prev_s1_again.setImage("jpg/s1/fractal_stage1_s1_" + stage1_choice.toString() + ".jpg");
    }
    
    if ((! stage_2.keys)) {
        prev_s1_again.setImage("jpg/empty.jpg")
        continueRoutine = false;
    }
    // keep track of which components have finished
    post_stage2Components = [];
    post_stage2Components.push(bg_post_s2);
    post_stage2Components.push(prev_s1_again);
    post_stage2Components.push(s2_post_right);
    post_stage2Components.push(s2_post_left);
    
    post_stage2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function post_stage2RoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'post_stage2'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = post_stage2Clock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *bg_post_s2* updates
    if (t >= 0.0 && bg_post_s2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      bg_post_s2.tStart = t;  // (not accounting for frame time here)
      bg_post_s2.frameNStart = frameN;  // exact frame index
      
      bg_post_s2.setAutoDraw(true);
    }

    frameRemains = 0.0 + t4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (bg_post_s2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      bg_post_s2.setAutoDraw(false);
    }
    
    // *prev_s1_again* updates
    if (t >= 0.0 && prev_s1_again.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      prev_s1_again.tStart = t;  // (not accounting for frame time here)
      prev_s1_again.frameNStart = frameN;  // exact frame index
      
      prev_s1_again.setAutoDraw(true);
    }

    frameRemains = 0.0 + t4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (prev_s1_again.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      prev_s1_again.setAutoDraw(false);
    }
    
    // *s2_post_right* updates
    if (t >= 0.0 && s2_post_right.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s2_post_right.tStart = t;  // (not accounting for frame time here)
      s2_post_right.frameNStart = frameN;  // exact frame index
      
      s2_post_right.setAutoDraw(true);
    }

    frameRemains = 0.0 + t4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s2_post_right.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s2_post_right.setAutoDraw(false);
    }
    
    // *s2_post_left* updates
    if (t >= 0.0 && s2_post_left.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      s2_post_left.tStart = t;  // (not accounting for frame time here)
      s2_post_left.frameNStart = frameN;  // exact frame index
      
      s2_post_left.setAutoDraw(true);
    }

    frameRemains = 0.0 + t4 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (s2_post_left.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      s2_post_left.setAutoDraw(false);
    }
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    post_stage2Components.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function post_stage2RoutineEnd(trials) {
  return function () {
    //------Ending Routine 'post_stage2'-------
    post_stage2Components.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "post_stage2" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var pr_r;
var rew_img_file;
var random_var_rew;
var file_random;
var reward_amount;
var rewardComponents;
function rewardRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'reward'-------
    t = 0;
    rewardClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    var rng = new RNG(Math.random())
    pr_r = 0;
    rew_img_file = "";
    random_var_rew = rng.uniform();
    file_random = 0;
    if ((! stage_1.keys)) {
        reward_img.setImage("jpg/empty.jpg");
        reward_amount = [];
        psychoJS.experiment.addData("reward11", prob_rew["11"]);
        psychoJS.experiment.addData("reward12", prob_rew["12"]);
        psychoJS.experiment.addData("reward21", prob_rew["21"]);
        psychoJS.experiment.addData("reward22", prob_rew["22"]);
        psychoJS.experiment.addData("condition", reward_type[t_count]);
        continueRoutine = false;
    } else {
        if ((! stage_2.keys)) {
            reward_img.setImage("jpg/empty.jpg");
            reward_amount = [];
            psychoJS.experiment.addData("reward11", prob_rew["11"]);
            psychoJS.experiment.addData("reward12", prob_rew["12"]);
            psychoJS.experiment.addData("reward21", prob_rew["21"]);
            psychoJS.experiment.addData("reward22", prob_rew["22"]);
            psychoJS.experiment.addData("condition", reward_type[t_count]);
            continueRoutine = false;
        } else {
            if ((stage_1.keys && stage_2.keys)) {
                if ((random_var_rew < prob_rew[(reward_locator[0].toString() + reward_locator[1].toString())])) {
                    if ((reward_type[t_count] === "practice")) {
                        reward_img.setImage("jpg/reward/coin_neutral_p.jpg");
                    }
                    if ((reward_type[t_count] === "neutral")) {
                        reward_img.setImage("jpg/reward/coin_neutral_p.jpg");
                        running_reward = (running_reward + 1);
                    }
                    if ((reward_type[t_count] === "trigger")) {
                        rew_img_file = tr_rews;
                        reward_img.setImage((("jpg/reward/" + rew_img_file) + ".jpg"));
                        psychoJS.experiment.addData("reward_img", rew_img_file);
                        psychoJS.experiment.addData("file_random", file_random);
                        running_reward = (running_reward + 1);
                    }
                    pr_r = prob_rew[(reward_locator[0].toString() + reward_locator[1].toString())];
                    psychoJS.experiment.addData("reward", 1);
                } else {
                    reward_img.setImage("jpg/reward/coin_neutral_0.jpg");
                    pr_r = prob_rew[(reward_locator[0].toString() + reward_locator[1].toString())];
                    psychoJS.experiment.addData("reward", 0);
                }
                psychoJS.experiment.addData("reward11", prob_rew["11"]);
                psychoJS.experiment.addData("reward12", prob_rew["12"]);
                psychoJS.experiment.addData("reward21", prob_rew["21"]);
                psychoJS.experiment.addData("reward22", prob_rew["22"]);
                psychoJS.experiment.addData("condition", reward_type[t_count]);
                psychoJS.experiment.addData("random_var_rew", random_var_rew);
            }
        }
    }
    
    // keep track of which components have finished
    rewardComponents = [];
    rewardComponents.push(bg_reward);
    rewardComponents.push(reward_img);
    rewardComponents.push(prev_s2);
    
    rewardComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function rewardRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'reward'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = rewardClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *bg_reward* updates
    if (t >= 0.0 && bg_reward.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      bg_reward.tStart = t;  // (not accounting for frame time here)
      bg_reward.frameNStart = frameN;  // exact frame index
      
      bg_reward.setAutoDraw(true);
    }

    frameRemains = 0.0 + t5 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (bg_reward.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      bg_reward.setAutoDraw(false);
    }
    
    // *reward_img* updates
    if (t >= 0.0 && reward_img.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      reward_img.tStart = t;  // (not accounting for frame time here)
      reward_img.frameNStart = frameN;  // exact frame index
      
      reward_img.setAutoDraw(true);
    }

    frameRemains = 0.0 + t5 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (reward_img.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      reward_img.setAutoDraw(false);
    }
    
    // *prev_s2* updates
    if (t >= 0.0 && prev_s2.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      prev_s2.tStart = t;  // (not accounting for frame time here)
      prev_s2.frameNStart = frameN;  // exact frame index
      
      prev_s2.setAutoDraw(true);
    }

    frameRemains = 0.0 + t5 - psychoJS.window.monitorFramePeriod * 0.75;  // most of one frame period left
    if (prev_s2.status === PsychoJS.Status.STARTED && t >= frameRemains) {
      prev_s2.setAutoDraw(false);
    }
    //rew_tex = random_var_rew.toString() + "_" + pr_r.toString()
    rew_tex = tr_rews[0]+tr_rews[1]+tr_rews[2]+tr_rews[3]+tr_rews[4]
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    rewardComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


var randint;
var re11;
var re12;
var re21;
var re22;
function rewardRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'reward'-------
    rewardComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    randint = function(min, maxplusone) {
      return Math.floor(Math.random() * (maxplusone - min) ) + min;
    }
    
    function randn_bm() {
        var u, v;
        u = 0;
        v = 0;
        while ((u === 0)) {
            u = Math.random();
        }
        while ((v === 0)) {
            v = Math.random();
        }
        return (Math.sqrt(((- 2.0) * Math.log(u))) * Math.cos(((2.0 * Math.PI) * v)));
    }
    
    //re11 = prob_rew['11']+randn_bm()*sigma
    //re12 = prob_rew['12']+randn_bm()*sigma
    //re21 = prob_rew['21']+randn_bm()*sigma
    //re22 = prob_rew['22']+randn_bm()*sigma
    var rng = new RNG(Math.random())
    re11 = prob_rew['11']+rng.normal()*sigma
    re12 = prob_rew['12']+rng.normal()*sigma
    re21 = prob_rew['21']+rng.normal()*sigma
    re22 = prob_rew['22']+rng.normal()*sigma
    
    
    if ((re11>0.75)){
        re11=1.5-re11
    }
    if ((re11<0.25)){
        re11=0.5-re11
    }
    
    if ((re12>0.75)){
        re12=1.5-re12
    }
    if ((re12<0.25)){
        re12=0.5-re12
    }
    
    if ((re21>0.75)){
        re21=1.5-re21
    }
    if ((re21<0.25)){
        re21=0.5-re21
    }
    
    if ((re22>0.75)){
        re22=1.5-re22
    }
    if ((re22<0.25)){
        re22=0.5-re22
    }
    
    prob_rew['11']=re11
    prob_rew['12']=re12
    prob_rew['21']=re21
    prob_rew['22']=re22
    
    
    
    
    
    
    if ((t_count > 0)) {
        t1 = 1.5;
        t2 = 0.375;
        t3 = 1.5;
        t4 = 0.375;
        t5 = 1;
    } else {
        if ((t_count === 0)) {
            t1 = 120;
            t2 = 0.375;
            t3 = 120;
            t4 = 0.375;
            t5 = 2;
        }
    }
    if (((! stage_1.keys) || (! stage_1.keys))) {
        t6 = 3600;
    }
    stage_1.keys = [];
    stage_2.keys = [];
    
    // the Routine "reward" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var _key_break_allKeys;
var break_txt;
var progress;
var restComponents;
function restRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'rest'-------
    t = 0;
    restClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    key_break.keys = undefined;
    key_break.rt = undefined;
    _key_break_allKeys = [];
    if ((t_count === 0)) {
        text_break.height = 0.04;
        break_txt = "Great! You have finished the practice task. You are ready to go.\n\nRemember, try to collect as much treasure as possible, by opening the most favourable chest. Keep track which one is the best.\n\nThe game will take around 20 minutes.\n\nDo not press \u2018esc\u2019, as this will close the task, unless you wish to.\n\nTo start the task press \u2018c\u2019.";
    }
    if (((t_count === 1) || (t_count === 3))) {
        text_break.height = 0.045;
        progress = (t_count * 25);
        if ((running_reward < rew_check[(t_count - 1)])) {
            break_txt = (((("Good job, but try a bit harder!\n\nYour score so far is: " + running_reward.toString()) + "\n\nTake a break.\n\nRecommended break length is 1 minute.\n\nYou completed ") + progress.toString()) + "% of the task.\n\nWhen you are ready, press \u2018c\u2019 to continue.");
        }
        if ((running_reward >= rew_check[(t_count - 1)])) {
            break_txt = (((("You are doing amzing!\n\nYour score so far is: " + running_reward.toString()) + "\n\nTake a break.\n\nRecommended break length is 1 minute.\n\nYou completed ") + progress.toString()) + "% of the task.\n\nWhen you are ready, press \u2018c\u2019 to continue.");
        }
    }
    if ((t_count === 2)) {
        text_break.height = 0.045;
        progress = (t_count * 25);
        if ((running_reward < rew_check[(t_count - 1)])) {
            break_txt = (((("Good job, but try a bit harder!\n\nYour score so far is: " + running_reward.toString()) + "\n\nTake a break before the second condition starts.\n\nRecommended break length is 2 minutes.\n\nYou completed ") + progress.toString()) + "% of the task.\n\nWhen you are ready, press \u2018c\u2019 to continue.");
        }
        if ((running_reward >= rew_check[(t_count - 1)])) {
            break_txt = (((("You are doing amazing!\n\nYour score so far is: " + running_reward.toString()) + "\n\nTake a break before the second condition starts.\n\nRecommended break length is 2 minutes.\n\nYou completed ") + progress.toString()) + "% of the task.\n\nWhen you are ready, press \u2018c\u2019 to continue.");
        }
    }
    
    text_break.setText(break_txt);
    // keep track of which components have finished
    restComponents = [];
    restComponents.push(key_break);
    restComponents.push(text_break);
    
    restComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function restRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'rest'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = restClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *key_break* updates
    if (t >= 0.0 && key_break.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      key_break.tStart = t;  // (not accounting for frame time here)
      key_break.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { key_break.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { key_break.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { key_break.clearEvents(); });
    }

    if (key_break.status === PsychoJS.Status.STARTED) {
      let theseKeys = key_break.getKeys({keyList: ['c'], waitRelease: false});
      _key_break_allKeys = _key_break_allKeys.concat(theseKeys);
      if (_key_break_allKeys.length > 0) {
        key_break.keys = _key_break_allKeys[_key_break_allKeys.length - 1].name;  // just the last key pressed
        key_break.rt = _key_break_allKeys[_key_break_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    if ((t_count === 4)) {
        continueRoutine = false;
    }
    
    
    // *text_break* updates
    if (t >= 0.0 && text_break.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      text_break.tStart = t;  // (not accounting for frame time here)
      text_break.frameNStart = frameN;  // exact frame index
      
      text_break.setAutoDraw(true);
    }

    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    restComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function restRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'rest'-------
    restComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    t_count = (t_count + 1);
    
    // the Routine "rest" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


var end_text_content;
var _end_txt_key_allKeys;
var the_endComponents;
function the_endRoutineBegin(trials) {
  return function () {
    //------Prepare to start Routine 'the_end'-------
    t = 0;
    the_endClock.reset(); // clock
    frameN = -1;
    // update component parameters for each repeat
    end_text_content = (("This is the end of the task.\n\nYour total score is: " + running_reward.toString()) + ".\n\nOn the next page you will see a thank-you message. Please click \u2018OK\u2019 to be taken back to Prolific. Otherwise, we will not be able to PAY you.\n\nPress \u2018c\u2019 to continue.");
    
    end_text.setText(end_text_content);
    end_txt_key.keys = undefined;
    end_txt_key.rt = undefined;
    _end_txt_key_allKeys = [];
    // keep track of which components have finished
    the_endComponents = [];
    the_endComponents.push(end_text);
    the_endComponents.push(end_txt_key);
    
    the_endComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent)
        thisComponent.status = PsychoJS.Status.NOT_STARTED;
       });
    
    return Scheduler.Event.NEXT;
  };
}


function the_endRoutineEachFrame(trials) {
  return function () {
    //------Loop for each frame of Routine 'the_end'-------
    let continueRoutine = true; // until we're told otherwise
    // get current time
    t = the_endClock.getTime();
    frameN = frameN + 1;// number of completed frames (so 0 is the first frame)
    // update/draw components on each frame
    
    // *end_text* updates
    if (t >= 0.0 && end_text.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      end_text.tStart = t;  // (not accounting for frame time here)
      end_text.frameNStart = frameN;  // exact frame index
      
      end_text.setAutoDraw(true);
    }

    
    // *end_txt_key* updates
    if (t >= 0.0 && end_txt_key.status === PsychoJS.Status.NOT_STARTED) {
      // keep track of start time/frame for later
      end_txt_key.tStart = t;  // (not accounting for frame time here)
      end_txt_key.frameNStart = frameN;  // exact frame index
      
      // keyboard checking is just starting
      psychoJS.window.callOnFlip(function() { end_txt_key.clock.reset(); });  // t=0 on next screen flip
      psychoJS.window.callOnFlip(function() { end_txt_key.start(); }); // start on screen flip
      psychoJS.window.callOnFlip(function() { end_txt_key.clearEvents(); });
    }

    if (end_txt_key.status === PsychoJS.Status.STARTED) {
      let theseKeys = end_txt_key.getKeys({keyList: ['c'], waitRelease: false});
      _end_txt_key_allKeys = _end_txt_key_allKeys.concat(theseKeys);
      if (_end_txt_key_allKeys.length > 0) {
        end_txt_key.keys = _end_txt_key_allKeys[_end_txt_key_allKeys.length - 1].name;  // just the last key pressed
        end_txt_key.rt = _end_txt_key_allKeys[_end_txt_key_allKeys.length - 1].rt;
        // a response ends the routine
        continueRoutine = false;
      }
    }
    
    // check for quit (typically the Esc key)
    if (psychoJS.experiment.experimentEnded || psychoJS.eventManager.getKeys({keyList:['escape']}).length > 0) {
      return quitPsychoJS('The [Escape] key was pressed. Goodbye!', false);
    }
    
    // check if the Routine should terminate
    if (!continueRoutine) {  // a component has requested a forced-end of Routine
      return Scheduler.Event.NEXT;
    }
    
    continueRoutine = false;  // reverts to True if at least one component still running
    the_endComponents.forEach( function(thisComponent) {
      if ('status' in thisComponent && thisComponent.status !== PsychoJS.Status.FINISHED) {
        continueRoutine = true;
      }
    });
    
    // refresh the screen if continuing
    if (continueRoutine) {
      return Scheduler.Event.FLIP_REPEAT;
    } else {
      return Scheduler.Event.NEXT;
    }
  };
}


function the_endRoutineEnd(trials) {
  return function () {
    //------Ending Routine 'the_end'-------
    the_endComponents.forEach( function(thisComponent) {
      if (typeof thisComponent.setAutoDraw === 'function') {
        thisComponent.setAutoDraw(false);
      }
    });
    // the Routine "the_end" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset();
    
    return Scheduler.Event.NEXT;
  };
}


function endLoopIteration(thisScheduler, loop) {
  // ------Prepare for next entry------
  return function () {
    if (typeof loop !== 'undefined') {
      // ------Check if user ended loop early------
      if (loop.finished) {
        // Check for and save orphaned data
        if (psychoJS.experiment.isEntryEmpty()) {
          psychoJS.experiment.nextEntry(loop);
        }
      thisScheduler.stop();
      } else {
        const thisTrial = loop.getCurrentTrial();
        if (typeof thisTrial === 'undefined' || !('isTrials' in thisTrial) || thisTrial.isTrials) {
          psychoJS.experiment.nextEntry(loop);
        }
      }
    return Scheduler.Event.NEXT;
    }
  };
}


function importConditions(trials) {
  return function () {
    psychoJS.importAttributes(trials.getCurrentTrial());
    return Scheduler.Event.NEXT;
    };
}


function quitPsychoJS(message, isCompleted) {
  // Check for and save orphaned data
  if (psychoJS.experiment.isEntryEmpty()) {
    psychoJS.experiment.nextEntry();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  psychoJS.window.close();
  psychoJS.quit({message: message, isCompleted: isCompleted});
  
  return Scheduler.Event.QUIT;
}
