program FutPaz;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UJogadores in 'UJogadores.pas' {FrmJogador},
  UCadAtleta in 'UCadAtleta.pas' {FrmCadAtleta},
  DMGLOBAL in 'DataModules\DMGLOBAL.pas' {DMTABELAS: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmJogador, FrmJogador);
  Application.CreateForm(TFrmCadAtleta, FrmCadAtleta);
  Application.CreateForm(TDMTABELAS, DMTABELAS);
  Application.CreateForm(TDMTABELAS, DMTABELAS);
  Application.Run;
end.
