import skullqml, Tables

type
  RoleNames {.pure.} = enum
    Name = UserRole + 1,

QtObject:
  type
    MyListModel* = ref object of QAbstractListModel
      names*: seq[string]

  proc setup(self: MyListModel)
  proc newMyListModel*(): MyListModel =
    new(result)
    result.names = @["John", "Max", "Paul", "Anna"]
    result.setup

  proc setup(self: MyListModel) =
    self.QAbstractListModel.setup

  method rowCount(self: MyListModel, index: QModelIndex = nil): int =
    return self.names.len

  method data(self: MyListModel, index: QModelIndex, role: int): QVariant =
    if not index.isValid:
      return
    if index.row < 0 or index.row >= self.names.len:
      return
    return newQVariant(self.names[index.row])

  method roleNames(self: MyListModel): Table[int, string] =
    { RoleNames.Name.int:"name"}.toTable
