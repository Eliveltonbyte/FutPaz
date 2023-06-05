unit UJogadores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrmJogador = class(TForm)
    rectTolbarJogador: TRectangle;
    lbToobar: TLabel;
    Image1: TImage;
    Image2: TImage;
    lvAtletas: TListView;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AddPedido(id, atleta, posicao, status:string);
    procedure ListarTodosAtletas;

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
  AddPedido('0001','Elivelton Carneiro ','Zagueiro','Ativo');
  AddPedido('0002','Jo�o Guilherme','Meio-Campo','Ativo');
  AddPedido('0003','Jos� Silva','Atacante','Ativo');
  AddPedido('0004','Mateus Jesus','Goleiro','Ativo');
  AddPedido('0005','Otavio Ferreira','Zagueiro','Desligado');
end;
procedure TFrmJogador.FormShow(Sender: TObject);
begin
    ListarTodosAtletas;
end;

procedure TFrmJogador.Image1Click(Sender: TObject);
begin
      if NOT Assigned(FrmCadAtleta) then
        Application.CreateForm(TFrmCadAtleta, FrmCadAtleta);

    FrmCadAtleta.Show;

end;

end.
