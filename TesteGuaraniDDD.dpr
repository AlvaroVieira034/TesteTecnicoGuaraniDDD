program TesteGuaraniDDD;

uses
  Vcl.Forms,
  umain in 'Presentation\Views\umain.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
