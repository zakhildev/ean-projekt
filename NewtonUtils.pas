unit NewtonUtils;

interface

uses
  IntervalArithmetic32and64, Dialogs, SysUtils;

type
  TExtendedArray = array of Extended;
  TIntervalArray = array of Interval;
  PExtedned = ^Extended;
  procedure NewtonExtended(x, y: TExtendedArray; var coefficients: TExtendedArray);
  procedure NewtonInterval(x, y: TIntervalArray; var coefficients: TIntervalArray);
  procedure ComputeInterpolatedExtendedValue(x, x0: Extended; coeffs: TExtendedArray; out output: Extended);
  procedure ComputeInterpolatedIntervalValue(x, x0: Interval; coeffs: TIntervalArray; out output: Interval);

implementation

procedure NewtonExtended(x, y: TExtendedArray; var coefficients: TExtendedArray);
var
  n, i, j: Integer;
  dividedDifferences: array of TExtendedArray;
begin
  n := Length(x);
  SetLength(dividedDifferences, n, n);
  SetLength(coefficients, n);

  // Wype³nienie pierwszej kolumny ró¿nic dzielonych wartoœciami y
  for i := 0 to n - 1 do
    dividedDifferences[i, 0] := y[i];

  // Obliczanie ró¿nic dzielonych
  for j := 1 to n - 1 do
    for i := 0 to n - j - 1 do
      dividedDifferences[i, j] := (dividedDifferences[i + 1, j - 1] - dividedDifferences[i, j - 1]) / (x[i + j] - x[i]);

  // Wspó³czynniki wielomianu Newtona
  for i := 0 to n - 1 do
    coefficients[i] := dividedDifferences[0, i];
end;

procedure NewtonInterval(x, y: TIntervalArray; var coefficients: TIntervalArray);
var
  n, i, j: Integer;
  dividedDifferences: array of TIntervalArray;
begin
  try
    n := Length(x);
    SetLength(dividedDifferences, n, n);
    SetLength(coefficients, n);

    // Wype³nienie pierwszej kolumny ró¿nic dzielonych wartoœciami y
    for i := 0 to n - 1 do
      dividedDifferences[i, 0] := y[i];

    // Obliczanie ró¿nic dzielonych
    for j := 1 to n - 1 do
      for i := 0 to n - j - 1 do
        dividedDifferences[i, j] := IDiv(ISub(dividedDifferences[i + 1, j - 1], dividedDifferences[i, j - 1]),
                                         ISub(x[i + j], x[i]));

    // Wspó³czynniki wielomianu Newtona
    for i := 0 to n - 1 do
      coefficients[i] := dividedDifferences[0, i];
  except
    on EZeroDivide do
    begin
      MessageDlg('B³¹d! Dzielenie przez przedzia³ zawieraj¹cy zero.', mtError, [mbOk], 0, mbOk);
      Exit;
    end;
  end;
end;

procedure ComputeInterpolatedExtendedValue(x, x0: Extended; coeffs: TExtendedArray; out output: Extended);
begin
  if (Length(coeffs) <= 0) then
  begin
    MessageDlg('Nie mo¿na obliczcyæ wartoœci interpolowanej, gdy nie obliczono wspó³czynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  var InterpolResult: Extended := 0;
  for var i := Low(coeffs) to High(coeffs) do
  begin
    if (i = 0) then
    begin
      InterpolResult := InterpolResult + coeffs[i];
      Continue;
    end;
    InterpolResult := InterpolResult + (coeffs[i] * (x - x0));
  end;
  output :=  InterpolResult;
end;

procedure ComputeInterpolatedIntervalValue(x, x0: Interval; coeffs: TIntervalArray; out output: Interval);
var
  InterpolResult: Interval;
begin
  if (Length(coeffs) <= 0) then
  begin
    MessageDlg('Nie mo¿na obliczcyæ wartoœci interpolowanej, gdy nie obliczono wspó³czynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  for var i := Low(coeffs) to High(coeffs) do
  begin
    if (i = 0) then
    begin
      InterpolResult := coeffs[i];
      Continue;
    end;
    InterpolResult := IAdd(InterpolResult, IMul(coeffs[i], ISub(x, x0)))
  end;
  output :=  InterpolResult;
end;

end.
