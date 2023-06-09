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
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
    procedure LimparCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAtleta: TFrmCadAtleta;

implementation

{$R *.fmx}

uses DMGLOBAL, UJogadores;

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

procedure TFrmCadAtleta.FormShow(Sender: TObject);
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

procedure TFrmCadAtleta.imgVoltarClick(Sender: TObject);
begin
    Close;
    LimparCampos;
   FrmJogador.ListaSemConsulta;
end;

procedure TFrmCadAtleta.LimparCampos;
begin
    edtAtleta.Text := '';
    cbPosicao.ItemIndex := -1;
    CBSTATUS.ItemIndex := -1;
end;

procedure TFrmCadAtleta.SpeedButton1Click(Sender: TObject);
begin
  {  with DMTABELAS.FDAtletas do
        begin
               Active := false;
                      SQL.Clear;
                             SQL.Add('delete from atletas');
                                    ExecSql;
                                           end;}

    //Inserir Atletas...
    with DMTABELAS.FDAtletas do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('insert into atletas(atleta, posicao, status)');
      SQL.Add('values( :atleta, :posicao, :status )');

     // ParamByName('id').value := '5';
      ParamByName('atleta').value := edtAtleta.Text;
      ParamByName('posicao').value := cbPosicao.Selected.Text;
      ParamByName('status').value := CBSTATUS.Selected.Text;

      ExecSql;

      ShowMessage('Atleta Cadastrado com Sucesso!!');

      LimparCampos;




    end;
end;

end.
