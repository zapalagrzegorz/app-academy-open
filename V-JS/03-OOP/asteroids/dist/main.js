/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./node_modules/keymaster/keymaster.js":
/*!*********************************************!*\
  !*** ./node_modules/keymaster/keymaster.js ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

//     keymaster.js
//     (c) 2011-2013 Thomas Fuchs
//     keymaster.js may be freely distributed under the MIT license.

;(function(global){
  var k,
    _handlers = {},
    _mods = { 16: false, 18: false, 17: false, 91: false },
    _scope = 'all',
    // modifier keys
    _MODIFIERS = {
      '⇧': 16, shift: 16,
      '⌥': 18, alt: 18, option: 18,
      '⌃': 17, ctrl: 17, control: 17,
      '⌘': 91, command: 91
    },
    // special keys
    _MAP = {
      backspace: 8, tab: 9, clear: 12,
      enter: 13, 'return': 13,
      esc: 27, escape: 27, space: 32,
      left: 37, up: 38,
      right: 39, down: 40,
      del: 46, 'delete': 46,
      home: 36, end: 35,
      pageup: 33, pagedown: 34,
      ',': 188, '.': 190, '/': 191,
      '`': 192, '-': 189, '=': 187,
      ';': 186, '\'': 222,
      '[': 219, ']': 221, '\\': 220
    },
    code = function(x){
      return _MAP[x] || x.toUpperCase().charCodeAt(0);
    },
    _downKeys = [];

  for(k=1;k<20;k++) _MAP['f'+k] = 111+k;

  // IE doesn't support Array#indexOf, so have a simple replacement
  function index(array, item){
    var i = array.length;
    while(i--) if(array[i]===item) return i;
    return -1;
  }

  // for comparing mods before unassignment
  function compareArray(a1, a2) {
    if (a1.length != a2.length) return false;
    for (var i = 0; i < a1.length; i++) {
        if (a1[i] !== a2[i]) return false;
    }
    return true;
  }

  var modifierMap = {
      16:'shiftKey',
      18:'altKey',
      17:'ctrlKey',
      91:'metaKey'
  };
  function updateModifierKey(event) {
      for(k in _mods) _mods[k] = event[modifierMap[k]];
  };

  // handle keydown event
  function dispatch(event) {
    var key, handler, k, i, modifiersMatch, scope;
    key = event.keyCode;

    if (index(_downKeys, key) == -1) {
        _downKeys.push(key);
    }

    // if a modifier key, set the key.<modifierkeyname> property to true and return
    if(key == 93 || key == 224) key = 91; // right command on webkit, command on Gecko
    if(key in _mods) {
      _mods[key] = true;
      // 'assignKey' from inside this closure is exported to window.key
      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = true;
      return;
    }
    updateModifierKey(event);

    // see if we need to ignore the keypress (filter() can can be overridden)
    // by default ignore key presses if a select, textarea, or input is focused
    if(!assignKey.filter.call(this, event)) return;

    // abort if no potentially matching shortcuts found
    if (!(key in _handlers)) return;

    scope = getScope();

    // for each potential shortcut
    for (i = 0; i < _handlers[key].length; i++) {
      handler = _handlers[key][i];

      // see if it's in the current scope
      if(handler.scope == scope || handler.scope == 'all'){
        // check if modifiers match if any
        modifiersMatch = handler.mods.length > 0;
        for(k in _mods)
          if((!_mods[k] && index(handler.mods, +k) > -1) ||
            (_mods[k] && index(handler.mods, +k) == -1)) modifiersMatch = false;
        // call the handler and stop the event if neccessary
        if((handler.mods.length == 0 && !_mods[16] && !_mods[18] && !_mods[17] && !_mods[91]) || modifiersMatch){
          if(handler.method(event, handler)===false){
            if(event.preventDefault) event.preventDefault();
              else event.returnValue = false;
            if(event.stopPropagation) event.stopPropagation();
            if(event.cancelBubble) event.cancelBubble = true;
          }
        }
      }
    }
  };

  // unset modifier keys on keyup
  function clearModifier(event){
    var key = event.keyCode, k,
        i = index(_downKeys, key);

    // remove key from _downKeys
    if (i >= 0) {
        _downKeys.splice(i, 1);
    }

    if(key == 93 || key == 224) key = 91;
    if(key in _mods) {
      _mods[key] = false;
      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = false;
    }
  };

  function resetModifiers() {
    for(k in _mods) _mods[k] = false;
    for(k in _MODIFIERS) assignKey[k] = false;
  };

  // parse and assign shortcut
  function assignKey(key, scope, method){
    var keys, mods;
    keys = getKeys(key);
    if (method === undefined) {
      method = scope;
      scope = 'all';
    }

    // for each shortcut
    for (var i = 0; i < keys.length; i++) {
      // set modifier keys if any
      mods = [];
      key = keys[i].split('+');
      if (key.length > 1){
        mods = getMods(key);
        key = [key[key.length-1]];
      }
      // convert to keycode and...
      key = key[0]
      key = code(key);
      // ...store handler
      if (!(key in _handlers)) _handlers[key] = [];
      _handlers[key].push({ shortcut: keys[i], scope: scope, method: method, key: keys[i], mods: mods });
    }
  };

  // unbind all handlers for given key in current scope
  function unbindKey(key, scope) {
    var multipleKeys, keys,
      mods = [],
      i, j, obj;

    multipleKeys = getKeys(key);

    for (j = 0; j < multipleKeys.length; j++) {
      keys = multipleKeys[j].split('+');

      if (keys.length > 1) {
        mods = getMods(keys);
        key = keys[keys.length - 1];
      }

      key = code(key);

      if (scope === undefined) {
        scope = getScope();
      }
      if (!_handlers[key]) {
        return;
      }
      for (i = 0; i < _handlers[key].length; i++) {
        obj = _handlers[key][i];
        // only clear handlers if correct scope and mods match
        if (obj.scope === scope && compareArray(obj.mods, mods)) {
          _handlers[key][i] = {};
        }
      }
    }
  };

  // Returns true if the key with code 'keyCode' is currently down
  // Converts strings into key codes.
  function isPressed(keyCode) {
      if (typeof(keyCode)=='string') {
        keyCode = code(keyCode);
      }
      return index(_downKeys, keyCode) != -1;
  }

  function getPressedKeyCodes() {
      return _downKeys.slice(0);
  }

  function filter(event){
    var tagName = (event.target || event.srcElement).tagName;
    // ignore keypressed in any elements that support keyboard data input
    return !(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA');
  }

  // initialize key.<modifier> to false
  for(k in _MODIFIERS) assignKey[k] = false;

  // set current scope (default 'all')
  function setScope(scope){ _scope = scope || 'all' };
  function getScope(){ return _scope || 'all' };

  // delete all handlers for a given scope
  function deleteScope(scope){
    var key, handlers, i;

    for (key in _handlers) {
      handlers = _handlers[key];
      for (i = 0; i < handlers.length; ) {
        if (handlers[i].scope === scope) handlers.splice(i, 1);
        else i++;
      }
    }
  };

  // abstract key logic for assign and unassign
  function getKeys(key) {
    var keys;
    key = key.replace(/\s/g, '');
    keys = key.split(',');
    if ((keys[keys.length - 1]) == '') {
      keys[keys.length - 2] += ',';
    }
    return keys;
  }

  // abstract mods logic for assign and unassign
  function getMods(key) {
    var mods = key.slice(0, key.length - 1);
    for (var mi = 0; mi < mods.length; mi++)
    mods[mi] = _MODIFIERS[mods[mi]];
    return mods;
  }

  // cross-browser events
  function addEvent(object, event, method) {
    if (object.addEventListener)
      object.addEventListener(event, method, false);
    else if(object.attachEvent)
      object.attachEvent('on'+event, function(){ method(window.event) });
  };

  // set the handlers globally on document
  addEvent(document, 'keydown', function(event) { dispatch(event) }); // Passing _scope to a callback to ensure it remains the same by execution. Fixes #48
  addEvent(document, 'keyup', clearModifier);

  // reset modifiers to false whenever the window is (re)focused.
  addEvent(window, 'focus', resetModifiers);

  // store previously defined key
  var previousKey = global.key;

  // restore previously defined key and return reference to our key object
  function noConflict() {
    var k = global.key;
    global.key = previousKey;
    return k;
  }

  // set window.key and window.key.set/get/deleteScope, and the default filter
  global.key = assignKey;
  global.key.setScope = setScope;
  global.key.getScope = getScope;
  global.key.deleteScope = deleteScope;
  global.key.filter = filter;
  global.key.isPressed = isPressed;
  global.key.getPressedKeyCodes = getPressedKeyCodes;
  global.key.noConflict = noConflict;
  global.key.unbind = unbindKey;

  if(true) module.exports = assignKey;

})(this);


/***/ }),

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./utils */ "./src/utils.js");
/* harmony import */ var _moving_object__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./moving_object */ "./src/moving_object.js");
/* harmony import */ var _ship__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./ship */ "./src/ship.js");
/* harmony import */ var _bullet__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./bullet */ "./src/bullet.js");





function Asteroid(options) {
  options.color = Asteroid.COLOR;
  options.radius = Asteroid.RADIUS;
  _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"].call(this, options);
  this.vel = _utils__WEBPACK_IMPORTED_MODULE_0__["default"].randomVec(5);
} // Asteroid.prototype.collideWith(otherObject): if otherObject instanceof Ship, call Ship.prototype.relocate. The Ship.prototype.relocate method should reset the Ship's position to game.randomPosition() and reset velocity to the zero vector.


_utils__WEBPACK_IMPORTED_MODULE_0__["default"].inherits(Asteroid, _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"]); // Pick a default COLOR and RADIUS for Asteroids.
// Set these as properties of the Asteroid class: Asteroid.COLOR and Asteroid.RADIUS

Asteroid.COLOR = 'darkgrey';
Asteroid.RADIUS = '20';

Asteroid.prototype.collideWith = function (otherObject) {
  if (otherObject instanceof _ship__WEBPACK_IMPORTED_MODULE_2__["default"]) {
    otherObject.relocate();
  }

  if (otherObject instanceof _bullet__WEBPACK_IMPORTED_MODULE_3__["default"]) {
    this.game.remove(otherObject);
    this.game.remove(this);
  }
};

/* harmony default export */ __webpack_exports__["default"] = (Asteroid);

/***/ }),

/***/ "./src/bullet.js":
/*!***********************!*\
  !*** ./src/bullet.js ***!
  \***********************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./utils */ "./src/utils.js");
/* harmony import */ var _moving_object__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./moving_object */ "./src/moving_object.js");



function Bullet(options) {
  this.isWrappable = false;
  _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"].call(this, options);
}

_utils__WEBPACK_IMPORTED_MODULE_0__["default"].inherits(Bullet, _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"]);
/* harmony default export */ __webpack_exports__["default"] = (Bullet);

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _asteroid__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./asteroid */ "./src/asteroid.js");
/* harmony import */ var _ship__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./ship */ "./src/ship.js");
/* harmony import */ var _bullet__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./bullet */ "./src/bullet.js");
function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && Symbol.iterator in Object(iter)) return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

// Write a Game class in src/game.js.
//  Define the following constants on the Game class: DIM_X, DIM_Y, and NUM_ASTEROIDS.





function Game() {
  this.asteroids = [];
  this.bullets = [];
  this.ship = new _ship__WEBPACK_IMPORTED_MODULE_1__["default"]({
    pos: Game.prototype.randomPosition(),
    game: this
  }); // console.log(this.ship);
}

Game.DIM_X = window.innerWidth * 0.8;
Game.DIM_Y = window.innerHeight * 0.8;
Game.NUM_ASTEROIDS = 6; // Game.prototype.add(obj) method that added to this.asteroids/this.bullets if obj instanceof Asteroid/obj instanceof Bullet. I wrote a similar Game.prototype.remove(obj) method. This was easier than having two methods each for Asteroid and Bullet.

Game.prototype.add = function (object) {
  if (object instanceof _asteroid__WEBPACK_IMPORTED_MODULE_0__["default"]) {
    this.asteroids.push(object);
  }

  if (object instanceof _bullet__WEBPACK_IMPORTED_MODULE_2__["default"]) {
    this.bullets.push(object);
  }
};

Game.prototype.addAsteroids = function () {
  for (var i = Game.NUM_ASTEROIDS; i > 0; i--) {
    var config = {
      pos: Game.prototype.randomPosition(),
      game: this
    };
    this.asteroids.push(new _asteroid__WEBPACK_IMPORTED_MODULE_0__["default"](config));
  }
};

Game.prototype.allObjects = function () {
  return [].concat(_toConsumableArray(this.asteroids), _toConsumableArray(this.bullets), [this.ship]);
}; // Randomly place the asteroids within the dimensions of the game grid.


Game.prototype.randomPosition = function () {
  return [Game.DIM_X * Math.random(), Game.DIM_Y * Math.random()];
}; //  method. It should call clearRect on the ctx to wipe down the entire space. Call the draw method on each of the asteroids.


Game.prototype.draw = function (ctx) {
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
  this.allObjects().forEach(function (object) {
    object.draw(ctx);
  });
}; // Write a Game.prototype.moveObjects method. It should call move on each of the asteroids.


Game.prototype.moveObjects = function () {
  this.allObjects().forEach(function (movingObject) {
    movingObject.move();
  });
};

Game.prototype.wrap = function (pos) {
  var wrappedPos = _toConsumableArray(pos);

  if (pos[0] > Game.DIM_X) {
    wrappedPos[0] = 0;
  }

  if (pos[0] < 0) {
    wrappedPos[0] = Game.DIM_X;
  }

  if (pos[1] > Game.DIM_Y) {
    wrappedPos[1] = 0;
  }

  if (pos[1] < 0) {
    wrappedPos[1] = Game.DIM_Y;
  }

  return wrappedPos;
};

Game.prototype.checkCollisions = function () {
  var _this = this;

  this.allObjects().forEach(function (object) {
    _this.allObjects().forEach(function (otherObject) {
      if (object !== otherObject && object.isCollidedWith(otherObject)) {
        // wszystkie obiekty mają tę metodę przez definicję w parencie
        // definicja ta może być pusta
        // można też ją nadpisać w normalnym obiekcie
        object.collideWith(otherObject);
      }
    });
  });
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function (object) {
  if (object instanceof _asteroid__WEBPACK_IMPORTED_MODULE_0__["default"]) {
    this.asteroids = this.asteroids.filter(function (memoryAsteroid) {
      return object != memoryAsteroid;
    });
  }

  if (object instanceof _bullet__WEBPACK_IMPORTED_MODULE_2__["default"]) {
    this.bullets = this.bullets.filter(function (otherBullet) {
      return object != otherBullet;
    });
  }
};

Game.prototype.isOutOfBounds = function (object) {
  // góra gdy pos Y < 0,
  if (object.pos[0] < 0) return true;
  if (object.pos[1] < 0) return true;
  if (object.pos[0] + 2 * object.radius > Game.DIM_X) return true;
  if (object.pos[1] + 2 * object.radius > Game.DIM_Y) return true; // lewo gdy pos X < 0;
  // prawo gdy pos X + 2*radius > length
  // dół gdy pos Y + 2*radius > height
};

/* harmony default export */ __webpack_exports__["default"] = (Game);

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var keymaster__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! keymaster */ "./node_modules/keymaster/keymaster.js");
/* harmony import */ var keymaster__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(keymaster__WEBPACK_IMPORTED_MODULE_0__);
/* globals key */
// Your GameView class will be responsible for keeping track of the canvas context, the game, and the ship. Your GameView will be in charge of setting an interval to animate your game. In addition, it will eventually bind key handlers to the ship so that we can move it around.
// Define an GameView class in src/game_view.js. The GameView should store a Game and take in and store a drawing ctx.
// Write a GameView.prototype.start method. It should call setInterval to call Game.prototype.moveObjects and Game.prototype.draw once every


function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  var _this = this;

  this.bindKeyHandlers();

  var step = function step() {
    _this.game.draw(_this.ctx);

    _this.game.step();

    window.requestAnimationFrame(step);
  };

  window.requestAnimationFrame(step);
};

GameView.prototype.bindKeyHandlers = function () {
  var _this2 = this;

  // space, up, down, left, right
  keymaster__WEBPACK_IMPORTED_MODULE_0___default()('up', function () {
    _this2.game.ship.power([0, -1]);
  });
  keymaster__WEBPACK_IMPORTED_MODULE_0___default()('down', function () {
    _this2.game.ship.power([0, 1]);
  });
  keymaster__WEBPACK_IMPORTED_MODULE_0___default()('left', function () {
    _this2.game.ship.power([-1, 0]);
  });
  keymaster__WEBPACK_IMPORTED_MODULE_0___default()('right', function () {
    _this2.game.ship.power([1, 0]);
  });
  keymaster__WEBPACK_IMPORTED_MODULE_0___default()('space', function () {
    _this2.game.ship.fireBullet();
  });
};

/* harmony default export */ __webpack_exports__["default"] = (GameView);

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _game_view__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./game_view */ "./src/game_view.js");
/* harmony import */ var _game__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./game */ "./src/game.js");
// console.log("Webpack is working!")
// import MovingObject from './moving_object';
// import Asteroid from './asteroid';


document.addEventListener('DOMContentLoaded', function () {
  // window.MovingObject = MovingObject;
  var canvas = document.getElementById('game-canvas');
  var ctx = canvas.getContext('2d'); //   this.vel = vel;
  // this.radius = radius;
  // this.color = color;

  var conf = {
    pos: [130, 100],
    color: '#555',
    radius: 5
  }; // const obj = new Asteroid(conf);
  // obj.draw(ctx);
  // console.log('tet');

  var game = new _game__WEBPACK_IMPORTED_MODULE_1__["default"]();
  canvas.setAttribute('width', _game__WEBPACK_IMPORTED_MODULE_1__["default"].DIM_X);
  canvas.setAttribute('height', _game__WEBPACK_IMPORTED_MODULE_1__["default"].DIM_Y);
  game.addAsteroids(); // game.draw(ctx);

  var gameView = new _game_view__WEBPACK_IMPORTED_MODULE_0__["default"](game, ctx);
  gameView.start();
});

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
function MovingObject(options) {
  var pos = options.pos,
      vel = options.vel,
      radius = options.radius,
      color = options.color,
      game = options.game;
  this.pos = pos;
  this.vel = vel;
  this.radius = radius;
  this.color = color;
  this.game = game;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(this.pos[0] - this.radius, this.pos[1] - this.radius, this.radius, 0, 2 * Math.PI, false);
  ctx.fill();
};

MovingObject.prototype.move = function () {
  if (this.game.isOutOfBounds(this)) {
    if (this.isWrappable) {
      this.pos = this.game.wrap(this.pos);
    } else {
      this.game.remove(this);
    }
  }

  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  var dist = Math.sqrt(Math.pow(this.pos[0] - otherObject.pos[0], 2) + Math.pow(this.pos[1] - otherObject.pos[1], 2));

  if (dist < this.radius * 2) {
    return true;
  }
};

MovingObject.prototype.collideWith = function () {};

MovingObject.prototype.isWrappable = true;
/* harmony default export */ __webpack_exports__["default"] = (MovingObject);

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./utils */ "./src/utils.js");
/* harmony import */ var _moving_object__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./moving_object */ "./src/moving_object.js");
/* harmony import */ var _bullet__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./bullet */ "./src/bullet.js");




function Ship(options) {
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  options.vel = [0, 0];
  _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"].call(this, options);
}

_utils__WEBPACK_IMPORTED_MODULE_0__["default"].inherits(Ship, _moving_object__WEBPACK_IMPORTED_MODULE_1__["default"]);
Ship.COLOR = '#fe019a';
Ship.RADIUS = '13';
Ship.MAX_SPEED = 5;

Ship.prototype.relocate = function () {
  this.vel = [0, 0];
  this.pos = this.game.randomPosition();
};

Ship.prototype.power = function (impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
  if (this.vel[0] > Ship.MAX_SPEED) this.vel[0] = Ship.MAX_SPEED;
  if (this.vel[0] < -Ship.MAX_SPEED) this.vel[0] = -Ship.MAX_SPEED;
  if (this.vel[1] > Ship.MAX_SPEED) this.vel[1] = Ship.MAX_SPEED;
  if (this.vel[1] < -Ship.MAX_SPEED) this.vel[1] = -Ship.MAX_SPEED;
};

Ship.prototype.fireBullet = function () {
  if (!this.vel[0] && !this.vel[1]) return;
  var Yvel = 0;
  var Xvel = 0;

  if (this.vel[0] > 0) {
    Yvel = this.vel[0] + 2;
  } else if (this.vel[0] < 0) {
    Yvel = this.vel[0] - 2;
  }

  if (this.vel[1] > 0) {
    Xvel = this.vel[1] + 2;
  } else if (this.vel[1] < 0) {
    Xvel = this.vel[1] - 2;
  } // setupBulletVelocity(vel)


  var options = {
    pos: [this.pos[0] - this.radius, this.pos[1] - this.radius],
    vel: [Yvel, Xvel],
    radius: 2,
    color: 'blue',
    game: this.game
  };
  var bullet = new _bullet__WEBPACK_IMPORTED_MODULE_2__["default"](options); // Add the bullet to an array of Game bullets.

  this.game.add(bullet);
};

/* harmony default export */ __webpack_exports__["default"] = (Ship);

/***/ }),

/***/ "./src/utils.js":
/*!**********************!*\
  !*** ./src/utils.js ***!
  \**********************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
var Util = {
  inherits: function inherits(childClass, parentClass) {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },
  // Return a randomly oriented vector with the given length.
  randomVec: function randomVec(length) {
    var deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale: function scale(vec, m) {
    return [vec[0] * m, vec[1] * m];
  }
}; // to be tested

/* harmony default export */ __webpack_exports__["default"] = (Util); // Util.inherits = function (childClass, parentClass) { ... }.

/***/ })

/******/ });
//# sourceMappingURL=main.js.map