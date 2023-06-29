program FutPaz;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UJogadores in 'UJogadores.pas' {FrmJogador},
  UCadAtleta in 'UCadAtleta.pas' {FrmCadAtleta},
  DMGLOBAL in 'DataModules\DMGLOBAL.pas' {DMTABELAS: TDataModule},
  UPartida in 'UPartida.pas' {FrmPartida},
  UCapaTotal in 'UCapaTotal.pas' {FrmCapaTotal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmJogador, FrmJogador);
  Application.CreateForm(TFrmCadAtleta, FrmCadAtleta);
  Application.CreateForm(TDMTABELAS, DMTABELAS);
  Application.CreateForm(TDMTABELAS, DMTABELAS);
  Application.CreateForm(TFrmPartida, FrmPartida);
  Application.CreateForm(TFrmCapaTotal, FrmCapaTotal);
  Application.Run;
end.
