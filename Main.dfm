object MainWindow: TMainWindow
  Left = 0
  Top = 0
  Anchors = []
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Zadanie 2 - Wielomian Interpolacyjny Newtona'
  ClientHeight = 568
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnKeyPress = OnEscKeyPress
  TextHeight = 15
  object AuthorLabel: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 545
    Width = 608
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Piotr Blecharski 164306, grupa 107'
  end
  object Pages: TPageControl
    Left = 8
    Top = 8
    Width = 608
    Height = 531
    ActivePage = RealTab
    TabOrder = 0
    object RealTab: TTabSheet
      Caption = 'Liczby rzeczywiste'
      object SectionLabel1_Real: TLabel
        AlignWithMargins = True
        Left = -3
        Top = 3
        Width = 600
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
        Width = 594
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Caption = 'Obliczanie wsp'#243#322'czynnik'#243'w wielomianu'
      end
      object PointsList_Real: TListBox
        Left = 296
        Top = 24
        Width = 304
        Height = 114
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
      object XNumBox_Real: TNumberBox
        Left = 136
        Top = 24
        Width = 154
        Height = 23
        Decimal = 18
        Mode = nbmFloat
        TabOrder = 2
      end
      object YNumBox_Real: TNumberBox
        Left = 136
        Top = 53
        Width = 154
        Height = 23
        Decimal = 18
        Mode = nbmFloat
        TabOrder = 3
      end
      object AddPointBtn_Real: TButton
        Left = 3
        Top = 82
        Width = 287
        Height = 25
        Caption = 'Dodaj punkt'
        TabOrder = 4
        OnClick = AddPointBtn_RealClick
      end
      object ComputeCoefsBtn_Real: TButton
        Left = 3
        Top = 167
        Width = 594
        Height = 25
        Caption = 'Oblicz wsp'#243#322'czynniki'
        TabOrder = 5
        OnClick = ComputeCoefsBtn_RealClick
      end
      object CoefBox_Real: TListBox
        Left = 3
        Top = 198
        Width = 594
        Height = 114
        ItemHeight = 15
        TabOrder = 6
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ImageIndex = 1
    end
  end
end
