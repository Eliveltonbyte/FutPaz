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
    Left = 176
    Top = 16
  end
  object FDARTILHARIA: TFDQuery
    Connection = Conn
    Left = 264
    Top = 16
  end
  object fdConsultaArt: TFDQuery
    Connection = Conn
    Left = 208
    Top = 112
  end
  object FDCapa: TFDQuery
    Connection = Conn
    Left = 344
    Top = 32
  end
  object fdConsultaCapa: TFDQuery
    Connection = Conn
    Left = 176
    Top = 184
  end
  object fdconn: TFDQuery
    Connection = Conn
    Left = 312
    Top = 160
  end
end
