object DMTABELAS: TDMTABELAS
  OnCreate = DataModuleCreate
  Height = 305
  Width = 500
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    BeforeConnect = ConnBeforeConnect
    Left = 104
    Top = 72
  end
  object FDAtletas: TFDQuery
    Connection = Conn
    Left = 264
    Top = 160
  end
end
