proc setup*(variant: QVariant) =
  ## Setup a new QVariant
  variant.vptr = dos_qvariant_create()

proc setup*(variant: QVariant, value: int) =
  ## Setup a new QVariant given a cint value
  variant.vptr = dos_qvariant_create_int(value.cint)

proc setup*(variant: QVariant, value: bool) =
  ## Setup a new QVariant given a bool value
  variant.vptr = dos_qvariant_create_bool(value)

proc setup*(variant: QVariant, value: string) =
  ## Setup a new QVariant given a string value
  variant.vptr = dos_qvariant_create_string(value.cstring)

proc setup*(variant: QVariant, value: QObject) =
  ## Setup a new QVariant given a QObject
  variant.vptr = dos_qvariant_create_qobject(value.vptr)

proc setup*(variant: QVariant, value: DosQVariant, takeOwnership: Ownership) =
  ## Setup a new QVariant given another QVariant.
  ## The inner value of the QVariant is copied
  variant.vptr = if takeOwnership == Ownership.Take: value else: dos_qvariant_create_qvariant(value)

proc setup*(variant: QVariant, value: cfloat) =
  ## Setup a new QVariant given a cfloat value
  variant.vptr = dos_qvariant_create_float(value)

proc setup*(variant: QVariant, value: cdouble) =
  ## Setup a new QVariant given a cdouble value
  variant.vptr = dos_qvariant_create_double(value)

proc setup*(variant: QVariant, value: QVariant) =
  ## Setup a new QVariant given another QVariant.
  ## The inner value of the QVariant is copied
  setup(variant, value.vptr, Ownership.Clone)

proc isNull*(variant: QVariant): bool =
  ## Return true if the QVariant value is null, false otherwise
  dos_qvariant_isnull(variant.vptr)

proc intVal*(variant: QVariant): int =
  ## Return the QVariant value as int
  dos_qvariant_toInt(variant.vptr).int

proc `intVal=`*(variant: QVariant, value: int) =
  ## Sets the QVariant value int value
  var rawValue = value.cint
  dos_qvariant_setInt(variant.vptr, rawValue)

proc boolVal*(variant: QVariant): bool =
  ## Return the QVariant value as bool
  dos_qvariant_toBool(variant.vptr)

proc `boolVal=`*(variant: QVariant, value: bool) =
  ## Sets the QVariant bool value
  dos_qvariant_setBool(variant.vptr, value)

proc floatVal*(variant: QVariant): cfloat =
  ## Return the QVariant value as float
  dos_qvariant_toFloat(variant.vptr).cfloat

proc `floatVal=`*(variant: QVariant, value: cfloat) =
  ## Sets the QVariant float value
  dos_qvariant_setFloat(variant.vptr, value.cfloat)

proc doubleVal*(variant: QVariant): cdouble =
  ## Return the QVariant value as double
  dos_qvariant_toDouble(variant.vptr)

proc `doubleVal=`*(variant: QVariant, value: cdouble) =
  ## Sets the QVariant double value
  dos_qvariant_setDouble(variant.vptr, value)

proc stringVal*(variant: QVariant): string =
  ## Return the QVariant value as string
  var rawCString = dos_qvariant_toString(variant.vptr)
  result = $rawCString
  dos_chararray_delete(rawCString)

proc `stringVal=`*(variant: QVariant, value: string) =
  ## Sets the QVariant string value
  dos_qvariant_setString(variant.vptr, value)

proc `qobjectVal=`*(variant: QVariant, value: QObject) =
  ## Sets the QVariant qobject value
  dos_qvariant_setQObject(variant.vptr, value.vptr)

proc assign*(leftValue: QVariant, rightValue: QVariant) =
  ## Assign a QVariant with another. The inner value of the QVariant is copied
  dos_qvariant_assign(leftValue.vptr, rightValue.vptr)

proc toQVariantSequence(a: ptr DosQVariantArray, length: cint, takeOwnership: Ownership): seq[QVariant] =
  ## Convert an array of DosQVariant to a sequence of QVariant
  result = @[]
  for i in 0..<length:
    result.add(newQVariant(a[i], takeOwnership))

proc value*(self: QVariant, T: type string): string= self.stringVal
proc value*(self: QVariant, T: type int): int = self.intVal
proc value*(self: QVariant, T: type bool): bool= self.boolVal
proc value*(self: QVariant, T: type cfloat): cfloat = self.floatVal
proc value*(self: QVariant, T: type cdouble): cdouble = self.doubleVal

proc `value=`*(self: QVariant, value: string) = self.stringVal = value
proc `value=`*(self: QVariant, value: int) = self.intVal = value
proc `value=`*(self: QVariant, value: bool) = self.boolVal = value
proc `value=`*(self: QVariant, value: cfloat) = self.floatVal = value
proc `value=`*(self: QVariant, value: cdouble) = self.doubleVal = value
