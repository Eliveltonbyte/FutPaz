unit UCapaTotal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListBox, FMX.Edit,
  FMX.Layouts, FMX.DateTimeCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani;

type
  TFrmCapaTotal = class(TForm)
    rectToolBar: TRectangle;
    lbToobar: TLabel;
    imgBack: TImage;
    imgLupa: TImage;
    SpeedButton1: TSpeedButton;
    lvCapaTotal: TListView;
    lytOpacity: TLayout;
    rectOpacity: TRectangle;
    rectConsulta: TRectangle;
    imgFechar: TImage;
    rectBtnConsulta: TRectangle;
    SpeedButton2: TSpeedButton;
    lblDE: TLabel;
    lblAte: TLabel;
    dataDe: TDateEdit;
    dataPara: TDateEdit;
    procedure imgFecharClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dataDeChange(Sender: TObject);
    procedure imgBackClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure lytOpacityTap(Sender: TObject; const Point: TPointF);
    procedure lytOpacityClick(Sender: TObject);
  private
    procedure OpenMenu;
    procedure CloseMenu;
    procedure AddCapa(atleta, total: string);
    procedure ConsultaCapa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCapaTotal: TFrmCapaTotal;

implementation

{$R *.fmx}

uses DMGLOBAL;

procedure TFrmCapaTotal.dataDeChange(Sender: TObject);
begin
     dataPara.Date := dataDe.Date + 30;
end;

procedure TFrmCapaTotal.FormShow(Sender: TObject);
begin
 dataPara.Date := (Date);
 dataDe.Date := (Date);
end;

procedure TFrmCapaTotal.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCapaTotal.imgFecharClick(Sender: TObject);
begin
    CloseMenu;
end;

procedure TFrmCapaTotal.lytOpacityClick(Sender: TObject);
begin
    CloseMenu;
end;

procedure TFrmCapaTotal.lytOpacityTap(Sender: TObject; const Point: TPointF);
begin
    CloseMenu;
end;

procedure TFrmCapaTotal.SpeedButton1Click(Sender: TObject);
begin
  OpenMenu;

end;

procedure TFrmCapaTotal.SpeedButton2Click(Sender: TObject);
begin
   if (dataDe.Date > 0 ) and (DataPara.Date > 0) then
   begin
    ConsultaCapa;
    closeMenu;
   end;
end;

procedure TFrmCapaTotal.OpenMenu;
begin
     rectConsulta.Margins.Top := -153;
    lytOpacity.Visible := true;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', 0, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Quadratic);
end;


procedure TFrmCapaTotal.CloseMenu;
begin
    rectConsulta.Margins.Top := 0;
    lytOpacity.Visible := false;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', -153, 0.5,
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

 //jogar no listView
 procedure TFrmCapaTotal.AddCapa(atleta, total :string);
var
  item: TListViewItem;
begin
   try
     item := lvCapaTotal.Items.Add;


     with item do
     begin
       Height := 50;

      //Id Atleta
      TListItemText(Objects.FindDrawable('txtAtleta')).Text :=  atleta;

      TListItemText(Objects.FindDrawable('txtTotal')).text := total;


     end;
   except on ex:exception do
    showMEssage('Erro ao inserir jogador na lista' + ex.Message );

   end;
end;

procedure TFrmCapaTotal.ConsultaCapa;
begin
  lvCapaTotal.BeginUpdate;
  lvCapaTotal.Items.Clear;

  with DMTABELAS.fdConsultaCapa do begin
  active := false;
  SQL.Clear;
  SQL.ADD('SELECT atleta, count(id_atleta) as total FROM capa ');
  SQL.ADD(' where data BETWEEN :de and  :ate ' );
  SQL.ADD(' GROUP BY atleta ');
  SQL.ADD(' ORDER BY total DESC, atleta asc ');

  DMTABELAS.fdConsultaCapa.ParamByName('de').Value
   := FormatDateTime('dd/mm/yyyy',dataDe.date);
  DMTABELAS.fdConsultaCapa.ParamByName('ate').Value
  := FormatDateTime('dd/mm/yyyy',dataPara.date);

  active := true;


  while NOT DMTabelas.fdConsultaCapa.eof do
  begin
  AddCapa(DMTABELAS.fdConsultaCapa.fieldbyname('atleta').asString,
          DMTABELAS.fdConsultaCapa.fieldbyname('total').asString);

          DMTabelas.fdConsultaCapa.Next;
  end;
  end;
end;


end.
