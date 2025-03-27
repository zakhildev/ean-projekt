unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, NewtonUtils;

type
  TMainWindow = class(TForm)
    InputTypeRadioGroup: TRadioGroup;
    AuthorText: TStaticText;
    foc: TListBox;
    PunktyLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    NewXLabel: TLabel;
    NewYLabel: TLabel;
    Edit3: TEdit;
    OutLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

end.
