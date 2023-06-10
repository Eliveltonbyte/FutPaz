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
    procedure FormShow(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure imgIconeFlutuanteClick(Sender: TObject);
    procedure imgLupaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
  private
    procedure AddPedido(id, atleta, posicao, status:string);
    procedure ListarTodosAtletas;
    procedure OpenMenu;
    procedure CloseMenu;

    { Private declarations }
  public
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

     with item do
     begin
       Height := 90;
       TagString := id;
      //Id Atleta
      TListItemText(Objects.FindDrawable('txtID')).text := id;

      TListItemText(Objects.FindDrawable('txtAtleta')).text := atleta;

      TListItemText(Objects.FindDrawable('txtPosicao')).text := posicao;

      TListItemText(Objects.FindDrawable('txtStatus')).text := status;

     // TListItemImage(Objects.FindDrawable('imgAtleta')).Bitmap.Assign(imgFoto.Bitmap);

     end;
   except on ex:exception do
    showMEssage('Erro ao inserir jogador na lista' + ex.Message );

   end;
end;

procedure TFrmJogador.ListarTodosAtletas;
begin
  AddPedido('0001','Elivelton Carneiro','Zagueiro','Ativo');
  AddPedido('0002','João Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','José Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
  AddPedido('0001','Elivelton Carneiro ','Zagueiro','Ativo');
  AddPedido('0002','João Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','José Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
  AddPedido('0001','Elivelton Carneiro ','Zagueiro','Ativo');
  AddPedido('0002','João Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','José Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
  AddPedido('0001','Elivelton Carneiro ','Zagueiro','Ativo');
  AddPedido('0002','João Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','José Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
  AddPedido('0001','Elivelton Carneiro ','Zagueiro','Ativo');
  AddPedido('0002','João Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','José Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
end;
procedure TFrmJogador.FormShow(Sender: TObject);
begin
    ListarTodosAtletas;
    //
end;

procedure TFrmJogador.OpenMenu;
begin
    rectConsulta.Margins.Top := -125;
    lytOpacity.Visible := true;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', 0, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Quadratic);
end;

procedure TFrmJogador.SpeedButton1Click(Sender: TObject);
begin
    OpenMenu;
end;

procedure TFrmJogador.CloseMenu;
begin
    rectConsulta.Margins.Top := 0;
    lytOpacity.Visible := false;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', -125, 0.5,
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
