
# Debugging utils

when defined(skullQmlDebug):
  import std/logging
  export debug, info, notice, warn, error, fatal
else:
  # use the `$` converter just to ensure that debugging statements compile
  template debug*(args: varargs[untyped, `$`]): untyped = discard
  template info*(args: varargs[untyped, `$`]): untyped = discard
  template notice*(args: varargs[untyped, `$`]): untyped = discard
  template warn*(args: varargs[untyped, `$`]): untyped = discard
  template error*(args: varargs[untyped, `$`]): untyped = discard
  template fatal*(args: varargs[untyped, `$`]): untyped = discard

# Deprecated debugMsg
template debugMsg*(message: string) = debug("SkullQml: ", message)
template debugMsg*(typeName: string, procName: string) = debugMsg(typeName & ": " & procName)