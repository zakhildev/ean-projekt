program EAN_Projekt;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainWindow},
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas',
  NewtonUtils in 'NewtonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainWindow, MainWindow);
  Application.Run;
end.
