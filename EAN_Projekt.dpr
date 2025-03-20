program EAN_Projekt;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Skibidi},
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSkibidi, Skibidi);
  Application.Run;
end.
