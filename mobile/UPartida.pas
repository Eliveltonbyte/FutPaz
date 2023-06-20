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
    edtNome: TEdit;
    imgConAtleta: TImage;
    spdBuscAtleta: TSpeedButton;
    lblGol: TLabel;
    edtGol: TEdit;
    rectFinalizar: TRectangle;
    spdFinalizar: TSpeedButton;
    rectAddGol: TRectangle;
    recDivisor1: TRectangle;
    rectDivisor2: TRectangle;
    Label2: TLabel;
    edtIdPartida: TEdit;
    procedure imgBackClick(Sender: TObject);
    procedure spdIniciarPartidaClick(Sender: TObject);
    procedure spdCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdIniciarClick(Sender: TObject);
    procedure dtPartidaEnter(Sender: TObject);
    procedure btnBuscarPartidaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spdBuscAtletaClick(Sender: TObject);
  private
    procedure CloseMenu;
    procedure OpenMenu;
    procedure InserirPartida;
    procedure BuscarPartida;
    procedure BuscarInfoPartida;
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
        SQL.Add('select id, data_partida from partida ' +
                'where data_partida = :p0 and Status = ' + QuotedStr('A'));
        Params[0].AsString := dtDataPartida.Text;
        Active := true;
    end;
    edtIdPartida.Text:= DMTABELAS.FDPartida.FieldByName('id').AsString;

end;

procedure TFrmPartida.FormCreate(Sender: TObject);
begin
    tbControl.TabIndex := 0;
end;

procedure TFrmPartida.FormShow(Sender: TObject);
begin
    dtDataPartida.Date := Date;
    if tbControl.TabIndex > 0  then
    begin
      imgIniciarPartida.Visible := false;
      imgBack.Visible:= false;

    end
    else
    begin
     imgIniciarPartida.Visible := true;
     imgBack.Visible:= true;

    end;

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

procedure TFrmPartida.spdBuscAtletaClick(Sender: TObject);
begin
  with DMTABELAS.FDAtletas do begin
  active := false;
  SQL.Clear;
  SQL.ADD('select atleta from atletas where atleta like :pNome');
  DMTABELAS.FDAtletas.ParamByName('pNome').AsString := edtNome.Text + '%';
  active := true;

  end;

  edtNome.Text := DmTabelas.FDAtletas.Fields[0].AsString;
end;

procedure TFrmPartida.BuscarInfoPartida;
begin

   with DMTABELAS.FDPartida do begin
     active := false;
     SQL.Clear;
     SQL.ADD('select id from partida where data_partida = :data');
     DMTABELAS.FDPartida.Params[0].AsString := dtdataPartida.Text;
     active := true;

  end;

  edtIdPartida.Text := IntToStr(DMTABELAS.FDPartida.FieldByName('id').AsInteger);

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

    BuscarInfoPartida;
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
       SQL.Add('select id from partida where data_partida = :data');
       DMTABELAS.FDPartida.Params[0].AsString := dtDataPartida.Text;
       Open;
     end;

     if dmTabelas.FDPartida.IsEmpty then
     begin
      with DMTABELAS.FDPartida do
      begin
        Active := false;
        SQL.Clear;
        SQL.Add('insert into PARTIDA(data_partida, STATUS)');
        SQL.Add('values( :data_partida, "A" ) ');

        ParamByName('data_partida').Value := DATETOSTR (dtDataPartida.Date);

        ExecSql;

        ShowMessage('Nova Partida Iniciada');
      end;
     end;
     BuscarPartida;

end;

end.
