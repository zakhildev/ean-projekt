unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, NewtonUtils,
  Vcl.NumberBox, Vcl.ComCtrls, IntervalArithmetic32and64, StrUtils;

type
  TMainWindow = class(TForm)
    XLabel_Real: TLabel;
    YLabel_Real: TLabel;
    AddPointBtn_Real: TButton;
    PointsList_Real: TListBox;
    SectionLabel1_Real: TLabel;
    RemovePointBtn_Real: TButton;
    ComputeCoefsBtn_Real: TButton;
    Pages: TPageControl;
    RealTab: TTabSheet;
    AuthorLabel: TLabel;
    SectionLabel2_Real: TLabel;
    CoefBox_Real: TListBox;
    SectionLabel3_Real: TLabel;
    InterpolXLabel_Real: TLabel;
    Results_Real: TListBox;
    ComputeResultsBtn_Real: TButton;
    UnitTab: TTabSheet;
    ComputeResultsBtn_Unit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    RemovePointBtn_Unit: TButton;
    Label3: TLabel;
    PointsList_Unit: TListBox;
    ComputeCoefsBtn_Unit: TButton;
    Label4: TLabel;
    Results_Unit: TListBox;
    CoefBox_Unit: TListBox;
    AddPointBtn_Unit: TButton;
    Label5: TLabel;
    Label6: TLabel;
    GeneralTab: TTabSheet;
    ComputeResultsBtn_General: TButton;
    Label7: TLabel;
    Label8: TLabel;
    RemovePointBtn_General: TButton;
    Label9: TLabel;
    PointsList_General: TListBox;
    CoefBox_General: TListBox;
    Label10: TLabel;
    Results_General: TListBox;
    AddPointBtn_General: TButton;
    Label11: TLabel;
    Label12: TLabel;
    ComputeCoefsBtn_General: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    XNumBox_Real: TEdit;
    YNumBox_Real: TEdit;
    InterpolNumBoxX_Real: TEdit;
    XNumBox_Unit: TEdit;
    YNumBox_Unit: TEdit;
    InterpolNumBoxX_Unit: TEdit;
    XNumBoxLeft_General: TEdit;
    XNumBoxRight_General: TEdit;
    YNumBoxLeft_General: TEdit;
    YNumBoxRight_General: TEdit;
    InterpolNumBoxXLeft_General: TEdit;
    InterpolNumBoxXRight_General: TEdit;
    procedure OnEscKeyPress(Sender: TObject; var Key: Char);
    procedure AddPointBtn_RealClick(Sender: TObject);
    procedure RemovePointBtn_RealClick(Sender: TObject);
    procedure ComputeCoefsBtn_RealClick(Sender: TObject);
    procedure ComputeResultsBtn_RealClick(Sender: TObject);
    procedure AddPointBtn_UnitClick(Sender: TObject);
    procedure RemovePointBtn_UnitClick(Sender: TObject);
    procedure ComputeCoefsBtn_UnitClick(Sender: TObject);
    procedure OnRednderIntervalItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure OnMeasureIntervalItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ComputeResultsBtn_UnitClick(Sender: TObject);
    procedure AddPointBtn_GeneralClick(Sender: TObject);
    procedure RemovePointBtn_GeneralClick(Sender: TObject);
    procedure ComputeCoefsBtn_GeneralClick(Sender: TObject);
    procedure ComputeResultsBtn_GeneralClick(Sender: TObject);
  private
    PointsX_Real: TExtendedArray;
    PointsY_Real: TExtendedArray;
    Coefficients_Real: TExtendedArray;
    PointsX_Unit: TIntervalArray;
    PointsY_Unit: TIntervalArray;
    Coefficients_Unit: TIntervalArray;
    PointsX_General: TIntervalArray;
    PointsY_General: TIntervalArray;
    Coefficients_General: TIntervalArray;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure TMainWindow.OnMeasureIntervalItem(Control: TWinControl; Index: Integer; var Height: Integer);
begin
  Height := 35; // Wysokość elementu w TListBox
end;

procedure TMainWindow.OnRednderIntervalItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  OffsetY, OffsetX: Integer;
  IntervalStrings: TArray<string>;
  LineHeight: Integer;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect); // Wyczyszczenie zawartości TListBox

    OffsetX := 4;
    OffsetY := Rect.Top + 2;
    LineHeight := TextHeight('Hg');

    Bitmap := TBitmap((Control as TListBox).Items.Objects[Index]);
    if Assigned(Bitmap) then
    begin
      Draw(Rect.Left + OffsetX, OffsetY, Bitmap);
      OffsetX := OffsetX + Bitmap.Width + 6;
    end;

    IntervalStrings := (Control as TListBox).Items[Index].Split(['|']);
    if Length(IntervalStrings) > 0 then
      TextOut(Rect.Left + OffsetX, OffsetY, IntervalStrings[0]);
    if Length(IntervalStrings) > 1 then
      TextOut(Rect.Left + OffsetX, OffsetY + LineHeight, IntervalStrings[1]);
  end;
end;

procedure TMainWindow.OnEscKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
    Close;
end;

procedure TMainWindow.AddPointBtn_RealClick(Sender: TObject);
var
  x, y: String;
begin
  x := XNumBox_Real.Text;
  y := YNumBox_Real.Text;
  try
    PointsX_Real := PointsX_Real + [x.ToExtended];
    PointsY_Real := PointsY_Real + [y.ToExtended];
  except
    MessageDlg('Wprowadzone współrzędne (X lub Y) nie są liczbami!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  PointsList_Real.AddItem('(' + x + '; ' + y + ')', nil);
  XNumBox_Real.Text := '';
  YNumBox_Real.Text := '';
  Coefficients_Real := [];
  CoefBox_Real.Clear;
  Results_Real.Clear;
end;

procedure TMainWindow.RemovePointBtn_RealClick(Sender: TObject);
begin
  if PointsList_Real.ItemIndex = 0 then begin
    PointsX_Real := Copy(PointsX_Real, 1, High(PointsX_Real));
    PointsY_Real := Copy(PointsY_Real, 1, High(PointsY_Real));
  end
  else begin
    Delete(PointsX_Real, PointsList_Real.ItemIndex, PointsList_Real.ItemIndex);
    Delete(PointsY_Real, PointsList_Real.ItemIndex, PointsList_Real.ItemIndex);
  end;
  PointsList_Real.DeleteSelected();
  Coefficients_Real := [];
  CoefBox_Real.Clear;
  Results_Real.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_RealClick(Sender: TObject);
var
  status: Integer;
begin
  if (Length(PointsX_Real) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_Real.Clear;
  NewtonExtended(PointsX_Real, PointsY_Real, Coefficients_Real, status);
  for var i := Low(Coefficients_Real) to High(Coefficients_Real) do
  begin
    CoefBox_Real.AddItem('Współczynnik c' + i.ToString + ': ' + Coefficients_Real[i].ToString, nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_RealClick(Sender: TObject);
var
  InterpolResult: Extended;
  value: String;
  status: Integer;
begin
  if (Length(Coefficients_Real) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  value := InterpolNumBoxX_Real.Text;

  try
    value.ToExtended;
  except
    MessageDlg('Wprowadzona współrzędna nie jest liczbą!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  ComputeInterpolatedExtendedValue(value.ToExtended, PointsX_Real, Coefficients_Real, InterpolResult, status);
  Results_Real.AddItem('f('+ InterpolNumBoxX_Real.Text + ') = ' + InterPolResult.ToString, nil);
  InterpolNumBoxX_Real.Text := '';
end;

procedure TMainWindow.AddPointBtn_UnitClick(Sender: TObject);
var
  leftX, rightX, leftY, rightY: string;
  x, y: Interval;
begin
  try
    x := int_read(XNumBox_Unit.Text);
    y := int_read(YNumBox_Unit.Text);
  except
    MessageDlg('Wprowadzone współrzędne (X lub Y) nie są liczbami!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  PointsX_Unit := PointsX_Unit + [x];
  PointsY_Unit := PointsY_Unit + [y];
  iends_to_strings(x, leftX, rightX);
  iends_to_strings(y, leftY, rightY);
  PointsList_Unit.AddItem('X:[' + leftX + '; ' + rightX + '] |Y:['  + leftY + '; ' + rightY + ']', nil);
  XNumBox_Unit.Text := '';
  YNumBox_Unit.Text := '';
  Coefficients_Unit := [];
  CoefBox_Unit.Clear;
  Results_Unit.Clear;
end;

procedure TMainWindow.RemovePointBtn_UnitClick(Sender: TObject);
begin
  if PointsList_Unit.ItemIndex = 0 then begin
    PointsX_Unit := Copy(PointsX_Unit, 1, High(PointsX_Unit));
    PointsY_Unit := Copy(PointsY_Unit, 1, High(PointsY_Unit));
  end
  else begin
    Delete(PointsX_Unit, PointsList_Unit.ItemIndex, PointsList_Unit.ItemIndex);
    Delete(PointsY_Unit, PointsList_Unit.ItemIndex, PointsList_Unit.ItemIndex);
  end;
  PointsList_Unit.DeleteSelected();
  Coefficients_Unit := [];
  CoefBox_Unit.Clear;
  Results_Unit.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_UnitClick(Sender: TObject);
var
  left, right: string;
  status: Integer;
begin
  if (Length(PointsX_Unit) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_Unit.Clear;
  NewtonInterval(PointsX_Unit, PointsY_Unit, Coefficients_Unit, status);
  for var i := Low(Coefficients_Unit) to High(Coefficients_Unit) do
  begin
    iends_to_strings(Coefficients_Unit[i], left, right);
    CoefBox_Unit.AddItem('Współczynnik c' + i.ToString + ': [' + left + #13#10 + right + ']', nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_UnitClick(Sender: TObject);
var
  InterpolResult, InputInterval: Interval;
  inL, inR, outL, outR: string;
  status: Integer;
begin
  if (Length(Coefficients_Unit) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  try
    InputInterval := int_read(InterpolNumBoxX_Unit.Text);
  except
    MessageDlg('Wprowadzona współrzędna nie jest liczbą!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  iends_to_strings(InputInterval, inL, inR);
  ComputeInterpolatedIntervalValue(InputInterval, PointsX_Unit, Coefficients_Unit, InterpolResult, status);
  iends_to_strings(InterpolResult, outL, outR);
  Results_Unit.AddItem('f(['+ inL + '; ' + inR + ']) = [' + outL + '; ' + outR + ']   Szerokość: ' + int_width(InterpolResult).ToString, nil);
  InterpolNumBoxX_Unit.Text := '';
end;

procedure TMainWindow.AddPointBtn_GeneralClick(Sender: TObject);
var
  status: Integer;
  x, y: Interval;
  leftX, rightX, leftY, rightY: string;
begin
  try
    x.a := left_read(XNumBoxLeft_General.Text);
    x.b := right_read(XNumBoxRight_General.Text);
    y.a := left_read(YNumBoxLeft_General.Text);
    y.b := right_read(YNumBoxRight_General.Text);
  except
    MessageDlg('Wprowadzone współrzędne (X lub Y) nie są liczbami!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  if not (x.a <= x.b) then
  begin
    MessageDlg('Przedział współrzędnej X zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  if not (y.a <= y.b) then
  begin
    MessageDlg('Przedział współrzędnej Y zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  PointsX_General := PointsX_General + [x];
  PointsY_General := PointsY_General + [y];
  iends_to_strings(x, leftX, rightX);
  iends_to_strings(y, leftY, rightY);
  PointsList_General.AddItem('X:[' + leftX + '; ' + rightX + '] |Y:['  + leftY + '; ' + rightY + ']', nil);
  XNumBoxLeft_General.Text := '';
  XNumBoxRight_General.Text := '';
  YNumBoxLeft_General.Text := '';
  YNumBoxRight_General.Text := '';
  Coefficients_General := [];
  CoefBox_General.Clear;
  Results_General.Clear;
end;

procedure TMainWindow.RemovePointBtn_GeneralClick(Sender: TObject);
begin
  if PointsList_General.ItemIndex = 0 then begin
    PointsX_General := Copy(PointsX_General, 1, High(PointsX_General));
    PointsY_General := Copy(PointsY_General, 1, High(PointsY_General));
  end
  else begin
    Delete(PointsX_General, PointsList_General.ItemIndex, PointsList_General.ItemIndex);
    Delete(PointsY_General, PointsList_General.ItemIndex, PointsList_General.ItemIndex);
  end;
  PointsList_General.DeleteSelected();
  Coefficients_General := [];
  CoefBox_General.Clear;
  Results_General.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_GeneralClick(Sender: TObject);
var
  status: Integer;
  var left, right: string;
begin
  if (Length(PointsX_General) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_General.Clear;
  NewtonInterval(PointsX_General, PointsY_General, Coefficients_General, status);
  for var i := Low(Coefficients_General) to High(Coefficients_General) do
  begin
    iends_to_strings(Coefficients_General[i], left, right);
    CoefBox_General.AddItem('Współczynnik c' + i.ToString + ': [' + left + #13#10 + right + ']', nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_GeneralClick(Sender: TObject);
var
  InterpolResult, InputInterval: Interval;
  inL, inR, outL, outR: string;
  status: Integer;
begin
  if (Length(Coefficients_General) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  try
    InputInterval.a := left_read(InterpolNumBoxXLeft_General.Text);
    InputInterval.b := right_read(InterpolNumBoxXRight_General.Text);
  except
    MessageDlg('Wprowadzone końce przedziedziału współrzędnej nie są liczbami!', mtError, [mbOk], 0, mbOk);
    Exit;
  end;

  if not (InputInterval.a <= InputInterval.b) then
  begin
    MessageDlg('Przedział współrzędnej X wartości interpolowanej zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  iends_to_strings(InputInterval, inL, inR);
  ComputeInterpolatedIntervalValue(InputInterval, PointsX_General, Coefficients_General, InterpolResult, status);
  iends_to_strings(InterpolResult, outL, outR);
  Results_General.AddItem('f(['+ inL + '; ' + inR + ']) = [' + outL + '; ' + outR + ']   Szerokość: ' + int_width(InterpolResult).ToString, nil);
  InterpolNumBoxXLeft_General.Text := '';
  InterpolNumBoxXRight_General.Text := '';
end;

end.
