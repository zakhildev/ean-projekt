unit NewtonUtils;

interface

uses
  IntervalArithmetic32and64, Dialogs, SysUtils;

type
  TExtendedArray = array of Extended;
  TIntervalArray = array of Interval;
  procedure NewtonExtended(x, y: TExtendedArray; out coefficients: TExtendedArray; out status: Integer);
  procedure NewtonInterval(x, y: TIntervalArray; out coefficients: TIntervalArray; out status: Integer);
  procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended; out status: Integer);
  procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval; out status: Integer);

implementation

procedure NewtonExtended(x, y: TExtendedArray; out coefficients: TExtendedArray; out status: Integer);
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

  status := 0;
end;

procedure NewtonInterval(x, y: TIntervalArray; out coefficients: TIntervalArray; out status: Integer);
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
      status := 1;
      Exit;
    end;
  end;

  status := 0;
end;

procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended; out status: Integer);
var
  product: Extended;
begin
  if (Length(coeffs) = 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mo¿na obliczyæ wartoœci interpolowanej — niepoprawne dane wejœciowe!', mtError, [mbOK], 0);
    status := 1;
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    product := 1.0;
    for var j := 0 to i - 1 do
      product := product * (x - nodes[j]);
    output := output + coeffs[i] * product;
  end;

  status := 0;
end;

procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval; out status: Integer);
var
  InterpolResult, product: Interval;
begin
  if (Length(coeffs) <= 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mo¿na obliczcyæ wartoœci interpolowanej, gdy nie obliczono wspó³czynników!', mtError, [mbOK], 0, mbOK);
    status := 1;
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    product := int_read('1');
    for var j := 0 to i - 1 do
      product := IMul(product, ISub(x, nodes[j]));
    output := IAdd(output, IMul(coeffs[i], product));
  end;

  status := 0;
end;

end.
