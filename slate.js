var monitor, ops, screen, op, hashes, layouts, universalLayout;

S.cfga({
  defaultToCurrentScreen: true,
  checkDefaultsOnLoad:    true
});

// Monitors
monitor = {
  laptop:  '1680x1050',
  tbMid:   1,
  tbRight: 2
};

// Operations
ops = {laptop: {}, tbMid: {}, tbRight: {}};

ops.laptop.sliver = S.op('corner', {
  screen: monitor.laptop,
  direction: 'top-left',
  width: 'screenSizeX/9',
  height: 'screenSizeY'
});
ops.laptop.main = ops.laptop.sliver.dup({direction: 'top-right', width: '8*screenSizeX/9'});
ops.laptop.full = S.op('move', {
  screen: monitor.laptop,
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});

for (screen in monitor) {
  if (screen !== 'laptop') {
    ops[screen].full = S.op('move', {
      screen: monitor[screen],
      x: 'screenOriginX',
      y: 'screenOriginY',
      width: 'screenSizeX',
      height: 'screenSizeY'
    });
    ops[screen].center = S.op('move', {
      screen: monitor[screen],
      x: 'screenOriginX+screenSizeX/9',
      y: 'screenOriginY+screenSizeY/9',
      width: 'screenSizeX-2*screenSizeX/9',
      height: 'screenSizeY-2*screenSizeY/9'
    });
    ops[screen].top         = ops[screen].full.dup({height: 'screenSizeY/2'});
    ops[screen].topLeft     = ops[screen].top.dup({width: 'screenSizeX/2'});
    ops[screen].topRight    = ops[screen].topLeft.dup({x: 'screenOriginX+screenSizeX/2'});
    ops[screen].bottom      = ops[screen].top.dup({y: 'screenOriginY+screenSizeY/2'});
    ops[screen].bottomLeft  = ops[screen].bottom.dup({width: 'screenSizeX/2'});
    ops[screen].bottomMid   = ops[screen].bottomLeft.dup({x: 'screenOriginX+screenSizeX/3'});
    ops[screen].bottomRight = ops[screen].bottomLeft.dup({x: 'screenOriginX+2*screenSizeX/3'});
    ops[screen].left        = ops[screen].topLeft.dup({height: 'screenSizeY'});
    ops[screen].right       = ops[screen].topRight.dup({height: 'screenSizeY'});
  }
}

// Common layout hashes
hashes = {
  laptop: {
    full: {
      operations: [ops.laptop.full],
      'ignore-fail': true,
      repeat: true
    },
    main: {
      operations: [ops.laptop.main],
      'ignore-fail': true,
      repeat: true
    }
  },
  generate: function(regex, yes, no) {
    var findWindow = function(wo) {
      var title = wo.title();
      if (title !== undefined && title.match(regex)) {
        wo.doOperation(yes);
      } else {
        wo.doOperation(no);
      }
    };

    return {
      operations: [findWindow],
      'ignore-fail': true,
      repeat: true
    }
  }
};

for (screen in monitor) {
  if (screen !== 'laptop') {
    hashes[screen] = {};
    S.log('Setup hashes for ' + screen);

    ['full', 'center', 'top', 'topLeft', 'topRight', 'bottom', 'bottomLeft', 'bottomRight', 'left', 'right'].forEach(function(op) {
      S.log('  Operation: ' + screen + ':' + op);
      hashes[screen][op] = {
        operations: [ops[screen][op]],
        repeat: true
      };
    });
  }
}

// Layouts
layouts = [
  S.lay('solo', {
    "Adium": hashes.generate(/Contacts/, ops.laptop.sliver, ops.laptop.main),
    "iTerm": hashes.laptop.full,
    "Google Chrome": hashes.laptop.full,
    "Safari": hashes.laptop.full,
    "iTunes": hashes.laptop.full
  }),
  S.lay('pair', {
    "Adium": hashes.generate(/Contacts/, ops.laptop.sliver, ops.laptop.main),
    "iTerm": hashes.tbMid.full,
    "Google Chrome": hashes.laptop.full,
    "Safari": hashes.laptop.full,
    "iTunes": hashes.laptop.main
  }),
  S.lay('trips', {
    "Adium": hashes.generate(/Contacts/, ops.laptop.sliver, ops.laptop.main),
    "iTerm": hashes.tbMid.full,
    "Google Chrome": hashes.tbRight.left,
    "Safari": hashes.tbRight.right,
    "iTunes": hashes.tbRight.center
  })
];

S.log('First: ' + layouts[0]);
S.log('Second: ' + layouts[1]);
S.log('Third: ' + layouts[2]);

S.def(3, layouts[2]);
S.def(2, layouts[1]);
S.def(1, layouts[0]);

ops.monitor = [
  S.op('layout', {name: layouts[0]}),
  S.op('layout', {name: layouts[1]}),
  S.op('layout', {name: layouts[2]})
];
universalLayout = function() {
  switch (S.screenCount()) {
    case 3:
      ops.monitor[2].run();
      break;
    case 2:
      ops.monitor[1].run();
      break;
    case 1:
      ops.monitor[0].run();
      break;
  }
};

S.bnda({
  'space:ctrl;alt': universalLayout,
  'left:ctrl;alt': S.op('move', {
    x: 'screenOriginX',
    y: 'screenOriginY',
    width: 'screenSizeX-screenSizeX/2',
    height: 'screenSizeY'
  }),
  'right:ctrl;alt': S.op('move', {
    x: 'screenOriginX+screenSizeX/2',
    y: 'screenOriginY',
    width: 'screenSizeX-screenSizeX/2',
    height: 'screenSizeY'
  }),
  'up:ctrl;alt': S.op('move', {
    x: 'screenOriginX',
    y: 'screenOriginY',
    width: 'screenSizeX',
    height: 'screenSizeY-screenSizeY/2'
  }),
  'down:ctrl;alt': S.op('move', {
    x: 'screenOriginX',
    y: 'screenOriginY+screenSizeY/2',
    width: 'screenSizeX',
    height: 'screenSizeY-screenSizeY/2'
  }),
  'down:ctrl;alt;shift': S.op('move', {
    x: 'screenOriginX+screenSizeX/9',
    y: 'screenOriginY+screenSizeY/9',
    width: 'screenSizeX-2*screenSizeX/9',
    height: 'screenSizeY-2*screenSizeY/9'
  }),

  // Throw
  'right:ctrl;alt;cmd': S.op('throw', {screen: 'right', width: 'screenSizeX', height: 'screenSizeY'}),
  'left:ctrl;alt;cmd':  S.op('throw', {screen: 'left', width: 'screenSizeX', height: 'screenSizeY'}),

  'esc:cmd': S.op('hint'),
  'esc:ctrl': S.op('grid')
});

S.src('.slate.test', true);
S.src('.slate.test.js', true);
S.log('[SLATE] ------------ Finished Loading Config ------------');

