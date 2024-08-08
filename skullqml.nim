import locks
import macros
import strutils
import sequtils
import tables
import typetraits

## SkullQml aims to provide binding to the QML for the NimSkull programming language

template debugMsg(message: string) =
  echo "SkullQml: ", message

template debugMsg(typeName: string, procName: string) =
  when defined(debug):
    debugMsg(typeName & ": " & procName)

include "skullqml/private/nimqmlmacros.nim"
include "skullqml/private/dotherside.nim"
include "skullqml/private/nimqmltypes.nim"
include "skullqml/private/constructors.nim"
include "skullqml/private/qvariant.nim"
include "skullqml/private/lambdainvoker.nim"
include "skullqml/private/qmetaobjectconnection.nim"
include "skullqml/private/qmetaobject.nim"
include "skullqml/private/qobject.nim"
include "skullqml/private/qqmlapplicationengine.nim"
include "skullqml/private/qcoreapplication.nim"
include "skullqml/private/qguiapplication.nim"
include "skullqml/private/qapplication.nim"
include "skullqml/private/qurl.nim"
include "skullqml/private/qquickview.nim"
include "skullqml/private/qhashintbytearray.nim"
include "skullqml/private/qmodelindex.nim"
include "skullqml/private/qabstractitemmodel.nim"
include "skullqml/private/qabstractlistmodel.nim"
include "skullqml/private/qabstracttablemodel.nim"
include "skullqml/private/qresource.nim"
include "skullqml/private/qdeclarative.nim"

