unit UPartida;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.TabControl, FMX.DateTimeCtrls, FMX.Ani, FMX.Calendar,
  FMX.Edit;
type
  TFrmPartida = class(TForm)
    rectTolbarPartida: TRectangle;
    lbToobar: TLabel;
    imgBack: TImage;
    imgIniciarPartida: TImage;
    tbControl: TTabControl;
    tbPrincipal: TTabItem;
    tbArtilharia: TTabItem;
    tbCapa: TTabItem;
    lvPartida: TListView;
    lytPrincipal: TLayout;
    rectPartida: TRectangle;
    dtDataPartida: TDateEdit;
    lblPartida: TLabel;
    lblData: TLabel;
    rectCancelar: TRectangle;
    rectIniciar: TRectangle;
    spdCancelar: TSpeedButton;
    spdIniciar: TSpeedButton;
    spdIniciarPartida: TSpeedButton;
    Rectangle1: TRectangle;
    lytPartidaArt: TLayout;
    btnBuscarPartida: TRectangle;
    Label1: TLabel;
    dataPartida: TDateEdit;
    lytBuscarJogador: TLayout;
    Edit1: TEdit;
    imgConAtleta: TImage;
    spdBuscAtleta: TSpeedButton;
    Label2: TLabel;
    Edit2: TEdit;
    Rectangle2: TRectangle;
    SpeedButton1: TSpeedButton;
    Rectangle3: TRectangle;
    Label3: TLabel;
    procedure imgBackClick(Sender: TObject);
    procedure spdIniciarPartidaClick(Sender: TObject);
    procedure spdCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdIniciarClick(Sender: TObject);
    procedure dtPartidaEnter(Sender: TObject);
    procedure btnBuscarPartidaClick(Sender: TObject);
  private
    procedure CloseMenu;
    procedure OpenMenu;
    procedure InserirPartida;
    procedure BuscarPartida;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FrmPartida: TFrmPartida;
implementation
{$R *.fmx}

uses DMGLOBAL;


procedure TFrmPartida.dtPartidaEnter(Sender: TObject);
begin
    BuscarPartida;
end;

procedure TFrmPartida.BuscarPartida;
begin
   with DMTABELAS.FDPartida do
    begin
        Active := false;
        SQL.Clear;
        SQL.Add('select id, data_partida from partida');
        Sql.Add('where data_partida = :p0 and Status = "A" ');
        Params[0].Value := DataPartida.Date;

        Active := true;

       // edit1.Text:= fieldbyname('id').AsString;
    end;



end;
procedure TFrmPartida.FormShow(Sender: TObject);
begin
    dtDataPartida.Date := Date;
    if tbControl.TabIndex = 1  then
    begin
      imgIniciarPartida.Visible := false;
    end;
    tbControl.TabIndex := 0;
end;

procedure TFrmPartida.imgBackClick(Sender: TObject);
begin
  close;
end;
procedure TFrmPartida.CloseMenu;
begin
    rectPartida.Margins.Bottom := 0;
    lytPrincipal.Visible := false;
    TAnimator.AnimateFloat(rectPartida, 'Margins.Bottom', -141, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Circular);

    TThread.CreateAnonymousThread(procedure
    begin
     // sleep(9000);
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        lytPrincipal.Visible := false;
      end);


    end).Start;
end;
procedure TFrmPartida.OpenMenu;
begin
    rectPartida.Margins.Bottom := -141;
    lytPrincipal.Visible := true;
    TAnimator.AnimateFloat(rectPartida, 'Margins.Bottom', 0, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Circular);
end;


procedure TFrmPartida.btnBuscarPartidaClick(Sender: TObject);
begin
   BuscarPartida;
end;

procedure TFrmPartida.spdCancelarClick(Sender: TObject);
begin
 CloseMenu;
end;

procedure TFrmPartida.spdIniciarClick(Sender: TObject);
begin
    if (dtDataPartida.Date <> 0) then
    begin
      InserirPartida;
    end;

    tbControl.TabIndex := 1;
    closeMenu;
end;

procedure TFrmPartida.spdIniciarPartidaClick(Sender: TObject);
begin
    OpenMenu;
end;

procedure TFrmPartida.InserirPartida;
begin
     with DMTABELAS.FDPARTIDA do
     begin
     Active := false;
     SQL.Clear;
     SQL.Add('delete from partida');
     ExecSql;
     end;

    with DMTABELAS.FDPARTIDA do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('insert into PARTIDA(data_partida, STATUS)');
      SQL.Add('values( :data_partida, "A" )');

      ParamByName('data_partida').Value := DATETOSTR (dtDataPartida.Date);

      ExecSql;

      ShowMessage('Nova Partida Iniciada');

    end;

end;

end.
