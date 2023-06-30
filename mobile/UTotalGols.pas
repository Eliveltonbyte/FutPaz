unit UTotalGols;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.DateTimeCtrls, FMX.Layouts, FMX.Ani;

type
  TFrmTotalGols = class(TForm)
    rectToolBar: TRectangle;
    lbToobar: TLabel;
    imgBack: TImage;
    imgLupa: TImage;
    SpeedButton1: TSpeedButton;
    lvTotalGols: TListView;
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
    procedure imgBackClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure CloseMenu;
    procedure OpenMenu;
    procedure AddGols(atleta, total: string);
    procedure ConstultaGols;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTotalGols: TFrmTotalGols;

implementation

{$R *.fmx}

uses DMGLOBAL;

procedure TFrmTotalGols.imgBackClick(Sender: TObject);
begin
    Close;
end;

procedure TFrmTotalGols.imgFecharClick(Sender: TObject);
begin
    CloseMenu;
end;

procedure TFrmTotalGols.SpeedButton1Click(Sender: TObject);
begin
    openMenu;
end;


procedure TFrmTotalGols.SpeedButton2Click(Sender: TObject);
begin
   if (dataDe.Date > 0 ) and (DataPara.Date > 0) then
   begin
    ConstultaGols;
    closeMenu;
   end;
end;

procedure TFrmTotalGols.OpenMenu;
begin
    rectConsulta.Margins.Top := -153;
    lytOpacity.Visible := true;
    TAnimator.AnimateFloat(rectConsulta, 'Margins.top', 0, 0.5,
                            TAnimationType.InOut,
                            TInterpolationType.Quadratic);
end;


procedure TFrmTotalGols.CloseMenu;
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

procedure TFrmTotalGols.AddGols(atleta, total :string);
var
  item: TListViewItem;
begin
   try
     item := lvTotalGols.Items.Add;

     with item do
     begin
       Height := 50;


      TListItemText(Objects.FindDrawable('txtAtleta')).Text :=  atleta;

      TListItemText(Objects.FindDrawable('txtTotal')).text := total;


     end;
   except on ex:exception do
    showMEssage('Erro ao inserir jogador na lista' + ex.Message );

   end;
end;

procedure TFrmTotalGols.ConstultaGols;
begin
  lvTotalGols.BeginUpdate;
  lvTotalGols.Items.Clear;

  with DMTABELAS.fdConsultaArt do begin
  active := false;
  SQL.Clear;
  SQL.ADD('SELECT atleta, sum(gols) as total FROM ARTILHARIA ');
  SQL.ADD(' where data BETWEEN :de and  :ate ' );
  SQL.ADD(' GROUP BY atleta ');
  SQL.ADD(' ORDER BY total DESC, atleta asc ');

  DMTABELAS.fdConsultaArt.ParamByName('de').Value
   := FormatDateTime('dd/mm/yyyy',dataDe.date);
  DMTABELAS.fdConsultaArt.ParamByName('ate').Value
  := FormatDateTime('dd/mm/yyyy',dataPara.date);

  active := true;


  while NOT DMTABELAS.fdConsultaArt.eof do
  begin
   AddGols(DMTABELAS.fdConsultaArt.fieldbyname('atleta').asString,
          DMTABELAS.fdConsultaArt.fieldbyname('total').asString);

          DMTABELAS.fdConsultaArt.Next;
  end;
  end;
  end;



procedure TFrmTotalGols.FormShow(Sender: TObject);
begin
  dataDe.Date := (Date);
  dataPara.Date := (Date);
end;

end.
