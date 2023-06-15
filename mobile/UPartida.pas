unit UPartida;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.TabControl, FMX.DateTimeCtrls;

type
  TFrmPartida = class(TForm)
    rectTolbarPartida: TRectangle;
    lbToobar: TLabel;
    imgBack: TImage;
    Image1: TImage;
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
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    spdCancelar: TSpeedButton;
    spdIniciar: TSpeedButton;
    procedure imgBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPartida: TFrmPartida;

implementation

{$R *.fmx}

procedure TFrmPartida.imgBackClick(Sender: TObject);
begin
  close;
end;

end.
