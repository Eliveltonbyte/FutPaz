object DMTABELAS: TDMTABELAS
  OnCreate = DataModuleCreate
  Height = 305
  Width = 500
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    AfterConnect = ConnAfterConnect
    BeforeConnect = ConnBeforeConnect
    Left = 24
    Top = 16
  end
  object FDAtletas: TFDQuery
    Connection = Conn
    Left = 96
    Top = 16
  end
  object FDPartida: TFDQuery
    Connection = Conn
    Left = 184
    Top = 16
  end
end
