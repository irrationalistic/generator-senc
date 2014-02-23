# Fix for browsers that don't have a console
do fixConsole = ()->
  noop = ()->
  methods = [
    'assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
    'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
    'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
    'timeStamp', 'trace', 'warn'
  ]
  length = methods.length
  console = (window.console = window.console || {})
  while length--
    method = methods[length]
    console[method] = noop if not console[method]