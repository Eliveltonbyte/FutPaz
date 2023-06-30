unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TFrmPrincipal = class(TForm)
    rectToolBar: TRectangle;
    lbToobar: TLabel;
    lytPrincipal: TLayout;
    rectMenuJogador: TRectangle;
    lbTituloMenu: TLabel;
    lblDescinfo: TLabel;
    crImage: TCircle;
    imgJogador: TImage;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Circle1: TCircle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    Circle2: TCircle;
    Image2: TImage;
    Rectangle3: TRectangle;
    Label5: TLabel;
    Label6: TLabel;
    Circle3: TCircle;
    Image3: TImage;
    procedure rectMenuJogadorClick(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UJogadores, UPartida, UCapaTotal, UCadAtleta, UTotalGols;

procedure TFrmPrincipal.Rectangle1Click(Sender: TObject);
begin
  if NOT Assigned(FrmPartida) then
    Application.CreateForm(TFrmPartida, FrmPartida);

  FrmPartida.Show;
  FrmPartida.tbControl.gotovisibletab(0);
end;

procedure TFrmPrincipal.Rectangle2Click(Sender: TObject);
begin
  if NOT Assigned(FrmCapaTotal) then
    Application.CreateForm(TFrmCapaTotal, FrmCapaTotal);

  FrmCapaTotal.Show;
end;

procedure TFrmPrincipal.Rectangle3Click(Sender: TObject);
begin
  if NOT Assigned(FrmTotalGols) then
    Application.CreateForm(TFrmTotalGols, FrmTotalGols);

    FrmTotalGols.Show;
end;

procedure TFrmPrincipal.rectMenuJogadorClick(Sender: TObject);
begin
  if NOT Assigned(FrmJogador) then
    Application.CreateForm(TFrmJogador, FrmJogador);

  FrmJogador.Show;

end;

end.
