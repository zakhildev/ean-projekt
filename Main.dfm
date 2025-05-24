object MainWindow: TMainWindow
  Left = 531
  Top = 187
  Anchors = []
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Zadanie 2 - Wielomian Interpolacyjny Newtona'
  ClientHeight = 673
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  OnKeyPress = OnEscKeyPress
  TextHeight = 15
  object AuthorLabel: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 648
    Width = 843
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Piotr Blecharski 164306, grupa 107'
  end
  object Pages: TPageControl
    Left = 8
    Top = 8
    Width = 843
    Height = 625
    ActivePage = RealTab
    TabOrder = 0
    object RealTab: TTabSheet
      Caption = 'Liczby rzeczywiste'
      object SectionLabel1_Real: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dodawanie punkt'#243'w'
      end
      object XLabel_Real: TLabel
        Left = 8
        Top = 24
        Width = 122
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna X punktu:'
      end
      object YLabel_Real: TLabel
        Left = 8
        Top = 53
        Width = 122
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna Y punktu:'
      end
      object SectionLabel2_Real: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 144
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w wielomianu'
      end
      object SectionLabel3_Real: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 318
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie warto'#347'ci interpolowanych'
      end
      object InterpolXLabel_Real: TLabel
        Left = 8
        Top = 348
        Width = 215
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna X punktu interpolowanego:'
      end
      object PointsList_Real: TListBox
        Left = 296
        Top = 24
        Width = 536
        Height = 114
        Style = lbOwnerDrawFixed
        ItemHeight = 15
        TabOrder = 0
      end
      object RemovePointBtn_Real: TButton
        Left = 3
        Top = 113
        Width = 287
        Height = 25
        Caption = 'Usu'#324' punkt'
        TabOrder = 1
        OnClick = RemovePointBtn_RealClick
      end
      object AddPointBtn_Real: TButton
        Left = 3
        Top = 82
        Width = 287
        Height = 25
        Caption = 'Dodaj punkt'
        TabOrder = 2
        OnClick = AddPointBtn_RealClick
      end
      object ComputeCoefsBtn_Real: TButton
        Left = 3
        Top = 167
        Width = 829
        Height = 25
        Caption = 'Oblicz wsp'#243#322'czynniki'
        TabOrder = 3
        OnClick = ComputeCoefsBtn_RealClick
      end
      object CoefBox_Real: TListBox
        Left = 3
        Top = 198
        Width = 829
        Height = 114
        ItemHeight = 15
        TabOrder = 4
      end
      object InterpolNumBoxX_Real: TNumberBox
        Left = 229
        Top = 348
        Width = 603
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 5
      end
      object Results_Real: TListBox
        Left = 3
        Top = 408
        Width = 829
        Height = 184
        ItemHeight = 15
        TabOrder = 6
      end
      object ComputeResultsBtn_Real: TButton
        Left = 3
        Top = 377
        Width = 829
        Height = 25
        Caption = 'Oblicz warto'#347#263' interpolowan'#261
        TabOrder = 7
        OnClick = ComputeResultsBtn_RealClick
      end
      object XNumBox_Real: TNumberBox
        Left = 136
        Top = 24
        Width = 154
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 8
      end
      object YNumBox_Real: TNumberBox
        Left = 136
        Top = 53
        Width = 154
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 9
      end
    end
    object UnitTab: TTabSheet
      Caption = 'Przedzia'#322'y punktowe'
      ImageIndex = 1
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 318
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie warto'#347'ci interpolowanych'
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dodawanie punkt'#243'w'
      end
      object Label3: TLabel
        Left = 8
        Top = 348
        Width = 215
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna X punktu interpolowanego:'
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 144
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w wielomianu'
      end
      object Label5: TLabel
        Left = 8
        Top = 53
        Width = 122
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna Y punktu:'
      end
      object Label6: TLabel
        Left = 8
        Top = 24
        Width = 122
        Height = 15
        Caption = 'Wsp'#243#322'rz'#281'dna X punktu:'
      end
      object ComputeResultsBtn_Unit: TButton
        Left = 3
        Top = 377
        Width = 829
        Height = 25
        Caption = 'Oblicz warto'#347#263' interpolowan'#261
        TabOrder = 0
        OnClick = ComputeResultsBtn_UnitClick
      end
      object RemovePointBtn_Unit: TButton
        Left = 3
        Top = 113
        Width = 287
        Height = 25
        Caption = 'Usu'#324' punkt'
        TabOrder = 1
        OnClick = RemovePointBtn_UnitClick
      end
      object YNumBox_Unit: TNumberBox
        Left = 136
        Top = 53
        Width = 154
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 2
      end
      object PointsList_Unit: TListBox
        Left = 296
        Top = 24
        Width = 536
        Height = 114
        Style = lbOwnerDrawVariable
        ItemHeight = 15
        TabOrder = 3
        OnDrawItem = OnRednderIntervalItem
        OnMeasureItem = OnMeasureIntervalItem
      end
      object ComputeCoefsBtn_Unit: TButton
        Left = 3
        Top = 167
        Width = 829
        Height = 25
        Caption = 'Oblicz wsp'#243#322'czynniki'
        TabOrder = 4
        OnClick = ComputeCoefsBtn_UnitClick
      end
      object InterpolNumBoxX_Unit: TNumberBox
        Left = 229
        Top = 348
        Width = 603
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 5
        NegativeValueColor = clBlack
      end
      object Results_Unit: TListBox
        Left = 3
        Top = 408
        Width = 829
        Height = 184
        ItemHeight = 15
        TabOrder = 6
      end
      object CoefBox_Unit: TListBox
        Left = 3
        Top = 198
        Width = 829
        Height = 114
        ItemHeight = 15
        TabOrder = 7
      end
      object AddPointBtn_Unit: TButton
        Left = 3
        Top = 82
        Width = 287
        Height = 25
        Caption = 'Dodaj punkt'
        TabOrder = 8
        OnClick = AddPointBtn_UnitClick
      end
      object XNumBox_Unit: TNumberBox
        Left = 136
        Top = 24
        Width = 154
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 9
      end
    end
    object GeneralTab: TTabSheet
      Caption = 'Przedzia'#322'y zwyk'#322'e'
      ImageIndex = 2
      object Label7: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 318
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie warto'#347'ci interpolowanych'
      end
      object Label8: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dodawanie punkt'#243'w'
      end
      object Label9: TLabel
        Left = 8
        Top = 348
        Width = 340
        Height = 15
        Caption = 'Lewy koniec przedzia'#322'u wsp'#243#322'rz'#281'dnej X punktu interpolowanego:'
      end
      object Label10: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 144
        Width = 829
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w wielomianu'
      end
      object Label11: TLabel
        Left = 8
        Top = 53
        Width = 180
        Height = 15
        Caption = 'Prawy koniec przedzia'#322'u X punktu:'
      end
      object Label12: TLabel
        Left = 8
        Top = 24
        Width = 175
        Height = 15
        Caption = 'Lewy koniec przedzia'#322'u X punktu:'
      end
      object Label13: TLabel
        Left = 8
        Top = 84
        Width = 175
        Height = 15
        Caption = 'Lewy koniec przedzia'#322'u Y punktu:'
      end
      object Label14: TLabel
        Left = 8
        Top = 113
        Width = 180
        Height = 15
        Caption = 'Prawy koniec przedzia'#322'u Y punktu:'
      end
      object Label15: TLabel
        Left = 8
        Top = 377
        Width = 345
        Height = 15
        Caption = 'Prawy koniec przedzia'#322'u wsp'#243#322'rz'#281'dnej X punktu interpolowanego:'
      end
      object XNumBoxLeft_General: TNumberBox
        Left = 194
        Top = 24
        Width = 149
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 0
      end
      object ComputeResultsBtn_General: TButton
        Left = 3
        Top = 406
        Width = 829
        Height = 25
        Caption = 'Oblicz warto'#347#263' interpolowan'#261
        TabOrder = 1
        OnClick = ComputeResultsBtn_GeneralClick
      end
      object RemovePointBtn_General: TButton
        Left = 592
        Top = 113
        Width = 240
        Height = 25
        Caption = 'Usu'#324' punkt'
        TabOrder = 2
        OnClick = RemovePointBtn_GeneralClick
      end
      object XNumBoxRight_General: TNumberBox
        Left = 194
        Top = 53
        Width = 149
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 3
      end
      object PointsList_General: TListBox
        Left = 349
        Top = 24
        Width = 483
        Height = 83
        Style = lbOwnerDrawVariable
        ItemHeight = 15
        TabOrder = 4
        OnDrawItem = OnRednderIntervalItem
        OnMeasureItem = OnMeasureIntervalItem
      end
      object CoefBox_General: TListBox
        Left = 3
        Top = 198
        Width = 829
        Height = 114
        ItemHeight = 15
        TabOrder = 5
      end
      object InterpolNumBoxXLeft_General: TNumberBox
        Left = 359
        Top = 348
        Width = 473
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 6
      end
      object Results_General: TListBox
        Left = 3
        Top = 437
        Width = 829
        Height = 155
        ItemHeight = 15
        TabOrder = 7
      end
      object AddPointBtn_General: TButton
        Left = 349
        Top = 113
        Width = 240
        Height = 25
        Caption = 'Dodaj punkt'
        TabOrder = 8
        OnClick = AddPointBtn_GeneralClick
      end
      object ComputeCoefsBtn_General: TButton
        Left = 3
        Top = 167
        Width = 829
        Height = 25
        Caption = 'Oblicz wsp'#243#322'czynniki'
        TabOrder = 9
        OnClick = ComputeCoefsBtn_GeneralClick
      end
      object YNumBoxLeft_General: TNumberBox
        Left = 194
        Top = 84
        Width = 149
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 10
      end
      object YNumBoxRight_General: TNumberBox
        Left = 194
        Top = 113
        Width = 149
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 11
      end
      object InterpolNumBoxXRight_General: TNumberBox
        Left = 359
        Top = 377
        Width = 473
        Height = 23
        Decimal = 20
        Mode = nbmFloat
        TabOrder = 12
      end
    end
  end
end
