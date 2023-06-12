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

    procedure ConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private


    { Private declarations }
  public
   procedure ListarAtletas(id, atleta, posicao, status: string);
    { Public declarations }
  end;

var
  DMTABELAS: TDMTABELAS;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMTABELAS.ListarAtletas(id, atleta, posicao, status: string);
begin
  with FDAtletas do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select * from atletas');
        Sql.Add('where id <> '''' ');

        if id <> '' then
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



{procedure TDMTABELAS.ConnBeforeConnect(Sender: TObject);
begin

end;
}
procedure TDMTABELAS.DataModuleCreate(Sender: TObject);
begin
    Conn.Connected := true;
end;

end.
