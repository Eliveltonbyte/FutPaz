unit DMGLOBAL;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.IOUtils;

type
  TDMTABELAS = class(TDataModule)
    Conn: TFDConnection;
    FDAtletas: TFDQuery;
    procedure ConnAfterConnect(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ListarJogadores(id_atleta: integer; atleta, posicao,
      status: string);

    { Private declarations }
  public
   procedure ListarAtletas(id: integer; atleta, posicao, status: string);
    { Public declarations }
  end;

var
  DMTABELAS: TDMTABELAS;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMTABELAS.ListarAtletas(id: integer; atleta, posicao, status: string);
begin
  with FDAtletas do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select * from atletas');
        Sql.Add('where id >= 1 '''' ');

        if id >= 1 then
        begin
        sql.Add('and id = :id');
        ParamByName('id').Value := id;
        end;

        if atleta <> '' then
        begin
            SQL.Add('and atleta like :atleta');
            ParamByName('atleta').Value := '%' + atleta + '%';
        end;

        if posicao <> '' then
        begin
            SQL.Add('and posicao like :posicao');
            ParamByName('posicao').Value := '%' + posicao + '%';
        end;

        if status <> '' then
        begin
            SQL.Add('and status like :status');
            ParamByName('status').Value := '%' + status + '%';
        end;



      //  SQL.Add('order by id desc');

        Active := true;
    end;
end;

procedure TDMTABELAS.ListarJogadores(id_atleta: integer; atleta, posicao, status:string);
begin
  with FDAtletas do
  begin
    ACTIVE := false;
    Sql.Clear;
    Sql.Add('select * from atletas');
    Sql.Add('where id >= 1 '' ');

    if id_atleta >= 1 then
    begin
       sql.Add('and id = :id ');
       ParamByName('id').Value := id_atleta;
    end;

     if atleta <> '' then
    begin
       sql.Add('and atleta = :id ');
       ParamByName('id').Value := id_atleta;
    end;


    Active:= true;
  end;
end;

procedure TDMTABELAS.ConnAfterConnect(Sender: TObject);
begin
  Conn.ExecSQL('CREATE TABLE IF NOT EXISTS ATLETAS ( ' +
                            'ID           INTEGER PRIMARY KEY, ' +
                            'ATLETA            VARCHAR(100), ' +
                            'POSICAO          VARCHAR(15), ' +
                            'STATUS           VARCHAR(20));'

                );

  {Conn.ExecSQL('INSERT OR REPLACE INTO ATLETAS (ID, ATLETA, POSICAO, STATUS, FOTO)' +
                 'VALUES(''00001'', ''Elivelton'', ''Zagueiro'', ''ATIVO'', ''C:\Users\User\Documents\DelphiProjects\futPaz\mobile\images\icons8-ozil-96.png '')');
     }
end;

procedure TDMTABELAS.ConnBeforeConnect(Sender: TObject);
begin
      //conex�o sqlLite...[System.IOUtils em uses]
    Conn.DriverName := 'SQLite';

    {$IFDEF MSWINDOWS}
    Conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\banco.db';
    {$ELSE}
    Conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.bd');
    {$ENDIF}
end;

procedure TDMTABELAS.DataModuleCreate(Sender: TObject);
begin
    Conn.Connected := true;
end;

end.
