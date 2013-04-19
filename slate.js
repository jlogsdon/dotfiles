S.cfga({
  'defaultToCurrentScreen': true,
  'checkDefaultsOnLoad':    true
});

// Monitors
var monitor = {
  lap: '1680x1050',
  tb:  '2560x1440'
};

// Operations
var ops = {lap: {}, tb: {}};

ops.lap.chat = S.op('corner', {
  screen: monitor.lap,
  direction: 'top-left',
  width: 'screenSizeX/9',
  height: 'screenSizeY'
});
ops.lap.main = ops.lap.chat.dup({direction: 'top-right', width: '8*screenSizeX/9'});
ops.lap.full = S.op('move', {
  screen: monitor.lap,
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});

ops.tb.full = S.op('move', {
  screen: monitor.tb,
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});
ops.tb.top = ops.tb.full.dup({height: 'screenSizeY/2'});
ops.tb.topLeft = ops.tb.top.dup({width: 'screenSizeX/2'});
ops.tb.topRight = ops.tb.topLeft.dup({x: 'screenOriginX+screenSizeX/2'});
ops.tb.bottom = ops.tb.top.dup({y: 'screenOriginY+screenSizeY/2'});
ops.tb.bottomLeft = ops.tb.bottom.dup({width: 'screenSizeX/2'});
ops.tb.bottomMid = ops.tb.bottomLeft.dup({x: 'screenOriginX+screenSizeX/3'});
ops.tb.bottomRight = ops.tb.bottomLeft.dup({x: 'screenOriginX+2*screenSizeX/3'});
ops.tb.left = ops.tb.topLeft.dup({height: 'screenSizeY'});
ops.tb.right = ops.tb.topRight.dup({height: 'screenSizeY'});

// Common layout hashes
var hashes = {
  lap: {
    full: {
      operations: [ops.lap.full],
      'ignore-fail': true,
      repeat: true
    },
    main: {
      operations: [ops.lap.main],
      'ignore-fail': true,
      repeat: true
    },
    adium: {
      operations: [ops.lap.chat, ops.lap.main],
      'ignore-fail': true,
      'title-order': ['Contacts'],
      'repeat-last': true
    },
  },
  tb: {
    top: {
      operations: [ops.tb.top],
      repeat: true
    },
    iterm: {
      operations: [ops.tb.full],
      'sort-title': true,
      repeat: true
    }
  }
};
hashes.generateBrowser = function(regex) {
  var findBrowser = function(wo) {
    var title = wo.title();
    if (title !== undefined && title.match(regex)) {
      wo.doOperation(ops.tb.topRight);
    } else {
      wo.doOperation(ops.lap.main);
    }
  };

  return {
    operations: [findBrowser],
    'ignore-fail': true,
    repeat: true
  }
};

// Layouts
var layouts = {
  work: S.lay('work', {
    "Adium": hashes.lap.adium,
    "iTerm": hashes.tb.iterm,
    "Google Chrome": hashes.lap.main,
    "iTunes": hashes.lap.main
  }),
  solo: S.lay('solo', {
    "Adium": hashes.lap.adium,
    "iTerm": hashes.lap.full,
    "Google Chrome": hashes.lap.full,
    "iTunes": hashes.lap.full
  })
};

S.def([monitor.lap, monitor.tb], layouts.work);
S.def([monitor.lap], layouts.solo);

ops.monitor = {
  work: S.op('layout', {name: layouts.work}),
  solo: S.op('layout', {name: layouts.solo}),
};
var universalLayout = function() {
  switch (S.screenCount()) {
    case 2:
      ops.monitor.work.run();
      break;
    case 1:
      ops.monitor.solo.run();
      break;
  }
};

S.bnda({
  'space:ctrl;alt': universalLayout,
  'left:ctrl;shift': ops.tb.left,
  'right:ctrl;shift': ops.tb.right,

  'pad0:ctrl':  ops.lap.chat,
  '[:ctrl':     ops.lap.chat,
  'pad.:ctrl':  ops.lap.main,
  ']:ctrl':     ops.lap.main,
  'pad1:ctrl':  ops.tb.bottomLeft,
  'pad2:ctrl':  ops.tb.bottomMid,
  'pad3:ctrl':  ops.tb.bottomRight,
  'pad5:ctrl':  ops.tb.full,
  'pad7:ctrl':  ops.tb.topLeft,
  'pad8:ctrl':  ops.tb.top,
  'pad9:ctrl':  ops.tb.topRight,
  'pad=:ctrl':  ops.tb.top,
  'pad/:ctrl':  ops.tb.bottom,

  // Throw
  'right:ctrl;alt;cmd': S.op('throw', {screen: 'right', width: 'screenSizeX', height: 'screenSizeY'}),
  'left:ctrl;alt;cmd':  S.op('throw', {screen: 'left', width: 'screenSizeX', height: 'screenSizeY'}),
  'up:ctrl;alt;cmd':    S.op('throw', {screen: 'up', width: 'screenSizeX', height: 'screenSizeY'}),
  'down:ctrl;alt;cmd':  S.op('throw', {screen: 'down', width: 'screenSizeX', height: 'screenSizeY'}),

  'esc:cmd': S.op('hint'),
  'esc:ctrl': S.op('grid')
});

S.src('.slate.test', true);
S.src('.slate.test.js', true);
S.log('[SLATE] ------------ Finished Loading Config ------------');

