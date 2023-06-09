unit UJogadores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit,
  FMX.ListBox, FMX.Ani, FMX.Layouts;

type
  TFrmJogador = class(TForm)
    rectTolbarJogador: TRectangle;
    lbToobar: TLabel;
    imgLupa: TImage;
    imgBack: TImage;
    lvAtletas: TListView;
    Circle1: TCircle;
    imgIconeFlutuante: TImage;
    SpeedButton1: TSpeedButton;
    lytOpacity: TLayout;
    rectOpacity: TRectangle;
    rectConsulta: TRectangle;
    imgFechar: TImage;
    edtNome: TEdit;
    Label1: TLabel;
    lblStatus: TLabel;
    cbPosicao: TComboBox;
    cbStatus: TComboBox;
    rectBtnConsulta: TRectangle;
    SpeedButton2: TSpeedButton;
    edtId: TEdit;
    procedure FormShow(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure imgIconeFlutuanteClick(Sender: TObject);
    procedure imgLupaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure AddPedido(id, atleta, posicao, status:string);

    procedure OpenMenu;
    procedure CloseMenu;


    { Private declarations }
  public
  procedure ListarTodosAtletas;
   procedure ListaSemConsulta;
    { Public declarations }
  end;

var
  FrmJogador: TFrmJogador;

implementation

{$R *.fmx}

uses UCadAtleta, DMGLOBAL;

procedure TFrmJogador.AddPedido(id, atleta, posicao, status:string);
var
  item: TListViewItem;
begin
   try
     item := lvAtletas.Items.Add;
     tagString := id;

     with item do
     begin
       Height := 90;

      //Id Atleta
      TListItemText(Objects.FindDrawable('txtID')).Text :=  id;

      TListItemText(Objects.FindDrawable('txtAtleta')).text := atleta;

      TListItemText(Objects.FindDrawable('txtPosicao')).text := posicao;

      TListItemText(Objects.FindDrawable('txtStatus')).text := status;

     // TListItemImage(Objects.FindDrawable('imgAtleta')).Bitmap.Assign(imgFoto.Bitmap);

     end;
   except on ex:exception do
    showMEssage('Erro ao inserir jogador na lista' + ex.Message );

   end;
end;

procedure TFrmJogador.ListaSemConsulta;
begin
  lvAtletas.BeginUpdate;
  lvAtletas.Items.Clear;

  with DMTABELAS.FDAtletas do begin
  active := false;
  SQL.Clear;
  SQL.ADD('select * from atletas order by id');
  active := true;

  while NOT DMTabelas.FDAtletas.eof do
  begin
  AddPedido(DMTABELAS.FDAtletas.fieldbyname('id').asString,
            DMTABELAS.FDAtletas.fieldbyname('atleta').asString,
            DMTABELAS.FDAtletas.fieldbyname('posicao').asString,
            DMTABELAS.FDAtletas.fieldbyname('status').asString);

            DMTabelas.FDAtletas.Next;
  end;
  end;

end;

procedure TFrmJogador.ListarTodosAtletas;
begin
    try
     DMTABELAS.ListarAtletas
               (edtId.Text,
                edtNome.text,
                cbPosicao.Selected.Text,
                cbStatus.Selected.Text
               );

     lvAtletas.BeginUpdate;
     lvAtletas.Items.Clear;

     while NOT DMTabelas.FDAtletas.eof do
     begin
      AddPedido(DMTABELAS.FDAtletas.fieldbyname('id').asString,
                DMTABELAS.FDAtletas.fieldbyname('atleta').asString,
                DMTABELAS.FDAtletas.fieldbyname('posicao').asString,
                DMTABELAS.FDAtletas.fieldbyname('status').asString);

             DMTabelas.FDAtletas.Next;
     end;

    except on ex:Exception do
      showMessage('Erro ao consultar pedido' + ex.Message);
    end;

    lvAtletas.EndUpdate;
end;
procedure TFrmJogador.FormShow(Sender: TObject);
begin
   ListaSemConsulta;
end;

procedure TFrmJogador.OpenMenu;
begin
    rectConsulta.Margins.Top := -150;
    lytOpacity.Visible := true;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', 0, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Quadratic);
end;

procedure TFrmJogador.SpeedButton1Click(Sender: TObject);
begin
    OpenMenu;
end;

procedure TFrmJogador.SpeedButton2Click(Sender: TObject);
begin
 CloseMenu;
 ListarTodosAtletas;
 edtId.Text := '';
 edtNome.Text := '';
end;

procedure TFrmJogador.CloseMenu;
begin
    rectConsulta.Margins.Top := 0;
    lytOpacity.Visible := false;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', -150, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Quadratic);

    TThread.CreateAnonymousThread(procedure
    begin
      sleep(500);
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        lytOpacity.Visible := false;
      end);


    end).Start;
end;

procedure TFrmJogador.imgLupaClick(Sender: TObject);
begin
    OpenMenu;
end;

procedure TFrmJogador.imgBackClick(Sender: TObject);
begin
  Close;
  lvAtletas.EndUpdate;
  cbPosicao.ItemIndex:= -1;
  cbStatus.ItemIndex := -1;
end;

procedure TFrmJogador.imgFecharClick(Sender: TObject);
begin
    CloseMenu;
end;

procedure TFrmJogador.imgIconeFlutuanteClick(Sender: TObject);
begin
   if NOT Assigned(FrmCadAtleta) then
        Application.CreateForm(TFrmCadAtleta, FrmCadAtleta);

    FrmCadAtleta.Show;

end;

end.
