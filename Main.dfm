object MainWindow: TMainWindow
  Left = 0
  Top = 0
  Anchors = []
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Zadanie 2 - Wielomian Interpolacyjny Newtona'
  ClientHeight = 683
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
  object XLabel: TLabel
    Left = 8
    Top = 64
    Width = 122
    Height = 15
    Caption = 'Wsp'#243#322'rz'#281'dna X punktu:'
  end
  object YLabel: TLabel
    Left = 8
    Top = 90
    Width = 122
    Height = 15
    Caption = 'Wsp'#243#322'rz'#281'dna Y punktu:'
  end
  object SectionLabel1: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 33
    Width = 600
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Dodawanie punkt'#243'w'
  end
  object AuthorText: TStaticText
    Left = 8
    Top = 8
    Width = 165
    Height = 19
    Caption = 'Piotr Blecharski 164306, gr. 107'
    TabOrder = 0
  end
  object XNumBox: TNumberBox
    Left = 136
    Top = 61
    Width = 121
    Height = 23
    Decimal = 18
    Mode = nbmFloat
    TabOrder = 1
  end
  object YNumBox: TNumberBox
    Left = 136
    Top = 85
    Width = 121
    Height = 23
    Decimal = 18
    Mode = nbmFloat
    TabOrder = 2
  end
  object AddPointBtn: TButton
    Left = 8
    Top = 138
    Width = 249
    Height = 25
    Caption = 'Dodaj punkt'
    TabOrder = 3
    OnClick = AddPointBtnClick
  end
  object PointsList: TListBox
    Left = 263
    Top = 54
    Width = 345
    Height = 78
    ItemHeight = 15
    TabOrder = 4
  end
  object RemovePointBtn: TButton
    Left = 263
    Top = 138
    Width = 345
    Height = 25
    Caption = 'Usu'#324' punkt'
    TabOrder = 5
    OnClick = RemovePointBtnClick
  end
  object Button1: TButton
    Left = 80
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Oblicz wielomian'
    TabOrder = 6
    OnClick = Button1Click
  end
end
