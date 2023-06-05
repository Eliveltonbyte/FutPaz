unit UCadAtleta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.ComboEdit;

type
  TFrmCadAtleta = class(TForm)
    rectToolBar: TRectangle;
    lbToobar: TLabel;
    lytPrincipal: TLayout;
    crImgAtleta: TCircle;
    edtAtleta: TEdit;
    imgAtleta: TImage;
    cbPosicao: TComboBox;
    imgVoltar: TImage;
    imgGoleiro: TImage;
    Layout1: TLayout;
    CBSTATUS: TComboBox;
    Rectangle1: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;

    procedure cbPosicaoEnter(Sender: TObject);
    procedure cbPosicaoGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure cbPosicaoTap(Sender: TObject; const Point: TPointF);
    procedure cbPosicaoExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAtleta: TFrmCadAtleta;

implementation

{$R *.fmx}

uses DMGLOBAL;

procedure TFrmCadAtleta.cbPosicaoEnter(Sender: TObject);
begin
    {    if cbPosicao.ItemIndex = 0  then
        begin
        imgAtleta.Visible := false;
        imgGoleiro.Visible := true
        end
        else if cbPosicao.ItemIndex >= 1  then
        begin
        imgAtleta.Visible := true;
        imgGoleiro.Visible := false;
        end;       }


end;





procedure TFrmCadAtleta.cbPosicaoExit(Sender: TObject);
begin
    if cbPosicao.ItemIndex = 0  then
        begin
        imgAtleta.Visible := false;
        imgGoleiro.Visible := true
        end
        else if cbPosicao.ItemIndex >= 1  then
        begin
        imgAtleta.Visible := true;
        imgGoleiro.Visible := false;
        end;
end;

procedure TFrmCadAtleta.cbPosicaoGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
   {  if cbPosicao.ItemIndex = 0  then
        begin
        imgAtleta.Visible := false;
        imgGoleiro.Visible := true
        end
        else if cbPosicao.ItemIndex >= 1  then
        begin
        imgAtleta.Visible := true;
        imgGoleiro.Visible := false;
        end; }
end;

procedure TFrmCadAtleta.cbPosicaoTap(Sender: TObject; const Point: TPointF);
begin
 if cbPosicao.ItemIndex = 0  then
        begin
        imgAtleta.Visible := false;
        imgGoleiro.Visible := true
        end
        else if cbPosicao.ItemIndex >= 1  then
        begin
        imgAtleta.Visible := true;
        imgGoleiro.Visible := false;
        end;
end;

procedure TFrmCadAtleta.SpeedButton1Click(Sender: TObject);
begin
    with DMTABELAS.FDAtletas do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('delete from tab_usuario');
      ExecSql;
    end;

    //Inserir Atletas...
    with DMTABELAS.FDAtletas do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('insert into atletas(id, atleta, posicao, status, foto)');
      SQL.Add('values(:id, :atleta, posicao, status, :foto )');

      ParamByName('id').value := '2';
      ParamByName('atleta').value := edtAtleta.Text;
      ParamByName('posicao').value := cbPosicao.ItemIndex;
      ParamByName('status').value := CBSTATUS.ItemIndex;
     // ParamByName('foto').Assing(imgAtleta.Bitmap);
      ExecSql;


    end;
end;

end.
