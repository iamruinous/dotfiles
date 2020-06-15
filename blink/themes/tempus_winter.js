black       = '#202427';
red         = '#EB6A58'; // red
green       = '#49A61D'; // green
yellow      = '#959721'; // yellow
blue        = '#798FB7'; // blue
magenta     = '#CD7B7E'; // pink
cyan        = '#4FA090'; // cyan
white       = '#909294'; // light gray
lightBlack  = '#292B35'; // medium gray
lightRed    = '#DB7824'; // red
lightGreen  = '#09A854'; // green
lightYellow = '#AD8E4B'; // yellow
lightBlue   = '#309DC1'; // blue
lightMagenta= '#C874C2'; // pink
lightCyan   = '#1BA2A0'; // cyan
lightWhite  = '#8DA3B8'; // white

t.prefs_.set('color-palette-overrides',
                 [ black , red     , green  , yellow,
                  blue     , magenta , cyan   , white,
                  lightBlack   , lightRed  , lightGreen , lightYellow,
                  lightBlue    , lightMagenta  , lightCyan  , lightWhite ]);

t.prefs_.set('cursor-color', lightWhite);
t.prefs_.set('foreground-color', lightWhite);
t.prefs_.set('background-color', black);
