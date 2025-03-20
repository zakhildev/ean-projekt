unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IntervalArithmetic32and64;

type
  TSkibidi = class(TForm)
    InputTypeRadioGroup: TRadioGroup;
    AuthorText: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Skibidi: TSkibidi;

implementation

{$R *.dfm}

end.
