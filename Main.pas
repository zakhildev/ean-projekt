unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, NewtonUtils,
  Vcl.NumberBox;

type
  TMainWindow = class(TForm)
    AuthorText: TStaticText;
    XNumBox: TNumberBox;
    XLabel: TLabel;
    YNumBox: TNumberBox;
    YLabel: TLabel;
    AddPointBtn: TButton;
    PointsList: TListBox;
    SectionLabel1: TLabel;
    RemovePointBtn: TButton;
    Button1: TButton;
    procedure OnEscKeyPress(Sender: TObject; var Key: Char);
    procedure AddPointBtnClick(Sender: TObject);
    procedure RemovePointBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    PointsX: TExtendedArray;
    PointsY: TExtendedArray;
    Coefficients: TExtendedArray;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure TMainWindow.OnEscKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
    Close;
end;

procedure TMainWindow.AddPointBtnClick(Sender: TObject);
begin
  var x: Extended := XNumBox.Value;
  var y: Extended := YNumBox.Value;
  PointsX := PointsX + [x];
  PointsY := PointsY + [y];
  PointsList.AddItem('(' + x.ToString() + '; ' + y.ToString() + ')', nil);
end;

procedure TMainWindow.RemovePointBtnClick(Sender: TObject);
begin
  if PointsList.ItemIndex = 0 then begin
    PointsX := Copy(PointsX, 1, High(PointsX));
    PointsY := Copy(PointsY, 1, High(PointsY));
  end
  else begin
    Delete(PointsX, PointsList.ItemIndex, PointsList.ItemIndex);
    Delete(PointsY, PointsList.ItemIndex, PointsList.ItemIndex);
  end;
  PointsList.DeleteSelected();
end;

procedure TMainWindow.Button1Click(Sender: TObject);
begin
  NewtonExtended(PointsX, PointsY, Coefficients);
  var buffer := '';
  for var i := 0 to High(Coefficients) do
  begin
    buffer := buffer + Coefficients[i].ToString();
    buffer := buffer + sLineBreak;
  end;
  MessageDlg(buffer, mtInformation, [mbOK], 0, mbOK);
end;

end.
