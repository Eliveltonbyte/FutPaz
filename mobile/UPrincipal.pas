unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TFrmPrincipal = class(TForm)
    rectToolBar: TRectangle;
    lbToobar: TLabel;
    Layout1: TLayout;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UJogadores;

procedure TFrmPrincipal.rectMenuJogadorClick(Sender: TObject);
begin
   if NOT Assigned(FrmJogador) then
      Application.CreateForm(TFrmJogador, FrmJogador);

    FrmJogador.Show;

end;

end.
